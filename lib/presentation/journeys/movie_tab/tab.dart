class Tab {
  final int index;
  final String title;

  const Tab({
    required this.title,
    required this.index,
  }) : assert(index > 0, 'index cannot be negative');
}