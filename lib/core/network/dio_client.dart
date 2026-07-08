import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:getx_memo_app/core/network/api_endpoints.dart';

class DioClient {
  //1 declare 2.Constr with init List 3.param config 4.meth

  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
          responseType: ResponseType.json,
        ),
      );

  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    //Debuggin : REQUEST INFO
    print('=====================');
    print('API GET REQUEST STARTED in dio client');
    print('End point : $endpoint');
    if (queryParameters != null) {
      print('Query Parameter :$queryParameters');
    }
    //-------------

    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      //if this fails,never established a communication ,no response or Error package---->REDIRECT TO CATCH;

      //Debug Resp
      print('Status code : ${response.statusCode}');

      if (response.statusCode == 200) {
        //STORE response came from server
        var finalData = response.data;

        //Double Deserialization
        if (finalData is String) {
          print(
            'Debug: Caught Double serialized json String.now parsing it manually',
          );
          finalData = jsonDecode(finalData);
        }

        print('API REQUEST DONE');
        print('================');

        return finalData;
      } else {
        //for HTTP errors , talk established with the server.Server responded failure

        print(' API GET REQUEST FAILED (Status: ${response.statusCode})');
        print('========================================');

        //throw general error as of now .Proper Error handler will handle it
        throw Exception(
          'Server responded with status code : ${response.statusCode}',
        );
      }
    } catch (error) {
      //cannot even reach the server in the first place.
      //catch dio / Internet errors

      print('API Get request error');
      print('Details:$error');
      print('==============');

      //pass error up the cain to show in UI
      rethrow;
    }
  }
}
