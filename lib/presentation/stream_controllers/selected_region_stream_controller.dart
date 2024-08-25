import 'package:El_xizmati/core/stream/base_stream_controller.dart';
import 'package:El_xizmati/domain/models/region/set_region_event.dart';

class SelectedRegionStreamController
    extends BaseStreamController<SetRegionResult> {
  SelectedRegionStreamController({super.isBroadcast = true});
}
