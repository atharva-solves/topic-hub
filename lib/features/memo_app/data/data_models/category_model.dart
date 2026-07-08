// WHAT: A blueprint representing a single Category sent from the server.
// WHY: We use this to safely convert the raw Map (e.g., {id: 1, cat_name: ...})
//      into a Dart object so we can type 'category.catName' instead of 'category["cat_name"]'.
class CategoryModel {
  // We use String? (nullable) because sometimes APIs return null for missing images.
  final String? id;
  final String? catName;
  final String? catImage;
  final String? thumbImage;

  CategoryModel({this.id, this.catName, this.catImage, this.thumbImage});

  // WHAT: Factory constructor (perform action before creating obj)
  // action of fetchind data inside map .to parse the raw Map.
  // HOW: Notice how the string keys exactly match what we saw in your console output!
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      // The API sends the ID as an integer (e.g., '1'), but our model expects a String.
      // Calling .toString() prevents type crash errors.
      id: json['id']?.toString(),
      catName: json['cat_name'],
      catImage: json['cat_image'],
      thumbImage: json['thumb_image'],
    );
  }
}
