import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

part 'photo_view_cubit.freezed.dart';

part 'photo_view_state.dart';

@Injectable()
class PhotoViewCubit
    extends BaseCubit<PhotoViewBuildable, PhotoViewListenable> {
  PhotoViewCubit() : super(PhotoViewBuildable());
}
