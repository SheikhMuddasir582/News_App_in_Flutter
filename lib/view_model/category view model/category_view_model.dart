

import 'package:world_news/models/category%20news/news_category_model.dart';
import 'package:world_news/repository/category%20news%20repository/category_repsitory.dart';

class CategoryNewsViewModel{
  final _repo= CategoryNewsRepository();

  Future<CategoryNewsModel> fetchCategoriesNewsApi(String category) async{
    final response= await _repo.fetchCategoriesNewsApi(category);
    return response;
  }
    
}