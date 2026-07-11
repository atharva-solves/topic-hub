import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:getx_memo_app/features/topic_hub/presentation/controllers/topichub_controller.dart';


//testing Nav,routing and backed setup
class TopichubView extends GetView<TopichubController> {
  const TopichubView({super.key});
  @override
  Widget build(BuildContext context) {
    // THIS LINE WAKES UP THE ENTIRE BACKEND:
    print('Dummy UI is checking controller state: ${controller.isLoading.value}');
    
    return Scaffold(
      appBar: AppBar(title: const Text('Routing Test')),
      body: const Center(child: Text('Screen is working! Check the console.')),
    );
  }
}
