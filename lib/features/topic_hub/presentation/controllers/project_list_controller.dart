import 'package:get/get.dart';
import 'package:getx_memo_app/core/errors/app_exceptions.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/project_list_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_parent_categories_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_project_list_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/arguments/project_list_arguments.dart';

class ProjectListController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final projectDetails = <ProjectListEntity>[].obs;
  late final String subCategoryId;
  final GetProjectListUsecase _projectDetailUsecase;

  ProjectListController({
    required GetProjectListUsecase projectDetailUsecase,
  }) : _projectDetailUsecase = projectDetailUsecase;

  @override
  void onInit() {
    super.onInit();

    final ProjectListArgs args = Get.arguments as ProjectListArgs;
    subCategoryId = args.subCategoryId;

    fetchProjectDetail(subCategoryId);
  }

  Future<void> fetchProjectDetail(String subCategoryId) async {
    try {
      errorMessage.value = '';
      isLoading.value = true;

      final List<ProjectListEntity> fetchedData = await _projectDetailUsecase
          .execute(subCategoryId);

      print(
        'projDet Ctr > fetchProj()>recieves ${fetchedData.length} ocjects of ProjDet',
      );

      projectDetails.value = fetchedData;
    } on AppException catch (customException) {
      print('Custom message caught in ProjecDet Ctr');
      errorMessage.value = customException.toString();
      Get.snackbar(customException.prefix, customException.exceptionMessage);
    } catch (error) {
      print('local error caught in Proj Det CTR');
      errorMessage.value = 'local error caught in details ctr';
      Get.snackbar('Error: ', "$error");
    } finally {
      isLoading.value = false;
    }
  }
}
