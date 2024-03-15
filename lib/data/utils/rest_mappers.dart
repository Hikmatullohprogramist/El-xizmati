extension DistrictIdExts on List<int> {
  List<Map<String, int>> toMap() {
    return map((id) => {'district_id': id}).toList();
  }
}
