import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

final migration1to2 = Migration(1, 2, (sqflite.Database database) async {

  await database.execute('''
      CREATE TABLE ads_new (
        ad_id INTEGER PRIMARY KEY,
        ad_name TEXT,
        ad_photo TEXT,
        ad_price INTEGER,
        ad_from_price INTEGER,
        ad_to_price INTEGER,
        ad_currency_id TEXT,
        ad_category_id INTEGER,
        ad_category_name TEXT,
        ad_seller_id INTEGER,
        ad_seller_name TEXT,
        ad_region_name TEXT,
        ad_district_name TEXT,
        ad_author_type TEXT,
        ad_item_condition TEXT,
        ad_priority_level TEXT,
        ad_transaction_type TEXT,
        ad_max_amount INTEGER,
        ad_is_favorite INTEGER,
        ad_is_in_cart INTEGER, 
        ad_is_sort INTEGER,
        ad_is_sell INTEGER,
        ad_is_check INTEGER,
        ad_backend_id INTEGER,
        ad_view_count INTEGER
      )
    ''');

  // Copy data from the old table to the new table
  await database.execute('''
      INSERT INTO ads_new (
        ad_id, ad_name, ad_photo, ad_price, ad_from_price, ad_to_price,
        ad_currency_id, ad_category_id, ad_category_name, ad_seller_id,
        ad_seller_name, ad_region_name, ad_district_name, ad_author_type,
        ad_item_condition, ad_priority_level, ad_transaction_type, ad_max_amount,
        ad_is_favorite, ad_is_in_cart, ad_is_sort, ad_is_sell, ad_is_check,
        ad_backend_id, ad_view_count
      )
      SELECT 
        ad_id, ad_name, ad_photo, ad_price, ad_from_price, ad_to_price,
        ad_currency_id, ad_category_id, ad_category_name, ad_seller_id,
        ad_seller_name, ad_region_name, ad_district_name, ad_author_type,
        ad_item_condition, ad_priority_level, ad_transaction_type, ad_max_amount,
        ad_is_favorite, ad_is_added_to_card, ad_is_sort, ad_is_sell, ad_is_check,
        ad_backend_id, ad_view_count
      FROM ads
    ''');

  // Drop the old table
  await database.execute('DROP TABLE ads');

  // Rename the new table to the old table name
  await database.execute('ALTER TABLE ads_new RENAME TO ads');

});