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
    build((buildable) => buildable.copyWith(isRequestSending: true));
    try {
      final response = await _repository.createProductAd(
        title: buildable.title,
        category: buildable.category!,
        pickedImageIds: [""],
        desc: buildable.desc,
        warehouseCount: buildable.warehouseCount,
        unit: buildable.unit,
        price: buildable.price,
        currency: buildable.currency,
        paymentTypes: buildable.paymentTypes,
        isAgreedPrice: buildable.isAgreedPrice,
        isNew: buildable.isNew,
        isBusiness: buildable.isBusiness,
        address: buildable.address,
        contactPerson: buildable.contactPerson,
        phone: buildable.phone,
        email: buildable.email,
        pickupAddresses:
            buildable.isPickupEnabled ? buildable.pickupAddresses : [],
        isAutoRenewal: buildable.isAutoRenewal,
        isShowMySocialAccount: buildable.isShowMySocialAccount,
      );
      log.i(response.toString());

      build((buildable) => buildable.copyWith(isRequestSending: false));
    } on DioException catch (exception) {
      log.e(exception.toString());
      build((buildable) => buildable.copyWith(isRequestSending: false));
    }
  }

  void setEnteredTitle(String title) {
    build((buildable) => buildable.copyWith(title: title));
  }

  void setSelectedCategory(CategoryResponse category) {
    build((buildable) => buildable.copyWith(category: category));
  }

  void setEnteredDesc(String desc) {
    build((buildable) => buildable.copyWith(desc: desc));
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
    build((buildable) => buildable.copyWith(warehouseCount: warehouseCountInt));
  }

  void setSelectedUnit(UnitResponse unit) {
    build((buildable) => buildable.copyWith(unit: unit));
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
    build((buildable) => buildable.copyWith(price: priceInt));
  }

  void setSelectedCurrency(CurrencyResponse currency) {
    build((buildable) => buildable.copyWith(currency: currency));
  }

  void setSelectedPaymentTypes(
    List<PaymentTypeResponse>? selectedPaymentTypes,
  ) {
    try {
      if (selectedPaymentTypes != null) {
        var paymentTypes =
            List<PaymentTypeResponse>.from(buildable.paymentTypes);
        paymentTypes.clear();

        if (selectedPaymentTypes.isNotEmpty) {
          paymentTypes.addAll(selectedPaymentTypes);
          paymentTypes = paymentTypes.toSet().toList();
        }

        build((buildable) => buildable.copyWith(paymentTypes: paymentTypes));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeSelectedPaymentType(PaymentTypeResponse paymentType) {
    try {
      var paymentTypes = List<PaymentTypeResponse>.from(buildable.paymentTypes);
      paymentTypes.remove(paymentType);
      build((buildable) => buildable.copyWith(paymentTypes: paymentTypes));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setAgreedPrice(bool isAgreedPrice) {
    build((buildable) => buildable.copyWith(isAgreedPrice: isAgreedPrice));
  }

  void setIsNew(bool isNew) {
    build((buildable) => buildable.copyWith(isNew: isNew));
  }

  void setIsBusiness(bool isBusiness) {
    build((buildable) => buildable.copyWith(isBusiness: isBusiness));
  }

  void setSelectedAddress(UserAddressResponse address) {
    build((buildable) => buildable.copyWith(address: address));
  }

  void setEnteredContactPerson(String contactPerson) {
    build((buildable) => buildable.copyWith(contactPerson: contactPerson));
  }

  void setEnteredPhone(String phone) {
    build((buildable) => buildable.copyWith(phone: phone));
  }

  void setEnteredEmail(String email) {
    build((buildable) => buildable.copyWith(email: email));
  }

  void setPickupEnabling(bool isEnabled) {
    build((buildable) => buildable.copyWith(isPickupEnabled: isEnabled));
  }

  void setSelectedPickupAddresses(
    List<UserAddressResponse>? selectedPickupAddresses,
  ) {
    try {
      if (selectedPickupAddresses != null) {
        var pickupAddresses =
            List<UserAddressResponse>.from(buildable.pickupAddresses);

        pickupAddresses.clear();

        if (selectedPickupAddresses.isNotEmpty) {
          pickupAddresses.addAll(selectedPickupAddresses);
          pickupAddresses = pickupAddresses.toSet().toList();
        }

        build(
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
          List<UserAddressResponse>.from(buildable.pickupAddresses);
      pickupAddresses.remove(pickupAddress);
      build(
        (buildable) => buildable.copyWith(pickupAddresses: pickupAddresses),
      );
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setFreeDeliveryEnabling(bool isEnabled) {
    build((buildable) => buildable.copyWith(isFreeDeliveryEnabled: isEnabled));
  }

  void setPaidDeliveryEnabling(bool isEnabled) {
    build((buildable) => buildable.copyWith(isPaidDeliveryEnabled: isEnabled));
  }

  void setAutoRenewal(bool isAutoRenewal) {
    build((buildable) => buildable.copyWith(isAutoRenewal: isAutoRenewal));
  }

  void setShowMySocialAccounts(bool isShowMySocialAccount) {
    build((buildable) =>
        buildable.copyWith(isShowMySocialAccount: isShowMySocialAccount));
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> newImages = await picker.pickMultiImage();

      log.w("pickImageFromGallery result = ${newImages.length}");
      if (newImages.isNotEmpty) {
        List<XFile> addedImages = buildable.pickedImages != null
            ? List<XFile>.from(buildable.pickedImages!)
            : [];
        List<XFile> changedImages = [];

        var addedCount = addedImages.length;
        var newCount = newImages.length;
        var maxCount = state.buildable!.maxImageCount;

        if (addedCount >= maxCount) {
          invoke(CreateProductAdListenable(CreateProductAdEffect.onOverMaxCount,
              maxImageCount: buildable.maxImageCount));
        }
        if ((addedCount + newCount) > maxCount) {
          invoke(CreateProductAdListenable(CreateProductAdEffect.onOverMaxCount,
              maxImageCount: buildable.maxImageCount));

          addedImages.addAll(newImages.sublist(0, maxCount - addedCount));
          changedImages.addAll(addedImages);
          build((buildable) => buildable.copyWith(pickedImages: changedImages));
        } else {
          addedImages.addAll(newImages);
          changedImages.addAll(addedImages);
          build((buildable) => buildable.copyWith(pickedImages: changedImages));
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
        List<XFile> imageList = buildable.pickedImages != null
            ? List<XFile>.from(buildable.pickedImages!)
            : [];

        imageList.add(image);
        List<XFile> newImageList = [];
        newImageList.addAll(imageList);
        build((buildable) => buildable.copyWith(pickedImages: newImageList));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeImage(String imagePath) {
    try {
      List<XFile> imageList = buildable.pickedImages != null
          ? List<XFile>.from(buildable.pickedImages!)
          : [];

      imageList.removeWhere((element) => element.path == imagePath);
      List<XFile> newImageList = [];
      newImageList.addAll(imageList);
      build((buildable) => buildable.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }

  List<XFile> getImages() {
    return (buildable.pickedImages ?? []).map((e) => e).toList();
  }

  void onReorder(int oldIndex, int newIndex) {
    try {
      List<XFile> imageList = buildable.pickedImages != null
          ? List<XFile>.from(buildable.pickedImages!)
          : [];

      var item = imageList[oldIndex];
      imageList.removeAt(oldIndex);
      imageList.insert(newIndex, item);

      List<XFile> newImageList = [];
      newImageList.addAll(imageList);
      build((buildable) => buildable.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setChangedImageList(List<XFile> images) {
    try {
      List<XFile> newImageList = [];
      newImageList.addAll(images);
      build((buildable) => buildable.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }
}
