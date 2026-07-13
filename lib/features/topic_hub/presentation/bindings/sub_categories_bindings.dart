import 'package:get/instance_manager.dart';
import 'package:getx_memo_app/features/topic_hub/data/data_sources/topichub_remote_data_source.dart';
import 'package:getx_memo_app/features/topic_hub/data/repositories_impl/topichib_repo_impl.dart';
import 'package:getx_memo_app/features/topic_hub/domain/repositories/topichub_repo.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_sub_categories_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/controllers/sub_categories_controller.dart';

class SubCategoriesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopichubRemoteDataSource>(
      () => TopichubRemoteDataSourceImpl(dioClient: Get.find()),
    );

    Get.lazyPut<TopichubRepo>(
      () => TopichibRepoImpl(topichubRemoteDataSource: Get.find()),
    );

    Get.lazyPut<GetSubCategoriesUsecase>(
      () => GetSubCategoriesUsecase(topichubRepo: Get.find()),
    );

    Get.lazyPut<SubCategoriesController>(
      () => SubCategoriesController(getSubCategoriesUsecase: Get.find()),
    );
  }
}
