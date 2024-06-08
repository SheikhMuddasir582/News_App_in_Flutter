

class ApiUrl{
  static String channelName= 'bbc-news';
  static const String baseUrl= 'https://newsapi.org/';
  //  static String endUrl= '$baseUrl/v2/top-headlines?sources=$channelName&your_api_key';

  static String categoryName= 'General';
   // Method to update the channel name
   static String get endUrlChannels{
    return '$baseUrl/v2/top-headlines?sources=$channelName&your_api_key';
   }
   // for categories
   static String get endUrlCategory{
    return '$baseUrl/v2/everything?q=$categoryName&your_api_key';
   }
   //set channel name method
  static void setChannelName(String name){
    channelName= name;
    print('chaneel name'+channelName.toString());
   }
    //set category name method
  static void setCategoryName(String name){
    categoryName= name;
    print('chaneel name'+channelName.toString());
   }

}