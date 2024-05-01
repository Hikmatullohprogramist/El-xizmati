import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const key = 'custom-folder-for-cached-images';
  static CacheManager imageCacheManager = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 3), // Maximum saving days
      maxNrOfCacheObjects: 150, // Maximum number of files
      fileService: HttpFileService(), //
    ),
  );
}