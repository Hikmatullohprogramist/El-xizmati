import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../data/responses/address/user_address_response.dart';

part 'create_product_ad_cubit.freezed.dart';

part 'create_product_ad_state.dart';

@Injectable()
class CreateProductAdCubit
    extends BaseCubit<CreateProductAdBuildable, CreateProductAdListenable> {
  CreateProductAdCubit() : super(const CreateProductAdBuildable());

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

  void setSelectedCategory(CategoryResponse category) {
    build((buildable) => buildable.copyWith(category: category));
  }

  void setSelectedAddress(UserAddressResponse address) {
    build((buildable) => buildable.copyWith(address: address));
  }

  void setAgreedPrice(bool isAgreedPrice) {
    build((buildable) => buildable.copyWith(isAgreedPrice: isAgreedPrice));
  }

  void setAutoRenewal(bool isAutoRenewal) {
    build((buildable) => buildable.copyWith(isAutoRenewal: isAutoRenewal));
  }

  void setShowMySocialAccounts(bool isShowMySocialAccount) {
    build((buildable) =>
        buildable.copyWith(isShowMySocialAccount: isShowMySocialAccount));
  }
}
