import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sub_categories_controller.dart';

class SubCategoriesView extends GetView<SubCategoriesController> {
  const SubCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Consistent modern off-white background

      appBar: AppBar(
        // Utilizing the parent arg TITLE fetched by the controller
        title: Text(
          controller.parentTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black, // Makes back button and text black
      ),

      body: Column(
        children: [
          // 1. THE HERO BANNER: Utilizing the parent arg IMAGE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Extra rounded for Gen-Z feel
              child: Image.network(
                controller.parentImage,
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 140,
                  color: Colors.grey[200],
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // 2. THE LIST (Reactive)
          Expanded(
            child: Obx(() {
              // STATE A: Loading
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              }

              // STATE B: Error
              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              // STATE C: Empty
              if (controller.subCategories.isEmpty) {
                return const Center(child: Text('No sub-categories found.'));
              }

              // STATE D: Success
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: controller.subCategories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final subCategory = controller.subCategories[index];

                  return InkWell(
                    onTap: () {
                      print('Navigating to Project Details for: ${subCategory.id}');
                      // Next phase: Navigation to projects!
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              subCategory.catImg , // Make sure this matches your entity property
                              width: 60, // Slightly smaller than parent to show hierarchy
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 60,
                                height: 60,
                                color: Colors.grey[200],
                                child: const Icon(Icons.image_not_supported, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              subCategory.title ,// Make sure this matches your entity property
                              style: const TextStyle(
                                fontSize: 16, // Slightly smaller font than parent
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}