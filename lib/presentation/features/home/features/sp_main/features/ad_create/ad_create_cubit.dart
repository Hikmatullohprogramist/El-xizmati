import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:El_xizmati/presentation/support/extensions/compressing_exts.dart';
import 'package:El_xizmati/presentation/support/extensions/xfile_exts.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../../../../../domain/models/image/uploadable_file.dart';
part 'ad_create_state.dart';
part 'ad_create_cubit.freezed.dart';

@injectable
class AdCreateCubit extends BaseCubit<AdCreateState, AdCreateEvent>{
  AdCreateCubit():super(AdCreateState());
  void setScrolling(bool isScrolling){
    updateState((state)=> state.copyWith(isScrolling:isScrolling));
  }
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
  void updateLoc(Point point){
    updateState((state)=>state.copyWith(location: point));
  }
}