//seperate class for one single action User can take
//business logic (suppose added filtering or sorting ,we do it here )

//call() --->if a function named exactly as 'call()' ,
//     allows instance to execute/act as its a function
//     no need to obj.call(). Directly--> obj(). call get executed.

import 'package:getx_memo_app/features/topic_hub/data/data_models/parent_category_model.dart';
import 'package:getx_memo_app/features/topic_hub/domain/entities/parent_category_entity.dart';
import 'package:getx_memo_app/features/topic_hub/domain/repositories/topichub_repo.dart';

class GetParentCategoriesUsecase {
  //1.fields _ obj 2.constr with init list 3.meth 'call'

  final TopichubRepo _topichubRepo;

  GetParentCategoriesUsecase({required TopichubRepo topichubRepo})
    : _topichubRepo = topichubRepo;

  //call()
  Future<List<ParentCategoryEntity>> call() async {
    try {
      print('===== Usecase GetParentCat Started =====');
      print('fetching parent list from repo');

      final List<ParentCategoryEntity> listParentCategories =
          await _topichubRepo.getParentCategories();

      print(
        'list fetched : length:${listParentCategories.length} type:${listParentCategories.runtimeType}',
      );
      print('Returning list to ctr');

      return listParentCategories;
    } catch (error) {
      print('Error Caught by usecase :GetParentCat :$error');
      print('rethrowing to ctr');

      rethrow;
    }
  }
}
