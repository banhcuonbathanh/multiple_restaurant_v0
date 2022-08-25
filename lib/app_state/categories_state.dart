import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:untitled1/exception/repository_exception.dart';
import 'package:untitled1/model/category_model.dart';
import 'package:untitled1/utils.dart';

import '../app_provider/api_provider.dart';

import '../app_provider/utility_provider.dart';

// List<Category>
class CategoryState extends StateNotifier<List<CategoryModel>> {
  CategoryState(this.read, [List<CategoryModel>? state])
      : super(state ?? const []) {
    getAllCategories();
  }
  final Reader read;
  List<CategoryModel>? previousState;
  // void addCategoryList(List<Category> newCategory) {
  //   state = [...state, ...newCategory];
  // }
  Future<void> createCategory(
      {required String categoryImage,
      required String categoryName,
      required String categoryId,
      required bool ship,
      required bool booking}) async {
    _cacheState();

    try {
      final response = await read(API.category).createCategory(
          categoryImage: categoryImage,
          categoryName: categoryName,
          categoryId: categoryId,
          ship: ship,
          booking: booking);

      if (state == []) {
        state = [response];
      } else {
        state = [...state, response];
      }
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> getAllCategories() async {
    try {
      final categories = await read(API.category).getAllCategory();
      state = [...categories];
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> retryLoadingTodo() async {
    try {
      final todos = await read(API.category).getAllCategory();
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> editCategories({
    required String categoryImage,
    required String categoryName,
    required String categoryId,
    required bool ship,
    required bool booking,
  }) async {
    _cacheState();
    // state = state.whenData((categories) {
    //   return [
    //     for (final category in categories)
    //       if (category.categoryId == categoryId)
    //         CategoryModel(
    //             categoryImage: categoryImage,
    //             categoryName: categoryName,
    //             categoryId: categoryId,
    //             ship: ship,
    //             booking: booking)
    //       else
    //         category
    //   ];
    // });

    state = [
      for (final category in state)
        if (category.categoryId == categoryId)
          CategoryModel(
              categoryName: categoryName,
              categoryImage: categoryImage,
              categoryId: categoryId,
              ship: ship,
              booking: booking)
        else
          category
    ];
    try {
      await read(API.category).getoneandupdate(
          booking: booking,
          categoryId: categoryId,
          categoryImage: categoryImage,
          categoryName: categoryName,
          ship: ship);
    } on Exception catch (e, st) {
      logger.severe('Repository Exception', e, st);
      throw RepositoryException(
          message: 'Repository Exception', exception: e, stackTrace: st);
    }
  }

  Future<void> deleteProduct({required String categoryId}) async {
    _cacheState();
    // state = state.whenData(
    //   (value) =>
    //       value.where((element) => element.categoryId != categoryId).toList(),
    // );

    state = state.where((element) => element.categoryId != categoryId).toList();
    try {
      await read(API.category).getOneandDelete(categoryId: categoryId);
    } catch (e, st) {}
  }
  // Future<void> editCategory({required String categoryImage,
  //     required String categoryName,
  //     required String categoryId,
  //     required bool ship,
  //     required bool booking}) async {
  //   _cacheState();
  //   state = state.whenData((categories) {
  //     return [
  //       for (final category in categories)
  //         if (category.categoryId == categoryId)
  //            Category(
  //             booking: booking,
  //             categoryId: categoryId,
  //             categoryImage: categoryImage,
  //             categoryName: categoryName,
  //             ship: ship)

  //         else
  //           category
  //     ];
  //   });

  //   try {
  //     await read(todoRepositoryProvider).edit(id: id, description: description);
  //   } on CategoryException catch (e) {
  //     _handleException(e);
  //   }
  // }

  void _cacheState() {
    previousState = state;
  }

  // void _resetState() {
  //   if (previousState != null) {
  //     state = previousState!;
  //     previousState = null;
  //   }
  // }

  // void _handleException(CategoryException e) {
  //   _resetState();
  //   read(categoryExceptionProvider.notifier).state = e;
  // }
}
