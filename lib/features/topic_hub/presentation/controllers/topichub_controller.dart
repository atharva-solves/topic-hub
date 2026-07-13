import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:getx_memo_app/core/errors/app_exceptions.dart';
import 'package:getx_memo_app/features/topic_hub/data/data_models/parent_category_model.dart';
import 'package:getx_memo_app/features/topic_hub/domain/usecases/get_parent_categories_usecase.dart';

//UI =>dumb .should only know what to show right now (err msg ,load spinner,list)
//ctr=> fetch data.hold these states and notify UI when they change (obs)
//how? with .obs (reactive programming)

//new concept : list.assignAll ->same mem loc,just edits existing (101fm)
//              list=newList ->create new mem loc obj (102 fm) ,But UI would still listening to old (101fm)
//             therefore .add ,.addAll , .assignAll

class TopichubController extends GetxController {
  //1 field _usecase obj & var .obs(1.isLoad, 2.list,3.err msg)
  //2 constr with init list
  //3 @override lifecycle methods [onInit()]
  //4 custom meth with TRY CATCH FINALLY

  final GetParentCategoriesUsecase _getParentCategoriesUsecase;

  var isLoading = false.obs;
  var parentCategories = <ParentCategoryModel>[].obs;
  var errorMessage = ''.obs;

  TopichubController({
    required GetParentCategoriesUsecase getParentCategoriesUsecase,
  }) : _getParentCategoriesUsecase = getParentCategoriesUsecase;

  //executes automatically for the first time when , UI view called/opened
  @override
  void onInit() {
    super.onInit();

    //custom function
    fetchParentCategories();
  }

  Future<void> fetchParentCategories() async {
    print('==== ctr>fetchParCat END =====');

    try {
      isLoading.value = true;

      //Clear Old msg
      errorMessage.value = '';

      //useCase.execute or .call NO NEEDED
      //bcz meth named call();
      final List<ParentCategoryModel> result = await _getParentCategoriesUsecase();

      parentCategories.assignAll(result);

      print(
        'parent categories fetch succefully : length :${parentCategories.length} , type : ${parentCategories.runtimeType}',
      );
    } on AppException catch (customError) {
      print('parent Ctr>custom err caught : $customError');

      errorMessage.value = customError.toString();

      Get.snackbar(
        customError.prefix, //title
        customError.exceptionMessage, //msg
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      print('Ctr->FallBack Catch for generic Dart/Logic err :$error');
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
      print('==== ctr>fetchParCat END =====');
    }
  }
}
