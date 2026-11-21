class const PageResult<T>({
  required final List<T> items,

  final String? nextCursor,
}) {
  bool get hasMore => nextCursor != null;
}
