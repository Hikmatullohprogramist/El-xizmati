enum AdItemCondition {
  fresh,
  used;

  static AdItemCondition valueOrDefault(String? stringValue) {
    return stringValue?.contains("USED") == true
        ? AdItemCondition.used
        : AdItemCondition.fresh;
  }
}
