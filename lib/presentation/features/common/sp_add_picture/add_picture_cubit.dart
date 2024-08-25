import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:El_xizmati/presentation/support/extensions/compressing_exts.dart';
import 'package:El_xizmati/presentation/support/extensions/xfile_exts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../domain/models/image/uploadable_file.dart';

part 'add_picture_state.dart';

part 'add_picture_cubit.freezed.dart';

@injectable
class AddPictureCubit extends BaseCubit<AddPictureState, AddPictureEvent> {
  AddPictureCubit() : super(AddPictureState());

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? newImage =
          await picker.pickMedia();

      logger.w("Path: ${newImage?.path}");
      if (newImage != null) {
        final compressedImage = await newImage.compressImage();
        UploadableFile addedImage = compressedImage.toUploadableFile();
        updateState((state) => state.copyWith(image: addedImage));
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
        XFile compressedImage = await image.compressImage();
        UploadableFile uploadableFile = compressedImage.toUploadableFile();
        updateState((state) => state.copyWith(image:uploadableFile));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
