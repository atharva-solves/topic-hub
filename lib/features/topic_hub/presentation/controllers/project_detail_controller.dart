import 'package:get/get.dart';
import 'package:getx_memo_app/core/errors/app_exceptions.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/project_detail_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_parent_categories_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_project_detail_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/arguments/project_detail_arguments.dart';

class ProjectDetailController extends GetxController {
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final projectDetails = <ProjectDetailEntity>[].obs;
  late final String subCategoryId;
  final GetProjectDetailUsecase _projectDetailUsecase;

  ProjectDetailController({
    required GetProjectDetailUsecase projectDetailUsecase,
  }) : _projectDetailUsecase = projectDetailUsecase;

  @override
  void onInit() {
    super.onInit();

    final ProjectDetailArgs args = Get.arguments as ProjectDetailArgs;
    subCategoryId = args.subCategoryId;

    fetchProjectDetail(subCategoryId);
  }

  Future<void> fetchProjectDetail(String subCategoryId) async {
    try {
      errorMessage.value = '';
      isLoading.value = true;

      final List<ProjectDetailEntity> fetchedData = await _projectDetailUsecase
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
