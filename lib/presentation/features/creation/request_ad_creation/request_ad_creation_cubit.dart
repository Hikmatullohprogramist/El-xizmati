import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/extensions/list_extensions.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:El_xizmati/data/repositories/ad_creation_repository.dart';
import 'package:El_xizmati/data/repositories/user_address_repository.dart';
import 'package:El_xizmati/data/repositories/user_repository.dart';
import 'package:El_xizmati/domain/mappers/user_mapper.dart';
import 'package:El_xizmati/domain/models/ad/ad_transaction_type.dart';
import 'package:El_xizmati/domain/models/ad/ad_type.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/image/uploadable_file.dart';
import 'package:El_xizmati/domain/models/user/user_address.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:El_xizmati/presentation/support/extensions/compressing_exts.dart';
import 'package:El_xizmati/presentation/support/extensions/extension_message_exts.dart';
import 'package:El_xizmati/presentation/support/extensions/xfile_exts.dart';

part 'request_ad_creation_cubit.freezed.dart';
part 'request_ad_creation_state.dart';

@Injectable()
class RequestAdCreationCubit
    extends BaseCubit<RequestAdCreationState, RequestAdCreationEvent> {
  RequestAdCreationCubit(
    this._adCreationRepository,
    this._userRepository,
    this._userAddressRepository,
  ) : super(const RequestAdCreationState());

  final AdCreationRepository _adCreationRepository;
  final UserRepository _userRepository;
  final UserAddressRepository _userAddressRepository;

  void setInitialParams(int? adId, AdTransactionType adTransactionType) {
    updateState((state) => state.copyWith(
          adId: adId,
          isNotPrepared: adId != null,
          isEditing: adId != null,
          adTransactionType: adTransactionType,
          adType: adTransactionType == AdTransactionType.buy
              ? AdType.product
              : AdType.service,
        ));

    if (states.isEditing) {
      getEditingInitialData();
    } else {
      getCreatingInitialData();
    }
  }

  Future<void> getCreatingInitialData() async {
    final user = await _userRepository.getSavedUser();
    updateState((state) => state.copyWith(
          contactPerson: user?.fullName.capitalizePersonName() ?? "",
          phone: user?.phone.clearPhoneWithoutCode() ?? "",
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
    _adCreationRepository
        .getRequestAdForEdit(adId: states.adId!)
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isPreparingInProcess: true));
        })
        .onSuccess((ad) {
          updateState((state) => state.copyWith(
                isNotPrepared: false,
                isPreparingInProcess: false,
                //
                title: ad.name ?? "",
                category: ad.getCategory(),
                //
                pickedImages: ad.getPhotos(),
                //
                desc: ad.description ?? "",
                //
                fromPrice: ad.fromPrice,
                toPrice: ad.toPrice,
                currency: ad.getCurrency(),
                paymentTypes: ad.getPaymentTypes(),
                isAgreedPrice: ad.isContract ?? false,
                //
                contactPerson: ad.contactName ?? "",
                phone: ad.phoneNumber?.clearPhoneWithoutCode() ?? "",
                email: ad.email ?? "",
                //
                address: ad.getUserAddress()?.toAddress(),
                requestDistricts: ad.getRequestDistricts(),
                //
                isAutoRenewal: ad.isAutoRenew ?? false,
              ));
        })
        .onError((error) {
          logger.w(error);
          updateState((state) => state.copyWith(isPreparingInProcess: false));
          stateMessageManager.showErrorBottomSheet(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> createOrUpdateRequestAd() async {
    updateState((state) => state.copyWith(isRequestSending: true));
    emitEvent(RequestAdCreationEvent(
      RequestAdCreationEventType.onRequestStarted,
    ));

    await uploadImages();

    _adCreationRepository
        .createOrUpdateRequestAd(
          adId: states.adId,
          //
          title: states.title,
          categoryId: states.category!.id,
          serviceCategoryId: states.category!.parentId ?? states.category!.id,
          serviceSubCategoryId: states.category!.id,
          //
          adType: states.adType,
          adTransactionType: states.adTransactionType,
          //
          mainImageId: states.pickedImages!.map((e) => e.id).first!,
          pickedImageIds: states.pickedImages!.map((e) => e.id!).toList(),
          //
          desc: states.desc,
          fromPrice: states.fromPrice!,
          toPrice: states.toPrice!,
          currency: states.currency!,
          paymentTypes: states.paymentTypes,
          isAgreedPrice: states.isAgreedPrice,
          //
          requestDistricts: states.requestDistricts,
          //
          address: states.address!,
          contactPerson: states.contactPerson,
          phone: states.phone.clearPhoneWithCode(),
          email: states.email,
          //
          isAutoRenewal: states.isAutoRenewal,
        )
        .initFuture()
        .onStart(() {})
        .onSuccess((data) async {
          updateState((state) => state.copyWith(isRequestSending: false));
          if (!states.isEditing) {
            updateState((state) => state.copyWith(adId: data));
          }

          await Future.delayed(Duration(seconds: 2));

          emitEvent(RequestAdCreationEvent(
            RequestAdCreationEventType.onRequestFinished,
          ));
        })
        .onError((error) {
          logger.e(error);
          updateState((state) => state.copyWith(isRequestSending: false));
          emitEvent(RequestAdCreationEvent(
            RequestAdCreationEventType.onRequestFailed,
          ));
        })
        .onFinished(() {})
        .executeFuture();
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
        emitEvent(RequestAdCreationEvent(
          RequestAdCreationEventType.onRequestFailed,
        ));
      } finally {
        updateState((state) => state.copyWith(pickedImages: images));
      }
    }
  }

  void setEnteredTitle(String title) {
    updateState((state) => state.copyWith(title: title));
  }

  void setSelectedCategory(Category category) {
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

  void setFreeDeliveryDistricts(List<District>? districts) {
    try {
      if (districts != null) {
        var items = List<District>.from(states.requestDistricts);
        items.clear();
        items.addAll(districts);
        updateState((state) => state.copyWith(requestDistricts: items));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void removeAddress(District district) {
    try {
      var districts = List<District>.from(states.requestDistricts);
      districts.remove(district);
      updateState((state) => state.copyWith(requestDistricts: districts));
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void showHideRequestDistricts() {
    updateState((state) => state.copyWith(
          isShowAllRequestDistricts: !states.isShowAllRequestDistricts,
        ));
  }

  void setAutoRenewal(bool isAutoRenewal) {
    updateState((state) => state.copyWith(isAutoRenewal: isAutoRenewal));
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
          emitEvent(RequestAdCreationEvent(
            RequestAdCreationEventType.onOverMaxCount,
            maxImageCount: states.maxImageCount,
          ));
        }
        List<XFile> neededImages = [];
        if ((addedCount + newCount) > maxCount) {
          emitEvent(RequestAdCreationEvent(
            RequestAdCreationEventType.onOverMaxCount,
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
