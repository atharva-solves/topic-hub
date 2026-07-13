import 'package:get/route_manager.dart';
import 'package:getx_memo_app/core/routes/app_routes.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/bindings/parent_categories_binding.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/views/parent_categories_view.dart';


//central registery -> [route name - room (View/Screen) - checkList prepared (bindings)]

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.topichub,
      page: () => const ParentCategoriesView(),
      binding: ParentCategoriesBinding(),
    ),
  ];
}
