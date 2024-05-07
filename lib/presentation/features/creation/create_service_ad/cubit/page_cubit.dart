import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/data/datasource/network/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/repositories/user_address_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/mappers/user_mapper.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';
import 'package:onlinebozor/presentation/utils/compressing_exts.dart';
import 'package:onlinebozor/presentation/utils/xfile_exts.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._adCreationRepository,
    this._userRepository,
    this._userAddressRepository,
  ) : super(const PageState());

  final AdCreationRepository _adCreationRepository;
  final UserRepository _userRepository;
  final UserAddressRepository _userAddressRepository;

  void setInitialParams(int? adId) {
    updateState((state) => state.copyWith(
          adId: adId,
          isEditing: adId != null,
          isNotPrepared: adId != null,
        ));

    if (states.isEditing) {
      getEditingInitialData();
    } else {
      getCreatingInitialData();
    }
  }

  Future<void> getCreatingInitialData() async {
    final user = _userRepository.getSavedUser();
    updateState((state) => state.copyWith(
          contactPerson: user?.fullName?.capitalizePersonName() ?? "",
          phone: user?.mobilePhone?.clearPhoneWithoutCode() ?? "",
          email: user?.email ?? "",
        ));

    if (states.isFirstTime) {
      updateState((state) => state.copyWith(isFirstTime: false));
      final address = await _userAddressRepository.getSavedUserAddresses();
      final mainAddress = address.firstIf((e) => e.isMain);
      if (mainAddress != null) {
        setSelectedAddress(mainAddress);
      }
    }
  }

  Future<void> getEditingInitialData() async {
    updateState((state) => state.copyWith(isPreparingInProcess: true));
    try {
      final ad =
          await _adCreationRepository.getServiceAdForEdit(adId: states.adId!);

      updateState((state) => state.copyWith(
            isNotPrepared: false,
            isPreparingInProcess: false,
            title: ad.name ?? "",
            category: ad.getSubCategory(),
            pickedImages: ad.getPhotos(),
            desc: ad.description ?? "",
            toPrice: ad.toPrice,
            fromPrice: ad.fromPrice,
            currency: ad.getCurrency(),
            paymentTypes: ad.getPaymentTypes(),
            isBusiness: ad.getIsBusiness(),
            isAgreedPrice: ad.isContract ?? false,
            address: ad.getUserAddress()?.toAddress(),
            serviceDistricts: ad.getServiceDistricts(),
            contactPerson: ad.contactName ?? "",
            phone: ad.phoneNumber?.clearPhoneWithoutCode() ?? "",
            email: ad.email ?? "",
            isAutoRenewal: ad.isAutoRenew ?? false,
            videoUrl: ad.video ?? "",
            isShowMySocialAccount: ad.showSocial ?? false,
          ));
    } catch (e) {
      logger.w("getEditingInitialData error = $e");
      updateState((state) => state.copyWith(
            isPreparingInProcess: false,
            isNotPrepared: true,
          ));
    }
  }

  Future<void> createOrUpdateServiceAd() async {
    updateState((state) => state.copyWith(isRequestSending: true));

    await uploadImages();

    try {
      final adId = await _adCreationRepository.createOrUpdateServiceAd(
        adId: states.adId,
        //
        title: states.title,
        categoryId: states.category!.id,
        serviceCategoryId: states.category!.parent_id ?? states.category!.id,
        serviceSubCategoryId: states.category!.id,
        //
        mainImageId: states.pickedImages!.map((e) => e.id).first!,
        pickedImageIds: states.pickedImages!.map((e) => e.id!).toList(),
        //
        desc: states.desc,
        fromPrice: states.fromPrice!,
        toPrice: states.toPrice!,
        currency: states.currency!,
        paymentTypes: states.paymentTypes!,
        isAgreedPrice: states.isAgreedPrice,
        //
        accountType: states.isBusiness ? "BUSINESS" : "PRIVATE",
        serviceDistricts: states.serviceDistricts,
        //
        address: states.address!,
        contactPerson: states.contactPerson,
        phone: states.phone.clearPhoneWithCode(),
        email: states.email,
        //
        isAutoRenewal: states.isAutoRenewal,
        isShowMySocialAccount: states.isShowMySocialAccount,
        videoUrl: states.videoUrl,
      );

      updateState((state) => state.copyWith(isRequestSending: false));
      if (!states.isEditing) {
        updateState((state) => state.copyWith(adId: adId));
      }
      emitEvent(PageEvent(PageEventType.onAdCreated));
    } catch (exception) {
      logger.e(exception.toString());
      updateState((state) => state.copyWith(isRequestSending: false));
    }
  }

  Future<void> uploadImages() async {
    final hasNotUploadedImages =
        states.pickedImages?.any((e) => e.isNotUploaded()) ?? false;

    if (hasNotUploadedImages) {
      var images = states.pickedImages ?? [];
      try {
        for (var image in images) {
          if (image.isUploaded()) continue;

          final uploadableFile = await _adCreationRepository.uploadImage(image);
          image.id = uploadableFile.id;
        }
      } catch (exception) {
        logger.e(exception.toString());
        updateState((state) => state.copyWith(isRequestSending: false));
      } finally {
        updateState((state) => state.copyWith(pickedImages: images));
      }
    }
  }

  void setEnteredTitle(String title) {
    updateState((state) => state.copyWith(title: title));
  }

  void setSelectedCategory(CategoryResponse category) {
    updateState((state) => state.copyWith(category: category));
  }

  void setEnteredDesc(String desc) {
    updateState((state) => state.copyWith(desc: desc));
  }

  void setEnteredFromPrice(String price) {
    int? priceInt = int.tryParse(price.clearPrice());
    updateState((state) => state.copyWith(fromPrice: priceInt));
  }

  void setEnteredToPrice(String price) {
    int? priceInt = int.tryParse(price.clearPrice());
    updateState((state) => state.copyWith(toPrice: priceInt));
  }

  void setSelectedCurrency(Currency currency) {
    updateState((state) => state.copyWith(currency: currency));
  }

  void setSelectedPaymentTypes(
    List<PaymentTypeResponse>? selectedPaymentTypes,
  ) {
    try {
      if (selectedPaymentTypes != null) {
        var paymentTypes = List<PaymentTypeResponse>.from(states.paymentTypes);
        paymentTypes.clear();

        if (selectedPaymentTypes.isNotEmpty) {
          paymentTypes.addAll(selectedPaymentTypes);
          paymentTypes = paymentTypes.toSet().toList();
        }

        updateState((state) => state.copyWith(paymentTypes: paymentTypes));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void removeSelectedPaymentType(PaymentTypeResponse paymentType) {
    try {
      var paymentTypes = List<PaymentTypeResponse>.from(states.paymentTypes);
      paymentTypes.remove(paymentType);
      updateState((state) => state.copyWith(paymentTypes: paymentTypes));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void setAgreedPrice(bool isAgreedPrice) {
    updateState((state) => state.copyWith(isAgreedPrice: isAgreedPrice));
  }

  void setIsBusiness(bool isBusiness) {
    updateState((state) => state.copyWith(isBusiness: isBusiness));
  }

  void setSelectedAddress(UserAddress address) {
    updateState((state) => state.copyWith(address: address));
  }

  void setEnteredContactPerson(String contactPerson) {
    updateState((state) => state.copyWith(contactPerson: contactPerson));
  }

  void setEnteredPhone(String phone) {
    updateState((state) => state.copyWith(phone: phone));
  }

  void setEnteredEmail(String email) {
    updateState((state) => state.copyWith(email: email));
  }

  void setServiceDistricts(List<District>? districts) {
    try {
      if (districts != null) {
        var items = List<District>.from(states.serviceDistricts);
        items.clear();
        items.addAll(districts);
        updateState((state) => state.copyWith(serviceDistricts: items));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void removeRequestAddress(District district) {
    try {
      var districts = List<District>.from(states.serviceDistricts);
      districts.remove(district);
      updateState((state) => state.copyWith(serviceDistricts: districts));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void showHideServiceDistricts() {
    updateState((state) => state.copyWith(
          isShowAllServiceDistricts: !states.isShowAllServiceDistricts,
        ));
  }

  void setAutoRenewal(bool isAutoRenewal) {
    updateState((state) => state.copyWith(isAutoRenewal: isAutoRenewal));
  }

  void setEnteredVideoUrl(String videoUrl) {
    updateState((state) => state.copyWith(videoUrl: videoUrl));
  }

  void setShowMySocialAccounts(bool isShowMySocialAccount) {
    updateState(
      (state) => state.copyWith(isShowMySocialAccount: isShowMySocialAccount),
    );
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> newImages = await picker.pickMultiImage();

      logger.w("pickImageFromGallery result = ${newImages.length}");
      if (newImages.isNotEmpty) {
        List<UploadableFile> addedImages = [];
        if (states.pickedImages?.isNotEmpty == true) {
          addedImages.addAll(states.pickedImages!);
        }

        var addedCount = addedImages.length;
        var newCount = newImages.length;
        var maxCount = state.state!.maxImageCount;

        if (addedCount >= maxCount) {
          emitEvent(PageEvent(
            PageEventType.onOverMaxCount,
            maxImageCount: states.maxImageCount,
          ));
        }
        List<XFile> neededImages = [];
        if ((addedCount + newCount) > maxCount) {
          emitEvent(PageEvent(
            PageEventType.onOverMaxCount,
            maxImageCount: states.maxImageCount,
          ));

          neededImages.addAll(newImages.sublist(0, maxCount - addedCount));
        } else {
          neededImages.addAll(newImages);
        }
        List<UploadableFile> compressedImages = [];

        for (var image in neededImages) {
          final compressed = await image.compressImage();
          compressedImages.add(compressed.toUploadableFile());
        }

        addedImages.addAll(compressedImages);
        updateState((state) => state.copyWith(pickedImages: addedImages));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> takeImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      logger.w("pickImageFromGallery result = $image");
      if (image != null) {
        List<UploadableFile> imageList = [];
        if (states.pickedImages?.isNotEmpty == true) {
          imageList.addAll(states.pickedImages!);
        }

        XFile compressedImage = await image.compressImage();
        imageList.add(compressedImage.toUploadableFile());
        updateState((state) => state.copyWith(pickedImages: imageList));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void removeImage(UploadableFile file) {
    try {
      List<UploadableFile> imageList = [];
      if (states.pickedImages?.isNotEmpty == true) {
        imageList.addAll(states.pickedImages!);
      }

      imageList.removeWhere((element) => element.isSame(file));
      updateState((state) => state.copyWith(pickedImages: imageList));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  List<UploadableFile> getImages() {
    return (states.pickedImages ?? []).toList();
  }

  void onReorder(int oldIndex, int newIndex) {
    try {
      List<UploadableFile> imageList = [];
      if (states.pickedImages?.isNotEmpty == true) {
        imageList.addAll(states.pickedImages!);
      }

      var item = imageList[oldIndex];
      imageList.removeAt(oldIndex);
      imageList.insert(newIndex, item);

      // List<XFile> newImageList = [];
      // newImageList.addAll(imageList);
      updateState((state) => state.copyWith(pickedImages: imageList));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void setChangedImageList(List<UploadableFile> images) {
    try {
      // List<UploadableFile> newImageList = [];
      // newImageList.addAll(images);
      updateState((state) => state.copyWith(pickedImages: images));
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
