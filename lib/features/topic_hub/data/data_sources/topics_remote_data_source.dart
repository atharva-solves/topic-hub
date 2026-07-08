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

      final responseData = await _dioClient.get(ApiEndpoints.parentCategories);

      final List<dynamic> rawList = responseData as List<dynamic>;

      print('Raw response came .rawList type : ${responseData.runtimeType}');

      final List<CategoryModel> listOfCategoryModel = rawList
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      print(
        'raw list convertend to Model list : ${listOfCategoryModel.runtimeType}',
      );
      print('====== Topichub Remote DS Ends ======');
      return listOfCategoryModel;
    } catch (error) {
      print('Error Catched in RemoteDS get : $error');
      print('===== Remote DS END =====');
      rethrow;
    }
  }
}
