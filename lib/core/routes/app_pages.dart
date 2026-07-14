import 'package:get/route_manager.dart';
import 'package:getx_memo_app/core/routes/app_routes.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/bindings/parent_categories_binding.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/bindings/project_detail_binding.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/bindings/sub_categories_bindings.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/views/parent_categories_view.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/views/project_detail_view.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/views/sub_categories_view.dart';

//central registery -> [route name - room (View/Screen) - checkList prepared (bindings)]

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.parentCategories,
      page: () => const ParentCategoriesView(),
      binding: ParentCategoriesBindin(),
    ),
    GetPage(
      name: AppRoutes.subCategories,
      page: () => const SubCategoriesView(),
      binding: SubCategoriesBinding(),
    ),

    GetPage(
      name: AppRoutes.projectDetail,
      page: () => const ProjectDetailView(),
      binding: ProjectDetailBinding(),
    ),
  ];
}
