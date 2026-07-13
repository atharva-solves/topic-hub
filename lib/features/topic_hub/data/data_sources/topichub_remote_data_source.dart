import 'package:getx_memo_app/core/errors/app_exceptions.dart';
import 'package:getx_memo_app/core/network/api_endpoints.dart';
import 'package:getx_memo_app/core/network/dio_client.dart';
import 'package:getx_memo_app/features/topic_hub/data/data_models/category_model.dart';

//abstract to future proof swaping for test cases
abstract class TopichubRemoteDataSource {
  Future<List<CategoryModel>> getParentCategories();
}

class TopichubRemoteDataSourceImpl implements TopichubRemoteDataSource {
  //1.fields dec fin _ 2.Constr with init list for _. 3.Meth with TRY CATCH
  final DioClient _dioClient;

  TopichubRemoteDataSourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  @override
  Future<List<CategoryModel>> getParentCategories() async {
    try {
      print('====== Topic Hub RemoteDS starts =====  ');
      print('Fetching data from DIO client');

      //mocking to test custom 404 err
      //final responseData = await _dioClient.get('fake end point to test custom 404 error');


      final responseData = await _dioClient.get(ApiEndpoints.parentCategories);

      print(
        'Raw response came .rawResponse type : ${responseData.runtimeType}',
      );

      //bcz we already tested in main
      final List<dynamic> rawList = responseData as List<dynamic>;

      final List<CategoryModel> listParentCatrgories = rawList
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      print(
        'raw list convertend to Model list : ${listParentCatrgories.runtimeType}',
      );
      print('====== Topichub Remote DS Ends ======');
      return listParentCatrgories;
    } on AppException catch (error) {
      print('Error Catched in TopichubRemoteDS getParent() : $error');
      print('===== Remote DS END =====');
      rethrow;
    } catch (error) {
      print("Generic data processing err > ${error.toString()}");
      throw FetchDataException(message: 'Data processing error');
    }
  }
}
