import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';

import '../../../../common/core/base_cubit.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(PageState());
}
