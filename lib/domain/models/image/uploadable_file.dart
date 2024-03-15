import 'package:flutter_image_compress/flutter_image_compress.dart';

class UploadableFile {
  UploadableFile({
    this.id,
    this.name,
    this.localPath,
    this.extension,
    required this.xFile,
  });

  String? id;
  String? name;
  String? localPath;
  String? extension;
  XFile xFile;
}
