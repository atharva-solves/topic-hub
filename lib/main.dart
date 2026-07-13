import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_memo_app/core/bindings/initial_bindings.dart';
import 'package:getx_memo_app/core/network/api_endpoints.dart';
import 'package:getx_memo_app/core/network/dio_client.dart';
import 'package:getx_memo_app/core/routes/app_pages.dart';
import 'package:getx_memo_app/core/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TopicHub App',
      initialRoute: AppRoutes.topichub,
      initialBinding: InitialBindings(),
      getPages: AppPages.pages,
    );
  }
}




//API RESPONSE Inspecting
/* 
class ApiTestView extends StatefulWidget {
  const ApiTestView({super.key});

  @override
  State<ApiTestView> createState() => _ApiTestViewState();
}

class _ApiTestViewState extends State<ApiTestView> {
  //Initialize network engine
  final DioClient _dioClient = DioClient();

  //show this message(changable ,stf) in UI
  String consoleStatus = "Press the button below to test the API . . ";

  //meth
  Future<void> checkRawServerData() async {
    setState(() {
      consoleStatus = "connecting to server , check VS code terminal";
    });
    try {
      final rawData =await  _dioClient.get(ApiEndpoints.parentCategories);

      print('Response Type : ${rawData.runtimeType}');
      print('Data body in rawData response : $rawData');

      setState(() { 
        consoleStatus = "API fetch and Test Successful .See Trminal of VS code";
      });
    } catch (error) {
      setState(() {
        consoleStatus = "Error Catched : $error";
      });

      print('Error Catched : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Console Scanner')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            consoleStatus,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: checkRawServerData,
        child: const Icon(Icons.cloud_download),
      ),
    );
  }
}
 */