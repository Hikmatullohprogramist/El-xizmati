enum AdAuthorType {
  business,
  private;

  static AdAuthorType valueOrDefault(String? stringValue) {
    return stringValue?.contains("BUSINESS") == true
        ? AdAuthorType.business
        : AdAuthorType.private;
  }
}
