import 'package:get/get.dart';
import 'package:getx_memo_app/core/errors/app_exceptions.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/project_list_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_parent_categories_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_project_list_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/arguments/project_list_arguments.dart';

class ProjectListController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final projectList = <ProjectListEntity>[].obs;
  late final String subCategoryId;
  late final String subCategoryTitle;
  late final String subCategoryImage;
  final GetProjectListUsecase _projectListUsecase;

  ProjectListController({required GetProjectListUsecase projectDetailUsecase})
    : _projectListUsecase = projectDetailUsecase;

  @override
  void onInit() {
    super.onInit();

    final ProjectListArgs args = Get.arguments as ProjectListArgs;
    subCategoryId = args.subCategoryId;
    subCategoryTitle = args.subCategoryTitle;
    subCategoryImage = args.subCateoryImage;

    fetchProjectDetail(subCategoryId);
  }

  Future<void> fetchProjectDetail(String subCategoryId) async {
    try {
      errorMessage.value = '';
      isLoading.value = true;

      final List<ProjectListEntity> fetchedData = await _projectListUsecase
          .execute(subCategoryId);

      print(
        'projDet Ctr > fetchProj()>recieves ${fetchedData.length} ocjects of ProjDet',
      );

      projectList.value = fetchedData;
    } on AppException catch (customException) {
      print('Custom message caught in ProjecDet Ctr');
      errorMessage.value = customException.toString();
      Get.snackbar(
        customException.prefix,
        customException.exceptionMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      print('local error caught in Proj Det CTR');
      errorMessage.value = 'local error caught in details ctr';
      Get.snackbar('Error: ', "$error");
    } finally {
      isLoading.value = false;
    }
  }
}
