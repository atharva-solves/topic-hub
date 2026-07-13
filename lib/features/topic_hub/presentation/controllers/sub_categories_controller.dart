import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:getx_memo_app/core/errors/app_exceptions.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/sub_category_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_sub_categories_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/arguments/sub_categories_arguments.dart';

class SubCategoriesController extends GetxController {
  // Explicit Rx Types
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<SubCategoryEntity> subCategories = <SubCategoryEntity>[].obs;
  late final String parentImage;
  late final String parentTitle;

  final GetSubCategoriesUsecase _getSubCategoriesUsecase;

  SubCategoriesController({
    required GetSubCategoriesUsecase getSubCategoriesUsecase,
  }) : _getSubCategoriesUsecase = getSubCategoriesUsecase;
  @override
  void onInit() {
    super.onInit();
    print(' Controller waking up: Extracting routing args...');

    // 2. The Controller does the "heavy lifting" of fetching and casting the arguments
    final SubCategoriesArgs args = Get.arguments as SubCategoriesArgs;

    // 3. Save them into plain fields
    parentTitle = args.parentTitle;
    parentImage = args.parentImage;

    // 4. Fire off the API request using the ID from the args immediately!
    getSubCategories(args.parentId);
  }

  Future<void> getSubCategories(String parentId) async {
    try {
      print('Sub category Ctrl started');
      isLoading.value = true;
      errorMessage.value = '';

      final List<SubCategoryEntity> fetchedData = await _getSubCategoriesUsecase
          .execute(parentId);

      print(
        'ctr fetched list of ${fetchedData.runtimeType} length ${fetchedData.length}',
      );
      subCategories.assignAll(fetchedData);
    } on AppException catch (customException) {
      // Assuming you have a specific message property in your AppException

      print('error in sub cat ctr > ${customException.toString()}');
      errorMessage.value = customException
          .toString(); // Swap this if you have a .message getter!

      Get.snackbar(customException.prefix, customException.exceptionMessage,snackPosition: SnackPosition.BOTTOM);
    } catch (localError) {
      print('subCat ctrl catch local err $localError ');
      errorMessage.value = 'Unexpected local error: $localError';
    } finally {
      print('Sub category Ctrl started');
      isLoading.value = false;
    }
  }
}
