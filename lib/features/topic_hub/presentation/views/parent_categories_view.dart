import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/parent_categories_controller.dart';

class ParentCategoriesView extends GetView<ParentCategoriesController> {
  const ParentCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. Soft background color (Off-white is very modern)
      backgroundColor: Colors.grey[50],

      appBar: AppBar(
        title: const Text(
          'Topics',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0, // Slight spacing makes it look premium
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Blends into the scaffold
        elevation: 0, // Removes the ugly shadow
        foregroundColor: Colors.black, // Makes the text and icons black
      ),

      // 2. Obx makes only the body reactive.
      body: Obx(() {
        // STATE A: Loading
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        }

        // STATE B: Error from API
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // STATE C: Data is empty
        if (controller.parentCategories.isEmpty) {
          return const Center(child: Text('No topics found.'));
        }

        // STATE D: Success! Draw the UI
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          itemCount: controller.parentCategories.length,

          // The separator builds the gap BETWEEN cards
          separatorBuilder: (context, index) => const SizedBox(height: 16),

          itemBuilder: (context, index) {
            final category = controller.parentCategories[index];

            // InkWell gives us that nice ripple animation when the user taps
            return InkWell(
              onTap: () {
                print('Navigating to SubCategories for: ${category.id}');
                // We will add Get.toNamed() here later
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200, width: 1.5),
                ),
                child: Row(
                  children: [
                    // Medium-level widget: ClipRRect forces rounded corners on the image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        category.catImage ?? '',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.image_not_supported,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Medium-level widget: Expanded prevents long text from crashing the UI
                    Expanded(
                      child: Text(
                        category.catName ?? 'Unknown',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
