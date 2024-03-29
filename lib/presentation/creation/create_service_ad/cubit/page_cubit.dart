import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/presentation/utils/xfile_mapper.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../common/enum/enums.dart';
import '../../../../data/repositories/ad_creation_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../../../../data/responses/address/user_address_response.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._adCreationRepository,
    this._userRepository,
  ) : super(const PageState());

  final AdCreationRepository _adCreationRepository;
  final UserRepository _userRepository;

  Future<void> getInitialData() async {
    final user = _userRepository.userInfoStorage.userInformation.call();
    updateState((state) => state.copyWith(
          contactPerson: user?.fullName?.capitalizeFullName() ?? "",
          // phone: user?.mobilePhone?.clearCountryCode() ?? "",
          // email: user?.email ?? "",
        ));
  }

  Future<void> createServiceAd() async {
    updateState((state) => state.copyWith(isRequestSending: true));

    await uploadImages();

    try {
      final response = await _adCreationRepository.createServiceAd(
        title: states.title,
        categoryId: states.category!.id,
        serviceCategoryId: states.category!.parent_id ?? states.category!.id,
        serviceSubCategoryId: states.category!.id,
        mainImageId: states.pickedImages!.map((e) => e.id).first!,
        pickedImageIds: states.pickedImages!.map((e) => e.id!).toList(),
        desc: states.desc,
        //
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
        phone: states.phone.clearPhoneNumberWithCode(),
        email: states.email,
        //
        isAutoRenewal: states.isAutoRenewal,
        isShowMySocialAccount: states.isShowMySocialAccount,
        videoUrl: states.videoUrl,
      );
      log.i(response.toString());

      updateState((state) => state.copyWith(isRequestSending: false));
      emitEvent(PageEvent(PageEventType.onAdCreated));
    } catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(isRequestSending: false));
    }
  }

  Future<void> uploadImages() async {
    var images =
        states.pickedImages?.where((e) => e.isNotUploaded()).toList() ?? [];
    if (images.isNotEmpty) {
      try {
        for (var image in images) {
          final uploadableFile = await _adCreationRepository.uploadImage(image);
          image.id = uploadableFile.id;
        }
      } catch (exception) {
        log.e(exception.toString());
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

  void setSelectedCurrency(CurrencyResponse currency) {
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
      log.e(e.toString());
    }
  }

  void removeSelectedPaymentType(PaymentTypeResponse paymentType) {
    try {
      var paymentTypes = List<PaymentTypeResponse>.from(states.paymentTypes);
      paymentTypes.remove(paymentType);
      updateState((state) => state.copyWith(paymentTypes: paymentTypes));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setAgreedPrice(bool isAgreedPrice) {
    updateState((state) => state.copyWith(isAgreedPrice: isAgreedPrice));
  }

  void setIsBusiness(bool isBusiness) {
    updateState((state) => state.copyWith(isBusiness: isBusiness));
  }

  void setSelectedAddress(UserAddressResponse address) {
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
      log.e(e.toString());
    }
  }

  void removeRequestAddress(District district) {
    try {
      var districts = List<District>.from(states.serviceDistricts);
      districts.remove(district);
      updateState((state) => state.copyWith(serviceDistricts: districts));
    } catch (e) {
      log.e(e.toString());
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

      log.w("pickImageFromGallery result = ${newImages.length}");
      if (newImages.isNotEmpty) {
        List<UploadableFile> addedImages = [];
        if (states.pickedImages?.isNotEmpty == true) {
          addedImages.addAll(states.pickedImages!);
        }
        // List<UploadableFile> changedImages = [];

        var addedCount = addedImages.length;
        var newCount = newImages.length;
        var maxCount = state.state!.maxImageCount;

        if (addedCount >= maxCount) {
          emitEvent(PageEvent(PageEventType.onOverMaxCount,
              maxImageCount: states.maxImageCount));
        }
        if ((addedCount + newCount) > maxCount) {
          emitEvent(PageEvent(PageEventType.onOverMaxCount,
              maxImageCount: states.maxImageCount));

          addedImages.addAll(newImages
              .sublist(0, maxCount - addedCount)
              .map((e) => e.toUploadableFile()));
          // changedImages.addAll(addedImages);
          updateState((state) => state.copyWith(pickedImages: addedImages));
        } else {
          addedImages.addAll(newImages.map((e) => e.toUploadableFile()));
          // changedImages.addAll(addedImages);
          updateState((state) => state.copyWith(pickedImages: addedImages));
        }
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<void> takeImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      log.w("pickImageFromGallery result = $image");
      if (image != null) {
        List<UploadableFile> imageList = [];
        if (states.pickedImages?.isNotEmpty == true) {
          imageList.addAll(states.pickedImages!);
        }

        imageList.add(image.toUploadableFile());
        // List<XFile> newImageList = [];
        // newImageList.addAll(imageList);
        updateState((state) => state.copyWith(pickedImages: imageList));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeImage(String imagePath) {
    try {
      List<UploadableFile> imageList = [];
      if (states.pickedImages?.isNotEmpty == true) {
        imageList.addAll(states.pickedImages!);
      }

      imageList.removeWhere((element) => element.xFile.path == imagePath);
      // List<XFile> newImageList = [];
      // newImageList.addAll(imageList);
      updateState((state) => state.copyWith(pickedImages: imageList));
    } catch (e) {
      log.e(e.toString());
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
      log.e(e.toString());
    }
  }

  void setChangedImageList(List<UploadableFile> images) {
    try {
      // List<UploadableFile> newImageList = [];
      // newImageList.addAll(images);
      updateState((state) => state.copyWith(pickedImages: images));
    } catch (e) {
      log.e(e.toString());
    }
  }
}
