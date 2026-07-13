import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:getx_memo_app/core/errors/app_exceptions.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/sub_category_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_sub_categories_usecase.dart';

class SubCategoriesController extends GetxController {
  // Explicit Rx Types
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<SubCategoryEntity> subCategories = <SubCategoryEntity>[].obs;

  final GetSubCategoriesUsecase _getSubCategoriesUsecase;

  SubCategoriesController({
    required GetSubCategoriesUsecase getSubCategoriesUsecase,
  }) : _getSubCategoriesUsecase = getSubCategoriesUsecase;

  Future<void> getSubCategories(String parentId) async {
    try {
      print('Sub category Ctrl started');
      isLoading.value = true;
      errorMessage.value = '';

      List<SubCategoryEntity> fetchedData = await _getSubCategoriesUsecase
          .execute(parentId);

      print(
        'ctr fetched list of ${subCategories.runtimeType} length ${subCategories.length}',
      );
      subCategories.assignAll(fetchedData);
    } on AppException catch (customException) {
      // Assuming you have a specific message property in your AppException

      print('error in sub cat ctr > ${customException.toString()}');
      errorMessage.value = customException
          .toString(); // Swap this if you have a .message getter!
    } catch (localError) {
      print('subCat ctrl catch local err $localError ');
      errorMessage.value = 'Unexpected local error: $localError';
    } finally {
      print('Sub category Ctrl started');
      isLoading.value = false;
    }
  }
}
