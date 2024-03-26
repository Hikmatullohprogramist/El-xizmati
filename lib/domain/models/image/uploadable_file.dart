import 'package:flutter_image_compress/flutter_image_compress.dart';

class UploadableFile {
  UploadableFile({
    this.id,
    this.name,
    this.localPath,
    this.extension,
    required this.xFile,
  });

  UploadableFile copy() {
    return UploadableFile(
      id: id,
      name: name,
      localPath: localPath,
      extension: extension,
      xFile: xFile,
    );
  }

  String? id;
  String? name;
  String? localPath;
  String? extension;
  XFile xFile;

  bool isUploaded() {
    return id?.isNotEmpty == true;
  }

  bool isNotUploaded() {
    return id == null || id?.isEmpty == true;
  }
}
