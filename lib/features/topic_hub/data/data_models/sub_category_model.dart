import 'package:getx_memo_app/features/topic_hub/domain/entities/sub_category_entity.dart';

//no fall back and null handling
//SoC parse Json
class SubCategoryModel extends SubCategoryEntity {
  SubCategoryModel({
    required super.id,

    required super.title,
    super.description,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'] as String,

      //API's snake_case --> dart camelCase
      title: json['cat_name'] as String,
      description: json['description'] as String?,
    );
  }
}
