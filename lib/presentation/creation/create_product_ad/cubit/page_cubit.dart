import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/responses/unit/unit_response.dart';
import 'package:onlinebozor/domain/models/district/district.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../common/enum/enums.dart';
import '../../../../data/repositories/ad_creation_repository.dart';
import '../../../../data/responses/address/user_address_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(const PageState());

  final AdCreationRepository repository;

  Future<void> createProductAd() async {
    updateState((state) => state.copyWith(isRequestSending: true));
    try {
      final response = await repository.createProductAd(
        title: states.title,
        category: states.category!,
        pickedImageIds: [""],
        videoUrl: states.videoUrl,
        desc: states.desc,
        warehouseCount: states.warehouseCount,
        unit: states.unit,
        minAmount: states.minAmount,
        price: states.price,
        currency: states.currency,
        paymentTypes: states.paymentTypes,
        isAgreedPrice: states.isAgreedPrice,
        isNew: states.isNew,
        isBusiness: states.isBusiness,
        address: states.address,
        contactPerson: states.contactPerson,
        phone: states.phone.clearPhone(),
        email: states.email,
        isPickupEnabled: states.isPickupEnabled,
        pickupWarehouses: states.pickupWarehouses,
        isFreeDeliveryEnabled: states.isFreeDeliveryEnabled,
        freeDeliveryMaxDay: states.freeDeliveryMaxDay,
        freeDeliveryDistricts: states.freeDeliveryDistricts,
        isPaidDeliveryEnabled: states.isPaidDeliveryEnabled,
        paidDeliveryMaxDay: states.paidDeliveryMaxDay,
        paidDeliveryDistricts: states.paidDeliveryDistricts,
        isAutoRenewal: states.isAutoRenewal,
        isShowMySocialAccount: states.isShowMySocialAccount,
      );
      log.i(response.toString());

      updateState((state) => state.copyWith(isRequestSending: false));
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(isRequestSending: false));
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

  void setEnteredWarehouseCount(String warehouseCount) {
    int warehouseCountInt = 14000;
    if (warehouseCount.trim().isNotEmpty) {
      try {
        warehouseCountInt = int.parse(warehouseCount.clearPrice());
      } catch (e) {
        warehouseCountInt = 15000;
        log.e(e.toString());
      }
    }
    updateState((state) => state.copyWith(warehouseCount: warehouseCountInt));
  }

  void setSelectedUnit(UnitResponse unit) {
    updateState((state) => state.copyWith(unit: unit));
  }

  void setEnteredPrice(String price) {
    int priceInt = 125000;
    if (price.trim().isNotEmpty) {
      try {
        priceInt = int.parse(price.clearPrice());
      } catch (e) {
        priceInt = 130000;
        log.e(e.toString());
      }
    }
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

  void setIsNew(bool isNew) {
    updateState((state) => state.copyWith(isNew: isNew));
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

  void showHideAddresses() {
    updateState((state) => state.copyWith(
          isShowAllPickupAddresses: !states.isShowAllPickupAddresses,
        ));
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

  void showHideFreeDistricts() {
    updateState((state) => state.copyWith(
      isShowAllFreeDeliveryDistricts: !states.isShowAllFreeDeliveryDistricts,
    ));
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

  void showHidePaidDistricts() {
    updateState((state) => state.copyWith(
      isShowAllPaidDeliveryDistricts: !states.isShowAllPaidDeliveryDistricts,
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

  void removePickupAddress(UserAddressResponse pickupAddress) {
    try {
      var pickupWarehouses =
          List<UserAddressResponse>.from(states.pickupWarehouses);
      pickupWarehouses.remove(pickupAddress);
      updateState(
        (state) => state.copyWith(pickupWarehouses: pickupWarehouses),
      );
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeFreeDelivery(District district) {
    try {
      var freeDeliveryDistricts =
          List<District>.from(states.freeDeliveryDistricts);
      freeDeliveryDistricts.remove(district);
      updateState(
        (state) => state.copyWith(freeDeliveryDistricts: freeDeliveryDistricts),
      );
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removePaidDelivery(District district) {
    try {
      var paidDeliveryDistricts =
          List<District>.from(states.paidDeliveryDistricts);
      paidDeliveryDistricts.remove(district);
      updateState(
        (state) => state.copyWith(paidDeliveryDistricts: paidDeliveryDistricts),
      );
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setFreeDeliveryEnabling(bool isEnabled) {
    updateState((state) => state.copyWith(isFreeDeliveryEnabled: isEnabled));
  }

  void setPaidDeliveryEnabling(bool isEnabled) {
    updateState((state) => state.copyWith(isPaidDeliveryEnabled: isEnabled));
  }

  void setAutoRenewal(bool isAutoRenewal) {
    updateState((state) => state.copyWith(isAutoRenewal: isAutoRenewal));
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
        List<XFile> addedImages = states.pickedImages != null
            ? List<XFile>.from(states.pickedImages!)
            : [];
        List<XFile> changedImages = [];

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

          addedImages.addAll(newImages.sublist(0, maxCount - addedCount));
          changedImages.addAll(addedImages);
          updateState((state) => state.copyWith(pickedImages: changedImages));
        } else {
          addedImages.addAll(newImages);
          changedImages.addAll(addedImages);
          updateState((state) => state.copyWith(pickedImages: changedImages));
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
        List<XFile> imageList = states.pickedImages != null
            ? List<XFile>.from(states.pickedImages!)
            : [];

        imageList.add(image);
        List<XFile> newImageList = [];
        newImageList.addAll(imageList);
        updateState((state) => state.copyWith(pickedImages: newImageList));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeImage(String imagePath) {
    try {
      List<XFile> imageList = states.pickedImages != null
          ? List<XFile>.from(states.pickedImages!)
          : [];

      imageList.removeWhere((element) => element.path == imagePath);
      List<XFile> newImageList = [];
      newImageList.addAll(imageList);
      updateState((state) => state.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }

  List<XFile> getImages() {
    return (states.pickedImages ?? []).map((e) => e).toList();
  }

  void onReorder(int oldIndex, int newIndex) {
    try {
      List<XFile> imageList = states.pickedImages != null
          ? List<XFile>.from(states.pickedImages!)
          : [];

      var item = imageList[oldIndex];
      imageList.removeAt(oldIndex);
      imageList.insert(newIndex, item);

      List<XFile> newImageList = [];
      newImageList.addAll(imageList);
      updateState((state) => state.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setChangedImageList(List<XFile> images) {
    try {
      List<XFile> newImageList = [];
      newImageList.addAll(images);
      updateState((state) => state.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }
}
