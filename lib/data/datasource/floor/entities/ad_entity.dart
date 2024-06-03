import 'package:floor/floor.dart';

@Entity(tableName: "ads")
class AdEntity {
  @primaryKey
  @ColumnInfo(name: "ad_id")
  int id;

  @ColumnInfo(name: "ad_name")
  String name;

  @ColumnInfo(name: "ad_photo")
  String photo;

  @ColumnInfo(name: "ad_price")
  int price;

  @ColumnInfo(name: "ad_from_price")
  int fromPrice;

  @ColumnInfo(name: "ad_to_price")
  int toPrice;

  @ColumnInfo(name: "ad_currency_id")
  String currencyCode;

  @ColumnInfo(name: "ad_category_id")
  int categoryId;

  @ColumnInfo(name: "ad_category_name")
  String categoryName;

  @ColumnInfo(name: "ad_seller_id")
  int sellerId;

  @ColumnInfo(name: "ad_seller_name")
  String sellerName;

  @ColumnInfo(name: "ad_region_name")
  String regionName;

  @ColumnInfo(name: "ad_district_name")
  String districtName;

  @ColumnInfo(name: "ad_author_type")
  String authorType; //business,private,

  @ColumnInfo(name: "ad_item_condition")
  String itemCondition; //fresh,used,

  @ColumnInfo(name: "ad_priority_level")
  String priorityLevel; //top,standard,

  @ColumnInfo(name: "ad_transaction_type")
  String transactionType; //  SELL,FREE,EXCHANGE,SERVICE,BUY,BUY_SERVICE,

  @ColumnInfo(name: "ad_max_amount")
  int maxAmount;

  @ColumnInfo(name: "ad_is_favorite")
  bool? isFavorite;

  @ColumnInfo(name: "ad_is_in_cart")
  bool? isInCart;

  @ColumnInfo(name: "ad_is_sort")
  int isSort;

  @ColumnInfo(name: "ad_is_sell")
  bool isSell;

  @ColumnInfo(name: "ad_is_check")
  bool isCheck;

  @ColumnInfo(name: "ad_backend_id")
  int? backendId;

  @ColumnInfo(name: "ad_view_count")
  int viewCount;

  AdEntity({
    required this.id,
    required this.name,
    required this.photo,
    required this.price,
    required this.fromPrice,
    required this.toPrice,
    required this.currencyCode,
    required this.categoryId,
    required this.categoryName,
    required this.sellerId,
    required this.sellerName,
    required this.regionName,
    required this.districtName,
    required this.authorType,
    required this.itemCondition,
    required this.priorityLevel,
    required this.transactionType,
    required this.maxAmount,
    required this.isFavorite,
    required this.isInCart,
    required this.isSort,
    required this.isSell,
    required this.isCheck,
    required this.backendId,
    required this.viewCount,
  });
}
