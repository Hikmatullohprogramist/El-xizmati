import 'package:onlinebozor/data/datasource/network/responses/banner/banner_response.dart';
import 'package:onlinebozor/domain/models/banner/banner_image.dart';

extension BannerMapper on BannerResponse {
  BannerImage toBanner() {
    return BannerImage(
      id: id,
      actionType: actionType ?? "",
      actionData: actionData ?? "",
      imageId: image ?? "",
    );
  }
}
