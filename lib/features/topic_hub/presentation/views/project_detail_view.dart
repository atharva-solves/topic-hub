import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import '../controllers/project_detail_controller.dart';

class ProjectDetailView extends GetView<ProjectDetailController> {
  const ProjectDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],

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

      // SingleChildScrollView: The medium-level widget preventing pixel overflow
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade200, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hero Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                    22,
                  ), // Mathematically aligned inside the border
                ),
                child: Image.network(
                  controller.projectImage,
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 240,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 48,
                    ),
                  ),
                ),
              ),

              // 2. Text Content Area
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dynamic Project Title
                    Text(
                      controller.projectTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Editorial Section Divider
                    Text(
                      'Overview'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[400],
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 12),

                    //the reg exp way
                    // Dynamic Project Description (Basic text widget, 100% Dumb UI)
                    Text(
                      controller.projectDescription,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        height: 1.6, // Taller line-height for easier reading
                      ),
                    ),

                    /* //the html wid for flutter (package way)
                    // 2. The Black-Box HTML Widget
                    HtmlWidget(
                      controller.projectDescription,
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[800],
                        height: 1.6,
                      ),
                    ), */
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
