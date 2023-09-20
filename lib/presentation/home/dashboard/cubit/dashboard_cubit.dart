import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';
import '../../../../domain/model/ads/ads_response.dart';
import '../../../../domain/repo/ads_repository.dart';

part 'dashboard_cubit.freezed.dart';
part 'dashboard_state.dart';

@injectable
class DashboardCubit
    extends BaseCubit<DashboardBuildable, DashboardListenable> {
  DashboardCubit(this.adsRepository) : super(DashboardBuildable());
  static const _pageSize = 20;

  final AdsRepository adsRepository;

  // Future<void> getAdsList()async{
  //   build((buildable) =>
  //       buildable.copyWith(loading: buildable.adsPagingController == null));
  //   try{
  //     final controller =buildable.adsPagingController??
  //
  //   }catch(e, stackTrace){
  //
  //   }finally{
  //
  //   }
  // }
}
