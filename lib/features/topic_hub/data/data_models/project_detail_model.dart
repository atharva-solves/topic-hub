import 'package:getx_memo_app/features/topic_hub/domain/entities/project_detail_entity.dart';

class ProjectDetailModel extends ProjectDetailEntity {
  ProjectDetailModel({
    required super.id,
    required super.title,
    required super.images,
    required super.description,
  });

  factory ProjectDetailModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      images: json['images'] as String,
      description: json['description'] as String
    );
  }
}
