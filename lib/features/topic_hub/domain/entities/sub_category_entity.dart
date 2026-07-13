class SubCategoryEntity {
  final int id;
  final int parentId;
  final String title;
  final String? description;

  const SubCategoryEntity({
    required this.id,
    required this.parentId,
    required this.title,
    this.description,
  });
}
