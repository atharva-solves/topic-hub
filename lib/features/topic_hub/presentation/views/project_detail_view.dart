import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Adjust the import path to match your project structure
import '../controllers/project_detail_controller.dart';

class ProjectDetailView extends GetView<ProjectDetailController> {
  const ProjectDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integration Test: Details'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Obx(() {
        // STATE A: Loading
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // STATE B: Error
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              'Error: ${controller.errorMessage.value}',
              style: const TextStyle(color: Colors.red),
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
                'SUCCESS!\nFetched ${controller.projectDetails.length} projects.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Check your console logs!'),
            ],
          ),
        );
      }),
    );
  }
}