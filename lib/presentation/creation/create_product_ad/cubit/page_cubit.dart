import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/responses/unit/unit_response.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
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
          phone: user?.mobilePhone?.clearCountryCode() ?? "",
          email: user?.email ?? "",
        ));
  }

  Future<void> createProductAd() async {
    updateState((state) => state.copyWith(isRequestSending: true));

    await uploadImages();

    try {
      final response = await _adCreationRepository.createProductAd(
        title: states.title,
        category: states.category!,
        adTransactionType: states.adTransactionType,
        mainImageId: states.pickedImages!.map((e) => e.id).first!,
        pickedImageIds: states.pickedImages!.map((e) => e.id!).toList(),
        desc: states.desc,
        //
        warehouseCount: states.warehouseCount,
        unit: states.unit,
        minAmount: states.minAmount,
        price: states.price,
        currency: states.currency,
        paymentTypes: states.paymentTypes,
        isAgreedPrice: states.isAgreedPrice,
        //
        propertyStatus: states.isNew ? "NEW" : "USED",
        accountType: states.isBusiness ? "BUSINESS" : "PRIVATE",
        //
        exchangeTitle: states.exchangeTitle,
        exchangeCategory: states.exchangeCategory,
        exchangeDesc: states.exchangeDesc,
        exchangePropertyStatus: states.isExchangeNew ? "NEW" : "USED",
        exchangeAccountType: states.isExchangeBusiness ? "BUSINESS" : "PRIVATE",
        //
        address: states.address,
        contactPerson: states.contactPerson,
        phone: states.phone.clearPhone(),
        email: states.email,
        //
        isPickupEnabled: states.isPickupEnabled,
        pickupWarehouses: states.pickupWarehouses,
        isFreeDeliveryEnabled: states.isFreeDeliveryEnabled,
        freeDeliveryMaxDay: states.freeDeliveryMaxDay,
        freeDeliveryDistricts: states.freeDeliveryDistricts,
        isPaidDeliveryEnabled: states.isPaidDeliveryEnabled,
        paidDeliveryMaxDay: states.paidDeliveryMaxDay,
        paidDeliveryPrice: states.paidDeliveryPrice,
        paidDeliveryDistricts: states.paidDeliveryDistricts,
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

  bool isExchangeMode() {
    return states.adTransactionType == AdTransactionType.EXCHANGE;
  }

  bool isFreeAdMode() {
    return states.adTransactionType == AdTransactionType.FREE;
  }

  void setEnteredTitle(String title) {
    updateState((state) => state.copyWith(title: title));
  }

  void setSelectedCategory(CategoryResponse category) {
    updateState((state) => state.copyWith(category: category));
  }

  void setSelectedAdTransactionType(AdTransactionType type) {
    updateState((state) => state.copyWith(adTransactionType: type));
  }

  void setEnteredDesc(String desc) {
    updateState((state) => state.copyWith(desc: desc));
  }

  void setEnteredWarehouseCount(String warehouseCount) {
    int? warehouseCountInt;
    if (warehouseCount.trim().isNotEmpty) {
      try {
        warehouseCountInt = int.parse(warehouseCount.clearPrice());
      } catch (e) {
        warehouseCountInt = null;
        log.e(e.toString());
      }
    }
    updateState((state) => state.copyWith(warehouseCount: warehouseCountInt));
  }

  void setSelectedUnit(UnitResponse unit) {
    updateState((state) => state.copyWith(unit: unit));
  }

  void setEnteredPrice(String price) {
    int? priceInt = int.tryParse(price.clearPrice());
    updateState((state) => state.copyWith(price: priceInt));
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

  void setIsNew(bool isNew) {
    updateState((state) => state.copyWith(isNew: isNew));
  }

  void setEnteredAnotherTitle(String title) {
    updateState((state) => state.copyWith(exchangeTitle: title));
  }

  void setSelectedAnotherCategory(CategoryResponse category) {
    updateState((state) => state.copyWith(exchangeCategory: category));
  }

  void setEnteredAnotherDesc(String desc) {
    updateState((state) => state.copyWith(exchangeDesc: desc));
  }

  void setAnotherIsNew(bool isNew) {
    updateState((state) => state.copyWith(isExchangeNew: isNew));
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

  void setPickupEnabling(bool isEnabled) {
    updateState((state) => state.copyWith(isPickupEnabled: isEnabled));
  }

  void setSelectedPickupAddresses(List<UserAddressResponse>? addresses) {
    try {
      if (addresses != null) {
        var items = List<UserAddressResponse>.from(states.pickupWarehouses);
        items.clear();
        items.addAll(addresses);
        updateState((state) => state.copyWith(pickupWarehouses: items));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removePickupAddress(UserAddressResponse pickupAddress) {
    try {
      var warehouses = List<UserAddressResponse>.from(states.pickupWarehouses);
      warehouses.remove(pickupAddress);
      updateState((state) => state.copyWith(pickupWarehouses: warehouses));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void showHideAddresses() {
    updateState((state) => state.copyWith(
          isShowAllPickupAddresses: !states.isShowAllPickupAddresses,
        ));
  }

  void setFreeDeliveryEnabling(bool isEnabled) {
    updateState((state) => state.copyWith(isFreeDeliveryEnabled: isEnabled));
  }

  void setFreeDeliveryDistricts(List<District>? districts) {
    try {
      if (districts != null) {
        var items = List<District>.from(states.freeDeliveryDistricts);
        items.clear();
        items.addAll(districts);
        updateState((state) => state.copyWith(freeDeliveryDistricts: items));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeFreeDelivery(District district) {
    try {
      var districts = List<District>.from(states.freeDeliveryDistricts);
      districts.remove(district);
      updateState((state) => state.copyWith(freeDeliveryDistricts: districts));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void showHideFreeDistricts() {
    updateState((state) => state.copyWith(
          isShowAllFreeDeliveryDistricts:
              !states.isShowAllFreeDeliveryDistricts,
        ));
  }

  void setPaidDeliveryEnabling(bool isEnabled) {
    updateState((state) => state.copyWith(isPaidDeliveryEnabled: isEnabled));
  }

  void setEnteredPaidDeliveryPrice(String price) {
    int? priceInt = int.tryParse(price.clearPrice());
    updateState((state) => state.copyWith(paidDeliveryPrice: priceInt));
  }

  void setPaidDeliveryDistricts(List<District>? districts) {
    try {
      if (districts != null) {
        var items = List<District>.from(states.paidDeliveryDistricts);
        items.clear();
        items.addAll(districts);
        updateState((state) => state.copyWith(paidDeliveryDistricts: items));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removePaidDelivery(District district) {
    try {
      var districts = List<District>.from(states.paidDeliveryDistricts);
      districts.remove(district);
      updateState((state) => state.copyWith(paidDeliveryDistricts: districts));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void showHidePaidDistricts() {
    updateState((state) => state.copyWith(
          isShowAllPaidDeliveryDistricts:
              !states.isShowAllPaidDeliveryDistricts,
        ));
  }

  bool checkEnabledField() {
    var title = (state.state?.title.isNotEmpty) ?? false;
    var category = (state.state?.category?.name?.isNotEmpty) ?? false;
    var description = (state.state?.desc.isNotEmpty) ?? false;
    var warehouseCount =
        (state.state?.warehouseCount.toString()?.isNotEmpty) ?? false;
    var unit = (state.state?.unit?.name?.isNotEmpty) ?? false;
    var price = (state.state?.price.toString().isNotEmpty) ?? false;
    var currency = (state.state?.currency?.name?.isNotEmpty) ?? false;
    var contactPerson = (state.state?.contactPerson.isNotEmpty) ?? false;
    var phoneNumber = (state.state?.phone.isNotEmpty) ?? false;
    var email = (state.state?.email.isNotEmpty) ?? false;
    if (title &&
        category &&
        description &&
        warehouseCount &&
        unit &&
        price &&
        currency &&
        contactPerson &&
        phoneNumber &&
        email) {
      return true;
    } else {
      return false;
    }
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
