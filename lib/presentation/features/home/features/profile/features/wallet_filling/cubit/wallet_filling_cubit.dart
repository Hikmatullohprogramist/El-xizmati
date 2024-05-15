import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'wallet_filling_cubit.freezed.dart';
part 'wallet_filling_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(const PageState());
}
