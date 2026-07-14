import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_memo_app/core/routes/app_routes.dart';
// Make sure to import your exact ProjectDetailArguments file
import 'package:getx_memo_app/features/topic_hub/presentation/arguments/project_detail_arguments.dart';
import '../controllers/project_list_controller.dart'; 

class ProjectListView extends GetView<ProjectListController> {
  const ProjectListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // STEP 1: Background canvas setup
      backgroundColor: Colors.grey[50],
      
      // STEP 2: The minimal app header
      appBar: AppBar(
        title: Text(
          controller.subCategoryTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      
      body: Column(
        children: [
          // STEP 3: Hero Banner representation
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                controller.subCategoryImage,
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: double.infinity,
                  height: 140,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // STEP 4: The Reactive Grid/List
          Expanded(
            child: Obx(() {
              // State A: Network call is active
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              }

              // State B: Network/Data logic failed
              if (controller.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              // State C: List returned empty from server
              if (controller.projectList.isEmpty) {
                return const Center(child: Text('No projects found.'));
              }

              // State D: Render list on success
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: controller.projectList.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final project = controller.projectList[index];

                  // InkWell adds interactive ripple effect on tap
                  return InkWell(
                    onTap: () {
                      // Triggering seamless data transfer to ProjectDetailView
                      Get.toNamed(
                        AppRoutes.projectDetail,
                        arguments: ProjectDetailArguments(
                          subCategoryTitle: controller.subCategoryTitle,
                          projectTitle: project.title,
                          projectImage: project.images,
                          projectDescription: project.description, // Passed directly!
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top part of card: Clipped Image
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(18),
                            ),
                            child: Image.network(
                              project.images,
                              width: double.infinity,
                              height: 160,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: double.infinity,
                                    height: 160,
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.grey,
                                    ),
                                  ),
                            ),
                          ),
                          // Bottom part of card: Project Label
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              project.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
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