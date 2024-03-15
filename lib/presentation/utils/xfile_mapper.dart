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
}
