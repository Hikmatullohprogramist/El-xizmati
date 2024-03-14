import 'package:flutter_image_compress/flutter_image_compress.dart';

class UploadableFile {
  const UploadableFile({
    required String id,
    required String name,
    required String localPath,
    required String? extension,
    required XFile xFile
  });
}
