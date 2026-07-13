import 'package:getx_memo_app/features/topic_hub/domain/entities/sub_category_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/repositories/topichub_repo.dart';

class GetSubCategoriesUsecase {
  final TopichubRepo _topichubRepo;
  GetSubCategoriesUsecase({required TopichubRepo topichubRepo})
    : _topichubRepo = topichubRepo;

  Future<List<SubCategoryEntity>> execute(String parentId) async {
    try {
      return await _topichubRepo.getSubCategories(parentId);
    } catch (error) {
      rethrow;
    }
  }
}
