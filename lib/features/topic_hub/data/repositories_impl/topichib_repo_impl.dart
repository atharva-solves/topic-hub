import 'package:getx_memo_app/features/topic_hub/data/data_models/category_model.dart';
import 'package:getx_memo_app/features/topic_hub/data/data_sources/topichub_remote_data_source.dart';
import 'package:getx_memo_app/features/topic_hub/domain/repositories/topichub_repo.dart';

//1.data source management (what if no internet ,fetch from LDS)
//  LDS caching (after fetching from API , cache it save it locally safe side)

//2.technical error handling (dio/http if canged in future)
//3.Database combined task. (fetch from API,compare locally saved fav flags, isFav=true for that id)

class TopichibRepoImpl implements TopichubRepo {
  //Dec,Constr init list,meth with trycatch

  final TopichubRemoteDataSource _topichubRemoteDataSource;

  TopichibRepoImpl({required TopichubRemoteDataSource topichubRemoteDataSource})
    : _topichubRemoteDataSource = topichubRemoteDataSource;

  @override
  Future<List<CategoryModel>> getParentCategories() async {
    try {
      print("====== topichub repo imple Starts =======");

      final List<CategoryModel> listParentCategory =
          await _topichubRemoteDataSource.getParentCategories();

      print(
        'fetched list of ${listParentCategory.length} ParentCat from Remote DS',
      );
      print('passing to usecase');
      print('====== Topichub Repo Impl End ======');

      return listParentCategory;
    } catch (e) {
      print('Exception caught : $e');

      print('====== Topichub Repo Impl End ======');

      rethrow;
    }
  }
}
