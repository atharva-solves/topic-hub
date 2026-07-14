import 'package:getx_memo_app/features/topic_hub/domain/entities/parent_category_entity.dart';

class ParentCategoryModel extends ParentCategoryEntity {
  ParentCategoryModel({super.parentId, super.parentTitle, super.parentImage});

  //String keys of json(map) matches test's print .

  factory ParentCategoryModel.fromJson(Map<String, dynamic> json) {
    return ParentCategoryModel(
      // The API sends the ID as an integer (e.g., '1'), but our model expects a String.
      // Calling .toString() prevents type crash errors.

      //mock data processing error for RDS with as int
      parentId: json['id'] as String?,

      // id: json['id']?.toString(),
      parentTitle: json['cat_name'],
      parentImage: json['cat_image'],
    );
  }
}
