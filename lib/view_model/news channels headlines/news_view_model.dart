
import 'package:world_news/models/news_headlines/news_healines_model.dart';
import 'package:world_news/repository/news_repo/news_repository.dart';

class NewsViewModel{
  final _repo= NewsRepository();

  Future<NewsHeadlinesModel> fetchNewsChannelsHeadlinesApi(String channelName) async{
    final response= await _repo.fetchNewsChannelsHeadlinesApi(channelName);
    return response;
  }
    
}

// ApiResponse<NewsHeadlinesModel> newsList = ApiResponse.loading();

//   setNewsList(ApiResponse<NewsHeadlinesModel> response){
//     newsList= response;
//     notifyListeners();
//   }

//   Future<void> fetchNewsChannelsHeadlinesApi()async{

//     setNewsList(ApiResponse.loading());

//     _repo.fetchNewsChannelsHeadlinesApi().then((value){

//       setNewsList(ApiResponse.completed(value));

//     }).onError((error, stackTrace){

//       setNewsList(ApiResponse.error(error.toString()));

//     });

//   }