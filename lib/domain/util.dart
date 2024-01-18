enum AdPropertyStatus { fresh, used }

enum AdAuthorType { business, private }

enum AdTypeStatus { sell, free, exchange, service, buy, buyService }

enum AdStatus { top, standard }

enum AdListType {
  homeList,
  homePopularAds,
  collectionCheapAds,
  collectionPopularAds,
  popularCategoryAds,
  sellerProductAds,
  similarAds,
}

enum AdType { product, service }

enum Currency { eur, usd, rub, uzb }

enum StatsType { view, selected, phone, message }

enum UserAdStatus {
  all,
  active,
  wait,
  inactive,
  rejected,
  canceled,
  sysCanceled
}

enum UserOrderStatus {
  accept,
  all,
  active,
  wait,
  inactive,
  rejected,
  canceled,
  sysCanceled,
  review
}

enum OrderType { buy, sell }
