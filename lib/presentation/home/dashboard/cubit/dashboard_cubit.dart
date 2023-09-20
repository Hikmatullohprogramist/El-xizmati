import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/base_cubit.dart';
import '../../../../domain/repo/ads_repository.dart';

part 'dashboard_cubit.freezed.dart';
part 'dashboard_state.dart';

@injectable
class DashboardCubit
    extends BaseCubit<DashboardBuildable, DashboardListenable> {
  DashboardCubit(this.adsRepository) : super(DashboardBuildable());
  static const _pageSize = 20;

  final AdsRepository adsRepository;

  Future<void> getAdsList()async{
    try{

    }catch(e, stackTrace){

    }finally{

    }
  }
}
