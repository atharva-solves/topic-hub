import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_memo_app/core/consants/app_assets/app_image_assets.dart';
import 'package:getx_memo_app/features/splash/presentation/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController>{
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Image.asset(
        AppImageAssets.splashImage,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),);
  }
}