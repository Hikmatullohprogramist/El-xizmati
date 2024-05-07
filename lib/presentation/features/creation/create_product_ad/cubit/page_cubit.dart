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
import 'package:onlinebozor/data/datasource/network/responses/unit/unit_response.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/repositories/user_address_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/mappers/user_mapper.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
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

  void setInitialParams(int? adId, AdTransactionType adTransactionType) {
    logger.w(
        "create-product-ad adId = $adId, adTransactionType = $adTransactionType");
    updateState((state) => state.copyWith(
          adId: adId,
          isEditing: adId != null,
          isNotPrepared: adId != null,
          adTransactionType: adTransactionType,
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
          await _adCreationRepository.getProductAdForEdit(adId: states.adId!);

      updateState((state) => state.copyWith(
            isFirstTime: false,
            isNotPrepared: false,
            isPreparingInProcess: false,
            title: ad.name ?? "",
            category: ad.getCategory(),
            pickedImages: ad.getPhotos(),
            desc: ad.description ?? "",
            warehouseCount: ad.warehouseCount,
            unit: ad.getUnit(),
            price: ad.price,
            currency: ad.getCurrency(),
            paymentTypes: ad.getPaymentTypes(),
            isBusiness: ad.getIsBusiness(),
            isNew: ad.getIsNew(),
            isAgreedPrice: ad.isContract ?? false,
            address: ad.getUserAddress()?.toAddress(),
            contactPerson: ad.contactName ?? "",
            phone: ad.phoneNumber?.clearPhoneWithoutCode() ?? "",
            email: ad.email ?? "",
            exchangeTitle: ad.otherName ?? "",
            exchangeDesc: ad.otherDescription ?? "",
            isExchangeNew: ad.getIsOtherNew(),
            exchangeCategory: ad.getOtherCategory(),
            isPickupEnabled: ad.pickupEnabled ?? false,
            pickupWarehouses:
                ad.getWarehouses().map((e) => e.toAddress()).toList(),
            isFreeDeliveryEnabled: ad.freeDeliveryEnabled ?? false,
            freeDeliveryDistricts: ad.getFreeDeliveryDistricts(),
            isPaidDeliveryEnabled: ad.paidDeliveryEnabled ?? false,
            paidDeliveryDistricts: ad.getPaidDeliveryDistricts(),
            paidDeliveryPrice: ad.paidDeliveryPrice,
            isAutoRenewal: ad.isAutoRenew ?? false,
            videoUrl: ad.video ?? "",
            isShowMySocialAccount: ad.showSocial ?? false,
          ));
    } catch (e) {
      logger.w("getEditingInitialData error = $e");
      updateState((state) => state.copyWith(
            isFirstTime: false,
            isPreparingInProcess: false,
            isNotPrepared: true,
          ));
    }
  }

  Future<void> createOrUpdateProductAd() async {
    updateState((state) => state.copyWith(isRequestSending: true));

    await uploadImages();

    try {
      final adId = await _adCreationRepository.createOrUpdateProductAd(
        adId: states.adId,
        //
        title: states.title,
        category: states.category!,
        adTransactionType: states.adTransactionType,
        //
        mainImageId: states.pickedImages!.map((e) => e.id).first!,
        pickedImageIds: states.pickedImages!.map((e) => e.id!).toList(),
        //
        desc: states.desc,
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
        phone: states.phone.clearPhoneWithCode(),
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
    int? warehouseCountInt = int.tryParse(warehouseCount.clearPrice());
    updateState((state) => state.copyWith(warehouseCount: warehouseCountInt));
  }

  void setSelectedUnit(UnitResponse unit) {
    updateState((state) => state.copyWith(unit: unit));
  }

  void setEnteredPrice(String price) {
    int? priceInt = int.tryParse(price.clearPrice());
    updateState((state) => state.copyWith(price: priceInt));
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

  void setPickupEnabling(bool isEnabled) {
    updateState((state) => state.copyWith(isPickupEnabled: isEnabled));
  }

  void setSelectedPickupAddresses(List<UserAddress>? addresses) {
    try {
      if (addresses != null) {
        var items = List<UserAddress>.from(states.pickupWarehouses);
        items.clear();
        items.addAll(addresses);
        updateState((state) => state.copyWith(pickupWarehouses: items));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void removePickupAddress(UserAddress pickupAddress) {
    try {
      var warehouses = List<UserAddress>.from(states.pickupWarehouses);
      warehouses.remove(pickupAddress);
      updateState((state) => state.copyWith(pickupWarehouses: warehouses));
    } catch (e) {
      logger.e(e.toString());
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
      logger.e(e.toString());
    }
  }

  void removeFreeDelivery(District district) {
    try {
      var districts = List<District>.from(states.freeDeliveryDistricts);
      districts.remove(district);
      updateState((state) => state.copyWith(freeDeliveryDistricts: districts));
    } catch (e) {
      logger.e(e.toString());
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
      logger.e(e.toString());
    }
  }

  void removePaidDelivery(District district) {
    try {
      var districts = List<District>.from(states.paidDeliveryDistricts);
      districts.remove(district);
      updateState((state) => state.copyWith(paidDeliveryDistricts: districts));
    } catch (e) {
      logger.e(e.toString());
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
