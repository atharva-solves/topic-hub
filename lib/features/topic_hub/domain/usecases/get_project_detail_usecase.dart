import 'package:getx_memo_app/features/topic_hub/domain/entities/project_detail_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/repositories/topichub_repo.dart';

class GetProjectDetailUsecase {
  final TopichubRepo _topichubRepo;
  GetProjectDetailUsecase({required TopichubRepo topichubRepo})
    : _topichubRepo = topichubRepo;

  Future<List<ProjectDetailEntity>> getProjectDetailUsecase(
    String subCategoryId,
  ) async {
    try {
      final List<ProjectDetailEntity> projectDetails = await _topichubRepo
          .getProjectdetail(subCategoryId);

      return projectDetails;
    } catch (e) {
      rethrow;
    }
  }
}
