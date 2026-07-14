import 'package:get/get.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/arguments/project_detail_arguments.dart';

class ProjectDetailController extends GetxController {
  late final String subCategoryTitle;
  late final String projectTitle;
  late final String projectImage;
  late final String projectDescription;
  @override
  void onInit() {
    super.onInit();
    final ProjectDetailArguments args = Get.arguments as ProjectDetailArguments;

    subCategoryTitle = _stripHtml(args.subCategoryTitle);
    projectTitle = _stripHtml(args.projectTitle);
    projectImage = _stripHtml(args.projectImage);
    projectDescription = _stripHtml(args.projectDescription);
  }

  // A private helper function to sanitize the string
  String _stripHtml(String htmlString) {
    // 1. Replace block elements like </p>, </li>, </h1> with newlines for spacing
    String step1 = htmlString.replaceAll(RegExp(r'<\/p>|<\/li>|<\/h[1-6]>'), '\n\n');
    // 2. Strip all remaining HTML tags
    String step2 = step1.replaceAll(RegExp(r'<[^>]*>'), '');
    // 3. Clean up HTML entities like &ndash; or &nbsp;
    String step3 = step2.replaceAll(RegExp(r'&[^;]+;'), ' ');
    // 4. Trim extra spacing
    return step3.trim();
  }
}
