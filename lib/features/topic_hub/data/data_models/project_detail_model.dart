import 'package:getx_memo_app/features/topic_hub/domain/entities/project_detail_entity.dart';

class ProjectDetailModel extends ProjectDetailEntity {
  ProjectDetailModel({
    required super.id,
    required super.title,
    required super.images,
  });

  factory ProjectDetailModel.fromJson(Map<String, dynamic> json) {
    return ProjectDetailModel(
      id: json['id'] as String,
      title: json['title'] as String,
      images: json['images'] as String,
    );
  }
}
