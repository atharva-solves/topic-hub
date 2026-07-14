import 'package:getx_memo_app/core/errors/app_exceptions.dart';
import 'package:getx_memo_app/core/network/api_endpoints.dart';
import 'package:getx_memo_app/core/network/dio_client.dart';
import 'package:getx_memo_app/features/topic_hub/data/data_models/parent_category_model.dart';
import 'package:getx_memo_app/features/topic_hub/data/data_models/project_List_model.dart';
import 'package:getx_memo_app/features/topic_hub/data/data_models/sub_category_model.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/project_list_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/sub_category_entity.dart';

//abstract to future proof swaping for test cases
abstract class TopichubRemoteDataSource {
  Future<List<ParentCategoryModel>> getParentCategories();
  Future<List<SubCategoryEntity>> getSubCategories(String parentId);
  Future<List<ProjectListEntity>> getProjectLst(String subCategoryId);
}

class TopichubRemoteDataSourceImpl implements TopichubRemoteDataSource {
  //1.fields dec fin _ 2.Constr with init list for _. 3.Meth with TRY CATCH
  final DioClient _dioClient;

  TopichubRemoteDataSourceImpl({required DioClient dioClient})
    : _dioClient = dioClient;

  @override
  Future<List<ParentCategoryModel>> getParentCategories() async {
    try {
      print('====== Topic Hub RemoteDS starts =====  ');
      print('Fetching data from DIO client');

      //mocking to test custom 404 err
      //final responseData = await _dioClient.get('fake end point to test custom 404 error');

      final responseData = await _dioClient.get(ApiEndpoints.parentCategories);

      /* 
      //checking what this API sends us
      //hardcoding cat_id
      final projectDetailData = await _dioClient.get(
        ApiEndpoints.projectDetails,
        queryParameters: {'category_id': 3},
      );
      print('<><><> projectDetail API sent :- $projectDetailData'); */

      print(
        'Raw response came .rawResponse type : ${responseData.runtimeType}',
      );

      //bcz we already tested in main
      final List<dynamic> rawList = responseData as List<dynamic>;

      final List<ParentCategoryModel> listParentCatrgories = rawList
          .map((json) => ParentCategoryModel.fromJson(json))
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

  //SubCategories
  @override
  Future<List<SubCategoryEntity>> getSubCategories(String parentId) async {
    try {
      final responseData = await _dioClient.get(
        ApiEndpoints.subCategories,

        queryParameters: {'parent_id': parentId},
      );

      final List<dynamic> rawList = responseData as List<dynamic>;

      final List<SubCategoryEntity> subCategories = rawList.map((json) {
        print(
          '-__-__-__ SubCategory API sent map>id type > ${json['id'].runtimeType}',
        );
        return SubCategoryModel.fromJson(json);
      }).toList();

      return subCategories;
    } on AppException {
      rethrow;
    } catch (e) {
      print('-_-_-_ E R R O R TopicHub>RDS>getSubCat $e');
      throw FetchDataException(message: 'Data processing error');
    }
  }

  @override
  Future<List<ProjectListEntity>> getProjectLst(
    String subCategoryId,
  ) async {
    try {
      final response = await _dioClient.get(
        ApiEndpoints.projectList,
        queryParameters: {'category_id': subCategoryId},
      );

      print('projDet RDS >response is ->$response');

      final List<dynamic> rawList = response as List<dynamic>;
      final List<ProjectListEntity> projectList = rawList
          .map((json) => ProjectListModel.fromJson(json))
          .toList();

      return projectList;
    } on AppException catch (e) {
      rethrow;
    } catch (genericError) {
      throw FetchDataException(message: 'Data processing error');
    }
  }
}
