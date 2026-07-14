import 'package:get/get.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/controllers/project_detail_controller.dart';

class ProjectDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectDetailController>(() => ProjectDetailController());
  }
}
