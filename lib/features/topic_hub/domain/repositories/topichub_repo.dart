import 'package:getx_memo_app/features/topic_hub/data/data_models/category_model.dart';

//dont care from where the data is coming
//imple will handle data logic
abstract class TopichubRepo {
  //promise any implementation must provide list
  Future<List<CategoryModel>> getParentCategories();
}
