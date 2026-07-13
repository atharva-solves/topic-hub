import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/arguments/sub_categories_arguments.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/controllers/sub_categories_controller.dart';

class SubCategoriesView extends StatefulWidget {
  const SubCategoriesView({super.key});

  @override
  State<SubCategoriesView> createState() => _SubCategoriesViewState();
}

class _SubCategoriesViewState extends State<SubCategoriesView> {
  final SubCategoriesController controller =
      Get.find<SubCategoriesController>();
  @override
  void initState() {
    super.initState();
     
   final SubCategoriesArgs args = Get.arguments as SubCategoriesArgs;

   final String parentId=args.parentId;
   final String parentTitle=args.parentTitle;
   final String parentImg=args.parentImage;  

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSubCategories(parentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integration Test Screen'),
        backgroundColor: Colors.amber, // Make it obvious this is a test screen!
      ),
      // 4. Wrap the body in Obx to listen to the controller
      body: Obx(() {
        // STATE A: Loading
        if (controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Fetching Sub-Categories...'),
              ],
            ),
          );
        }

        // STATE B: Error
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              'CRASHED!\nError: ${controller.errorMessage.value}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        // STATE C: Success
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 64),
              const SizedBox(height: 16),
              Text(
                'SUCCESS!\nLoaded ${controller.subCategories.length} items.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text('Check your debug console to see the data flow!'),
            ],
          ),
        );
      }),
    );
  }
}
