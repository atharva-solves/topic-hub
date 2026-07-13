class SubCategoryEntity {
  final String id;
  final String title;
  final String catImg;
  final String? description;

  const SubCategoryEntity({
    required this.id,
    required this.title,
    required this.catImg,
    this.description,
  });
}
