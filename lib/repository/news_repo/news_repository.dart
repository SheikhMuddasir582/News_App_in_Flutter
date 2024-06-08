
import 'package:world_news/data/network/network_api_services.dart';
import 'package:world_news/models/news_headlines/news_healines_model.dart';
import 'package:world_news/res/api_urls/api_url.dart';

class NewsRepository{

  final _apiService= NetworkApiServices();

  Future<NewsHeadlinesModel> fetchNewsChannelsHeadlinesApi(String channelName) async{
   dynamic response= await _apiService.getApi(ApiUrl.endUrlChannels);
   return NewsHeadlinesModel.fromJson(response);
  }
}