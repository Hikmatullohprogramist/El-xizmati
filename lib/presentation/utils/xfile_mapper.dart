import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';

extension XFileExtension on XFile {
  UploadableFile toUploadableFile() {
    return UploadableFile(xFile: this);
  }

  File toFile() {
    return File(path);
  }

  FileImage toFileImage() {
    return FileImage(File(path));
  }

  Future<XFile> compressImage({int quality = 30}) async {
    final file = toFile();
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${file.absolute.path}_compressed.jpg',
      quality: quality > 0 && quality <= 100 ? quality : 50,
    );
    return compressedFile!;
  }
}
