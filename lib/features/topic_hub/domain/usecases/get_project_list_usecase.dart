import 'package:getx_memo_app/features/topic_hub/domain/entities/project_list_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/repositories/topichub_repo.dart';

class GetProjectListUsecase {
  final TopichubRepo _topichubRepo;
  GetProjectListUsecase({required TopichubRepo topichubRepo})
    : _topichubRepo = topichubRepo;

  Future<List<ProjectListEntity>> execute(
    String subCategoryId,
  ) async {
    try {
      final List<ProjectListEntity> projectDetails = await _topichubRepo
          .getProjectList(subCategoryId);

      return projectDetails;
    } catch (e) {
      rethrow;
    }
  }
}
