class ParentCategoryModel {
  // We use String? (nullable) because sometimes APIs return null for missing images.

  //mock data processing error for RDS
  final int? id;
  //final String id;
  final String? catName;
  final String? catImage;
  final String? thumbImage;

  ParentCategoryModel({this.id, this.catName, this.catImage, this.thumbImage});

  //String keys of json(map) matches test's print .

  factory ParentCategoryModel.fromJson(Map<String, dynamic> json) {
    return ParentCategoryModel(
      // The API sends the ID as an integer (e.g., '1'), but our model expects a String.
      // Calling .toString() prevents type crash errors.

      //mock data processing error for RDS
      id: json['id'],

      // id: json['id']?.toString(),
      catName: json['cat_name'],
      catImage: json['cat_image'],
      thumbImage: json['thumb_image'],
    );
  }
}
