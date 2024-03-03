import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/responses/unit/unit_response.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../common/enum/enums.dart';
import '../../../../data/repositories/ad_creation_repository.dart';
import '../../../../data/responses/address/user_address_response.dart';
import '../../../../data/responses/region/region_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(const PageState());

  final AdCreationRepository repository;

  Future<void> sendCreateProductAdRequest() async {
    updateState((state) => state.copyWith(isRequestSending: true));
    try {
      final response = await repository.createProductAd(
        title: states.title,
        category: states.category!,
        pickedImageIds: [""],
        desc: states.desc,
        warehouseCount: states.warehouseCount,
        unit: states.unit,
        price: states.price,
        currency: states.currency,
        paymentTypes: states.paymentTypes,
        isAgreedPrice: states.isAgreedPrice,
        isNew: states.isNew,
        isBusiness: states.isBusiness,
        address: states.address,
        contactPerson: states.contactPerson,
        phone: states.phone,
        email: states.email,
        pickupAddresses: states.isPickupEnabled ? states.pickupAddresses : [],
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
    int? warehouseCountInt;
    if (warehouseCount.trim().isNotEmpty) {
      try {
        warehouseCountInt = warehouseCount as int;
      } catch (e) {
        log.e(e.toString());
      }
    }
    updateState((state) => state.copyWith(warehouseCount: warehouseCountInt));
  }

  void setSelectedUnit(UnitResponse unit) {
    updateState((state) => state.copyWith(unit: unit));
  }

  void setEnteredPrice(String price) {
    int? priceInt;
    if (price.trim().isNotEmpty) {
      try {
        priceInt = price as int;
      } catch (e) {
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

  void setSelectedDeleveryForFree(
    List<RegionResponse>? selectedPaymentTypes,
  ) {
    try {
      if (selectedPaymentTypes != null) {
        var paymentTypes = List<RegionResponse>.from(states.paymentType);
        paymentTypes.clear();

        if (selectedPaymentTypes.isNotEmpty) {
          paymentTypes.addAll(selectedPaymentTypes);
          paymentTypes = paymentTypes.toSet().toList();
        }
        updateState((state) => state.copyWith(paymentType: paymentTypes));
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

  void setSelectedPickupAddresses(
    List<UserAddressResponse>? selectedPickupAddresses,
  ) {
    try {
      if (selectedPickupAddresses != null) {
        var pickupAddresses =
            List<UserAddressResponse>.from(states.pickupAddresses);

        pickupAddresses.clear();

        if (selectedPickupAddresses.isNotEmpty) {
          pickupAddresses.addAll(selectedPickupAddresses);
          pickupAddresses = pickupAddresses.toSet().toList();
        }

        updateState(
          (state) => state.copyWith(pickupAddresses: pickupAddresses),
        );
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  bool checkEnabledField() {
    var title = (state.state?.title.isNotEmpty) ?? false;
    var category = (state.state?.category?.name?.isNotEmpty) ?? false;
    var description = (state.state?.desc.isNotEmpty) ?? false;
    var warehouseCount = (state.state?.warehouseCount.toString()?.isNotEmpty) ?? false;
    var unit= (state.state?.unit?.name?.isNotEmpty) ?? false;
    var price = (state.state?.price.toString().isNotEmpty) ?? false;
    var currency = (state.state?.currency?.name?.isNotEmpty) ?? false;
    var contactPerson = (state.state?.contactPerson.isNotEmpty) ?? false;
    var phoneNumber = (state.state?.phone.isNotEmpty) ?? false;
    var email = (state.state?.email.isNotEmpty) ?? false;


    if (title && category && description && warehouseCount && unit && price &&currency
      &&contactPerson&&phoneNumber&&email) {
      return true;
    } else {
      return false;
    }
  }

  void removeSelectedPickupAddress(UserAddressResponse pickupAddress) {
    try {
      var pickupAddresses =
          List<UserAddressResponse>.from(states.pickupAddresses);
      pickupAddresses.remove(pickupAddress);
      updateState((state) => state.copyWith(pickupAddresses: pickupAddresses));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeSelectedDeliveryForFree(RegionResponse paymentType) {
    try {
      var paymentTypes = List<RegionResponse>.from(states.paymentType);
      paymentTypes.remove(paymentType);
      updateState((state) => state.copyWith(paymentType: paymentTypes));
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
