enum AdPriorityLevel {
  top,
  standard;

  static AdPriorityLevel valueOrDefault(String? stringValue) {
    return stringValue?.contains("TOP") == true
        ? AdPriorityLevel.top
        : AdPriorityLevel.standard;
  }
}
