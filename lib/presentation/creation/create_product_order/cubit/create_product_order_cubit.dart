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
    build((buildable) => buildable.copyWith(name: name));
  }

  void setNegative(bool isNegotiate) {
    build((buildable) => buildable.copyWith(isNegotiate: isNegotiate));
  }

  void setDescription(String description) {
    build((buildable) => buildable.copyWith(description: description));
  }

  void setCategory(CategoryResponse? categoryResponse) {
    display.success("set category ");
    build(
        (buildable) => buildable.copyWith(categoryResponse: categoryResponse));
  }

  void setFromPrice(String fromPrice) {
    build((buildable) => buildable.copyWith(fromPrice: fromPrice));
  }

  void setToPrice(String toPrice) {
    build((buildable) => buildable.copyWith(toPrice: toPrice));
  }

  void setPhoneNumber(String phoneNumber) {
    build((buildable) => buildable.copyWith(phone: phoneNumber));
  }

  void setEmail(String email) {
    build((buildable) => buildable.copyWith(email: email));
  }

  void setUserAddress(UserAddressResponse userAddressResponse) {
    display.success("address set");
    build((buildable) =>
        buildable.copyWith(userAddressResponse: userAddressResponse));
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
          invoke(
            CreateProductOrderListenable(
              CreateProductOrderEffect.onOverMaxCount,
              maxImageCount: buildable.maxImageCount,
            ),
          );
        }
        if ((addedCount + newCount) > maxCount) {
          invoke(
            CreateProductOrderListenable(
              CreateProductOrderEffect.onOverMaxCount,
              maxImageCount: buildable.maxImageCount,
            ),
          );

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
}
