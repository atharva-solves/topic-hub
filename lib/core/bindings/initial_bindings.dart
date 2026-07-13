import 'package:get/instance_manager.dart';
import 'package:getx_memo_app/core/network/dio_client.dart';

class InitialBindings extends Bindings{
  @override
  void dependencies() {

    //lives till entire app is live
    Get.put<DioClient>(DioClient(),permanent: true);
  }
}