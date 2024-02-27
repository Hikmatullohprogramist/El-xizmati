import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';
import 'package:onlinebozor/data/responses/unit/unit_response.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../data/repositories/ad_creation_repository.dart';
import '../../../../data/responses/address/user_address_response.dart';

part 'create_product_ad_cubit.freezed.dart';

part 'create_product_ad_state.dart';

@Injectable()
class CreateProductAdCubit
    extends BaseCubit<CreateProductAdBuildable, CreateProductAdListenable> {
  CreateProductAdCubit(
    this._repository,
  ) : super(const CreateProductAdBuildable());

  final AdCreationRepository _repository;

  Future<void> sendCreateProductAdRequest() async {
    updateState((buildable) => buildable.copyWith(isRequestSending: true));
    try {
      final response = await _repository.createProductAd(
        title: currentState.title,
        category: currentState.category!,
        pickedImageIds: [""],
        desc: currentState.desc,
        warehouseCount: currentState.warehouseCount,
        unit: currentState.unit,
        price: currentState.price,
        currency: currentState.currency,
        paymentTypes: currentState.paymentTypes,
        isAgreedPrice: currentState.isAgreedPrice,
        isNew: currentState.isNew,
        isBusiness: currentState.isBusiness,
        address: currentState.address,
        contactPerson: currentState.contactPerson,
        phone: currentState.phone,
        email: currentState.email,
        pickupAddresses:
            currentState.isPickupEnabled ? currentState.pickupAddresses : [],
        isAutoRenewal: currentState.isAutoRenewal,
        isShowMySocialAccount: currentState.isShowMySocialAccount,
      );
      log.i(response.toString());

      updateState((buildable) => buildable.copyWith(isRequestSending: false));
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState((buildable) => buildable.copyWith(isRequestSending: false));
    }
  }

  void setEnteredTitle(String title) {
    updateState((buildable) => buildable.copyWith(title: title));
  }

  void setSelectedCategory(CategoryResponse category) {
    updateState((buildable) => buildable.copyWith(category: category));
  }

  void setEnteredDesc(String desc) {
    updateState((buildable) => buildable.copyWith(desc: desc));
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
    updateState((buildable) => buildable.copyWith(warehouseCount: warehouseCountInt));
  }

  void setSelectedUnit(UnitResponse unit) {
    updateState((buildable) => buildable.copyWith(unit: unit));
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
    updateState((buildable) => buildable.copyWith(price: priceInt));
  }

  void setSelectedCurrency(CurrencyResponse currency) {
    updateState((buildable) => buildable.copyWith(currency: currency));
  }

  void setSelectedPaymentTypes(
    List<PaymentTypeResponse>? selectedPaymentTypes,
  ) {
    try {
      if (selectedPaymentTypes != null) {
        var paymentTypes =
            List<PaymentTypeResponse>.from(currentState.paymentTypes);
        paymentTypes.clear();

        if (selectedPaymentTypes.isNotEmpty) {
          paymentTypes.addAll(selectedPaymentTypes);
          paymentTypes = paymentTypes.toSet().toList();
        }

        updateState((buildable) => buildable.copyWith(paymentTypes: paymentTypes));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeSelectedPaymentType(PaymentTypeResponse paymentType) {
    try {
      var paymentTypes = List<PaymentTypeResponse>.from(currentState.paymentTypes);
      paymentTypes.remove(paymentType);
      updateState((buildable) => buildable.copyWith(paymentTypes: paymentTypes));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setAgreedPrice(bool isAgreedPrice) {
    updateState((buildable) => buildable.copyWith(isAgreedPrice: isAgreedPrice));
  }

  void setIsNew(bool isNew) {
    updateState((buildable) => buildable.copyWith(isNew: isNew));
  }

  void setIsBusiness(bool isBusiness) {
    updateState((buildable) => buildable.copyWith(isBusiness: isBusiness));
  }

  void setSelectedAddress(UserAddressResponse address) {
    updateState((buildable) => buildable.copyWith(address: address));
  }

  void setEnteredContactPerson(String contactPerson) {
    updateState((buildable) => buildable.copyWith(contactPerson: contactPerson));
  }

  void setEnteredPhone(String phone) {
    updateState((buildable) => buildable.copyWith(phone: phone));
  }

  void setEnteredEmail(String email) {
    updateState((buildable) => buildable.copyWith(email: email));
  }

  void setPickupEnabling(bool isEnabled) {
    updateState((buildable) => buildable.copyWith(isPickupEnabled: isEnabled));
  }

  void setSelectedPickupAddresses(
    List<UserAddressResponse>? selectedPickupAddresses,
  ) {
    try {
      if (selectedPickupAddresses != null) {
        var pickupAddresses =
            List<UserAddressResponse>.from(currentState.pickupAddresses);

        pickupAddresses.clear();

        if (selectedPickupAddresses.isNotEmpty) {
          pickupAddresses.addAll(selectedPickupAddresses);
          pickupAddresses = pickupAddresses.toSet().toList();
        }

        updateState(
          (buildable) => buildable.copyWith(pickupAddresses: pickupAddresses),
        );
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeSelectedPickupAddress(UserAddressResponse pickupAddress) {
    try {
      var pickupAddresses =
          List<UserAddressResponse>.from(currentState.pickupAddresses);
      pickupAddresses.remove(pickupAddress);
      updateState(
        (buildable) => buildable.copyWith(pickupAddresses: pickupAddresses),
      );
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setFreeDeliveryEnabling(bool isEnabled) {
    updateState((buildable) => buildable.copyWith(isFreeDeliveryEnabled: isEnabled));
  }

  void setPaidDeliveryEnabling(bool isEnabled) {
    updateState((buildable) => buildable.copyWith(isPaidDeliveryEnabled: isEnabled));
  }

  void setAutoRenewal(bool isAutoRenewal) {
    updateState((buildable) => buildable.copyWith(isAutoRenewal: isAutoRenewal));
  }

  void setShowMySocialAccounts(bool isShowMySocialAccount) {
    updateState((buildable) =>
        buildable.copyWith(isShowMySocialAccount: isShowMySocialAccount));
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> newImages = await picker.pickMultiImage();

      log.w("pickImageFromGallery result = ${newImages.length}");
      if (newImages.isNotEmpty) {
        List<XFile> addedImages = currentState.pickedImages != null
            ? List<XFile>.from(currentState.pickedImages!)
            : [];
        List<XFile> changedImages = [];

        var addedCount = addedImages.length;
        var newCount = newImages.length;
        var maxCount = state.state!.maxImageCount;

        if (addedCount >= maxCount) {
          emitEvent(CreateProductAdListenable(CreateProductAdEffect.onOverMaxCount,
              maxImageCount: currentState.maxImageCount));
        }
        if ((addedCount + newCount) > maxCount) {
          emitEvent(CreateProductAdListenable(CreateProductAdEffect.onOverMaxCount,
              maxImageCount: currentState.maxImageCount));

          addedImages.addAll(newImages.sublist(0, maxCount - addedCount));
          changedImages.addAll(addedImages);
          updateState((buildable) => buildable.copyWith(pickedImages: changedImages));
        } else {
          addedImages.addAll(newImages);
          changedImages.addAll(addedImages);
          updateState((buildable) => buildable.copyWith(pickedImages: changedImages));
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
        List<XFile> imageList = currentState.pickedImages != null
            ? List<XFile>.from(currentState.pickedImages!)
            : [];

        imageList.add(image);
        List<XFile> newImageList = [];
        newImageList.addAll(imageList);
        updateState((buildable) => buildable.copyWith(pickedImages: newImageList));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeImage(String imagePath) {
    try {
      List<XFile> imageList = currentState.pickedImages != null
          ? List<XFile>.from(currentState.pickedImages!)
          : [];

      imageList.removeWhere((element) => element.path == imagePath);
      List<XFile> newImageList = [];
      newImageList.addAll(imageList);
      updateState((buildable) => buildable.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }

  List<XFile> getImages() {
    return (currentState.pickedImages ?? []).map((e) => e).toList();
  }

  void onReorder(int oldIndex, int newIndex) {
    try {
      List<XFile> imageList = currentState.pickedImages != null
          ? List<XFile>.from(currentState.pickedImages!)
          : [];

      var item = imageList[oldIndex];
      imageList.removeAt(oldIndex);
      imageList.insert(newIndex, item);

      List<XFile> newImageList = [];
      newImageList.addAll(imageList);
      updateState((buildable) => buildable.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setChangedImageList(List<XFile> images) {
    try {
      List<XFile> newImageList = [];
      newImageList.addAll(images);
      updateState((buildable) => buildable.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }
}
