import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../../../data/responses/category/category/category_response.dart';

part 'create_product_order_cubit.freezed.dart';

part 'create_product_order_state.dart';

@Injectable()
class CreateProductOrderCubit extends BaseCubit<CreateProductOrderBuildable,
    CreateProductOrderListenable> {
  CreateProductOrderCubit() : super(const CreateProductOrderBuildable());

  void setName(String name) {
    updateState((buildable) => buildable.copyWith(name: name));
  }

  void setNegative(bool isNegotiate) {
    updateState((buildable) => buildable.copyWith(isNegotiate: isNegotiate));
  }

  void setDescription(String description) {
    updateState((buildable) => buildable.copyWith(description: description));
  }

  void setCategory(CategoryResponse? categoryResponse) {
    display.success("set category ");
    updateState(
        (buildable) => buildable.copyWith(categoryResponse: categoryResponse));
  }

  void setFromPrice(String fromPrice) {
    updateState((buildable) => buildable.copyWith(fromPrice: fromPrice));
  }

  void setToPrice(String toPrice) {
    updateState((buildable) => buildable.copyWith(toPrice: toPrice));
  }

  void setPhoneNumber(String phoneNumber) {
    updateState((buildable) => buildable.copyWith(phone: phoneNumber));
  }

  void setEmail(String email) {
    updateState((buildable) => buildable.copyWith(email: email));
  }

  void setUserAddress(UserAddressResponse userAddressResponse) {
    display.success("address set");
    updateState((buildable) =>
        buildable.copyWith(userAddressResponse: userAddressResponse));
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
          emitEvent(
            CreateProductOrderListenable(
              CreateProductOrderEffect.onOverMaxCount,
              maxImageCount: currentState.maxImageCount,
            ),
          );
        }
        if ((addedCount + newCount) > maxCount) {
          emitEvent(
            CreateProductOrderListenable(
              CreateProductOrderEffect.onOverMaxCount,
              maxImageCount: currentState.maxImageCount,
            ),
          );

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
}
