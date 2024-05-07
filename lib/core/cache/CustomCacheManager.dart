import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const KEY_CACHED_IMAGES = 'cached-network-images';
  static CacheManager imageCacheManager = CacheManager(
    Config(
      KEY_CACHED_IMAGES,
      stalePeriod: const Duration(days: 3), // Maximum saving days
      maxNrOfCacheObjects: 150, // Maximum number of files
      fileService: HttpFileService(), //
    ),
  );
}
