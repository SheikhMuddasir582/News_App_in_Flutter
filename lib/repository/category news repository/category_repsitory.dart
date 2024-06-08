
import 'package:world_news/data/network/network_api_services.dart';
import 'package:world_news/models/category%20news/news_category_model.dart';
import 'package:world_news/res/api_urls/api_url.dart';

class CategoryNewsRepository{

  final _apiService= NetworkApiServices();

  Future<CategoryNewsModel> fetchCategoriesNewsApi(String category) async{
   dynamic response= await _apiService.getApi(ApiUrl.endUrlCategory);
   return CategoryNewsModel.fromJson(response);
  }
}