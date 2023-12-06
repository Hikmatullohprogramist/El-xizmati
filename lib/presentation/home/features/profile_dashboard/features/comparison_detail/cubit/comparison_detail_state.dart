part of 'comparison_detail_cubit.dart';

@freezed
class ComparisonDetailBuildable with _$ComparisonDetailBuildable {
  const factory ComparisonDetailBuildable() = _ComparisonDetailBuildable;
}

@freezed
class ComparisonDetailListenable with _$ComparisonDetailListenable {
  const factory ComparisonDetailListenable(ComparisonDetailEffect effect,
      {String? message}) = _ComparisonDetailListenable;
}

enum ComparisonDetailEffect { success }
