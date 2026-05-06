class HomeCountry {
  const HomeCountry({required this.id, required this.name, required this.slug});

  static const all = HomeCountry(id: '', name: 'Tất cả quốc gia', slug: '');

  final String id;
  final String name;
  final String slug;
}
