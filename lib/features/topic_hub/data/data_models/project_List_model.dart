import 'package:getx_memo_app/features/topic_hub/domain/entities/project_list_entity.dart';

class ProjectListModel extends ProjectListEntity {
  ProjectListModel({
    required super.id,
    required super.title,
    required super.images,
    required super.description,
  });

  factory ProjectListModel.fromJson(Map<String, dynamic> json) {
    return ProjectListModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      images: json['images'] as String,
      description: json['description'] as String
    );
  }
}
