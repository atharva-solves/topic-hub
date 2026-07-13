class SubCategoryEntity {
  final String id;
  final String title;
  final String? description;

  const SubCategoryEntity({
    required this.id,
    required this.title,
    this.description,
  });
}
