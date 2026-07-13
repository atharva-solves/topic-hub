import 'package:get/get.dart';
import 'package:getx_memo_app/core/network/dio_client.dart';
import 'package:getx_memo_app/features/topic_hub/data/data_sources/topichub_remote_data_source.dart';
import 'package:getx_memo_app/features/topic_hub/data/repositories_impl/topichib_repo_impl.dart';
import 'package:getx_memo_app/features/topic_hub/domain/repositories/topichub_repo.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_parent_categories_usecase.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/controllers/parent_categories_controller.dart';

//WHY? :
//     SoC :
//     UI<- req ctr<UC<repo<RDS<DioClient (actually instances of them)
//     waterfall of instance initialization
//     UI needs to be dumb ,not init.

//what : class for Dep Inj (Bindings)
//       Ensure checklist is

//HOW :
//      ext Bindings
//      @ovr dep()
//      Get.lazyput<Type>(()=>impl);
//      impl(req: Get.find())

//lazyPut --> init only when screen is actually opened

class ParentCategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TopichubRemoteDataSource>(
      () => TopichubRemoteDataSourceImpl(dioClient: Get.find()),
    );

    Get.lazyPut<TopichubRepo>(
      () => TopichibRepoImpl(topichubRemoteDataSource: Get.find()),
    );

    Get.lazyPut<GetParentCategoriesUsecase>(
      () => GetParentCategoriesUsecase(topichubRepo: Get.find()),
    );

    Get.lazyPut<ParentCategoriesController>(
      () => ParentCategoriesController(getParentCategoriesUsecase: Get.find()),
    );

    print('===== Topichub Dep Inj with binding END =====');
  }
}
