extension ListExtensions<E> on List<E> {
  E? getOrNull(int index) {
    return index >= 0 && index < length  ? this[index] : null;
  }
}

extension MapExtensions<K, V> on Map<K, V> {
  V? getOrNull(K key) {
    return containsKey(key) ? this[key] : null;
  }
}
