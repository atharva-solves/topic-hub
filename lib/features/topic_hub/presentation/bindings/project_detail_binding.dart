import 'package:get/instance_manager.dart';
import 'package:getx_memo_app/core/network/dio_client.dart';
import 'package:getx_memo_app/features/topic_hub/data/data_sources/topichub_remote_data_source.dart';
import 'package:getx_memo_app/features/topic_hub/data/repositories_impl/topichib_repo_impl.dart';
import 'package:getx_memo_app/features/topic_hub/domain/repositories/topichub_repo.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_project_detail_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/controllers/project_detail_controller.dart';

class ProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopichubRemoteDataSource>(
      () => TopichubRemoteDataSourceImpl(dioClient: Get.find<DioClient>()),
    );

    Get.lazyPut<TopichubRepo>(
      () => TopichubRepoImpl(
        topichubRemoteDataSource: Get.find<TopichubRemoteDataSource>(),
      ),
    );

    Get.lazyPut<GetProjectDetailUsecase>(
      () => GetProjectDetailUsecase(topichubRepo: Get.find<TopichubRepo>()),
    );

    Get.lazyPut<ProjectDetailController>(
      () => ProjectDetailController(
        projectDetailUsecase: Get.find<GetProjectDetailUsecase>(),
      ),
    );
  }
}
