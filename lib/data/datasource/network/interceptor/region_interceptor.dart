import 'package:dio/dio.dart';
import 'package:El_xizmati/data/datasource/preference/region_preferences.dart';

class RegionInterceptor extends QueuedInterceptor {
  RegionInterceptor(this._regionPreferences);

  final RegionPreferences _regionPreferences;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_regionPreferences.isRegionSelected) {
      var regionId = _regionPreferences.regionId;
      var districtId = _regionPreferences.districtId;

      final queryParameters = {
        'region_id': regionId,
        'district_id': districtId
      };
      options.queryParameters.addAll(queryParameters);
    }

    handler.next(options);
  }
}
