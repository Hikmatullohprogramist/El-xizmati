extension DistrictIdExts on List<int> {
  List<Map<String, int>> toMap(String key) {
    return map((id) => {key: id}).toList();
  }
}
