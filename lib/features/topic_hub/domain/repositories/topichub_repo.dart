import 'package:getx_memo_app/features/topic_hub/data/data_models/parent_category_model.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/project_detail_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/sub_category_entity.dart';

//dont care from where the data is coming
//imple will handle data logic
abstract class TopichubRepo {
  //promise any implementation must provide list
  Future<List<ParentCategoryModel>> getParentCategories();
  Future<List<SubCategoryEntity>> getSubCategories(String parentId);
  Future<List<ProjectDetailEntity>> getProjectdetail(String subCategoryId);
}
