import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:logger/logger.dart';
import 'package:El_xizmati/presentation/support/extensions/xfile_exts.dart';

extension XFileCompressingExts on XFile {
  Future<XFile> compressImage({int quality = 45}) async {
    final originalFile = toFile();
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      originalFile.absolute.path,
      '${originalFile.absolute.path}_compressed.jpg',
      quality: quality > 0 && quality <= 100 ? quality : 45,
    );
    if (compressedFile != null) {
      if (await originalFile.exists()) {
        await originalFile.delete();
        Logger().w("Original file deleted successfully.");
      } else {
        Logger().w("Original file does not exist.");
      }
    }
    return compressedFile!;
  }

  Future<XFile> smartCompressImage() async {
    final originalFile = toFile();
    final originalSizeKb = await originalFile.length() / 1024;
    const int minSize = 500;
    int targetSize = 500;
    if (originalSizeKb > 500 && originalSizeKb < 2048) {
      targetSize = 700;
    } else if (originalSizeKb < 4096) {
      targetSize = 900;
    } else if (originalSizeKb < 8192) {
      targetSize = 1500;
    } else {
      targetSize = 1900;
    }
    Logger().w("original file size = $originalSizeKb");
    Logger().w("target file size = $targetSize");

    if (originalSizeKb > minSize) {
      double neededPercent = 100 * targetSize / originalSizeKb;
      int compressQuality = neededPercent.clamp(0, 100).toInt();
      Logger().w(
          "needed percent = $neededPercent compress quality = $compressQuality");
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        originalFile.path,
        '${originalFile.path}_compressed.jpg',
        quality: 45,
      );

      if (compressedFile != null) {
        if (await originalFile.exists()) {
          await originalFile.delete();
          Logger().w("Original file deleted successfully.");
        } else {
          Logger().w("Original file does not exist.");
        }
      }
      return XFile(compressedFile!.path);
    } else {
      return this;
    }
  }
}
