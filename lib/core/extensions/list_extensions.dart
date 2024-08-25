import 'package:collection/collection.dart';
import 'package:El_xizmati/domain/models/ad/ad.dart';

extension ListExtensions<T> on List<T> {
  T? getOrNull(int index) {
    return index >= 0 && index < length ? this[index] : null;
  }

  bool containsIf(bool Function(T element) condition) {
    // for (var element in this) {
    //   if (condition(element)) {
    //     return true;
    //   }
    // }
    // return false;
    return any(condition);
  }

  T? firstIf(bool Function(T element) condition) {
    return firstWhereOrNull(condition);
  }

  T? lastIf(bool Function(T element) condition) {
    return lastWhereOrNull(condition);
  }

  int indexIf(bool Function(T element) condition) {
    return indexWhere(condition);
  }

  void removeIf(bool Function(T element) condition) {
    return removeWhere(condition);
  }

  List<T> filterIf(bool Function(T element) condition) {
    return where(condition).toList();
  }

  // List<T> sortIf(bool Function(T element) condition) {
  //   return ;
  // }

  List<T> notContainsItems(List<T> other) {
    var setA = Set<T>.from(this);
    var setB = Set<T>.from(other);
    return setB.difference(setA).toList();
  }
}

extension MapExtensions<K, V> on Map<K, V> {
  V? getOrNull(K key) {
    return containsKey(key) ? this[key] : null;
  }
}

extension AdListExtensions on List<Ad> {
  List<int> adIds() {
    return map((e) => e.id).toList();
  }

  void sortByIds(List<int> adIds) {
     sort((a, b) => adIds.indexOf(a.id).compareTo(adIds.indexOf(b.id)));
  }

  int cartCount() {
    return filterIf((e) => e.isInCart).length;
  }

  int favoriteCount() {
    return filterIf((e) => e.isFavorite).length;
  }
}
