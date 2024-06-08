import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:world_news/models/category%20news/news_category_model.dart';
import 'package:world_news/models/news_headlines/news_healines_model.dart';
import 'package:world_news/res/api_urls/api_url.dart';
import 'package:world_news/res/assets/image_assets.dart';
import 'package:world_news/res/routes/routes_name.dart';
import 'package:world_news/view/news%20details/news_details.dart';
import 'package:world_news/view_model/category%20view%20model/category_view_model.dart';
import 'package:world_news/view_model/news%20channels%20headlines/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum newsFilterList { bbcNews, aryNews, cnnNews, foxSports }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  CategoryNewsViewModel categoryViewModel = CategoryNewsViewModel();
  final dateFormat = DateFormat('MMMM, dd, yyyy');
  newsFilterList? selectedValue;
  // String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.categoryScreen);
          },
          icon: Image.asset(ImageAssets.categoryIcon),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<newsFilterList>(
              initialValue: selectedValue,
              onSelected: (newsFilterList item) {
                if (newsFilterList.aryNews.name == item.name) {
                  ApiUrl.channelName = 'ary-news';
                } else if (newsFilterList.bbcNews.name == item.name) {
                  ApiUrl.channelName = 'bbc-news';
                } else if (newsFilterList.cnnNews.name == item.name) {
                  ApiUrl.channelName = 'cnn';
                } else if (newsFilterList.foxSports.name == item.name) {
                  ApiUrl.channelName = 'fox-sports';
                }
                ApiUrl.setChannelName(ApiUrl.channelName);
                print(ApiUrl.channelName.toString());

                setState(() {
                  selectedValue = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<newsFilterList>>[
                    PopupMenuItem<newsFilterList>(
                      value: newsFilterList.aryNews,
                      child: Text('Ary News'),
                    ),
                    PopupMenuItem<newsFilterList>(
                      value: newsFilterList.bbcNews,
                      child: Text('BBC News'),
                    ),
                    PopupMenuItem<newsFilterList>(
                      value: newsFilterList.cnnNews,
                      child: Text('CNN'),
                    ),
                    PopupMenuItem<newsFilterList>(
                      value: newsFilterList.foxSports,
                      child: Text('Fox Sports'),
                    ),
                  ]),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsHeadlinesModel>(
                future: newsViewModel
                    .fetchNewsChannelsHeadlinesApi(ApiUrl.channelName),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        size: 40,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> NewsDetails(
                                newImage: snapshot
                              .data!.articles![index].urlToImage
                              .toString(), 
                                newData: snapshot
                              .data!.articles![index].publishedAt
                              .toString(), 
                                newTitle: snapshot
                              .data!.articles![index].title
                              .toString(), 
                                auhor: snapshot
                              .data!.articles![index].author
                              .toString(), 
                                description: snapshot
                              .data!.articles![index].description
                              .toString(), 
                                content: snapshot
                              .data!.articles![index].content
                              .toString(), 
                                source: snapshot
                              .data!.articles![index].source!.name
                              .toString())
                                )
                                );
                            },
                            child: SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: height * 0.6,
                                    width: width * .9,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.02,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Container(
                                          child: spinKit2,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error_outline,
                                                color: Colors.red),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        height: height * .22,
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: width * 0.7,
                                              child: Text(
                                                snapshot
                                                    .data!.articles![index].title
                                                    .toString(),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: width * 0.7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    dateFormat.format(dateTime),
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          ),
      
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: FutureBuilder<CategoryNewsModel>(
                      future: categoryViewModel
                          .fetchCategoriesNewsApi(ApiUrl.categoryName),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: SpinKitCircle(
                              size: 40,
                              color: Colors.blue,
                            ),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data!.articles!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                DateTime dateTime = DateTime.parse(snapshot
                                    .data!.articles![index].publishedAt
                                    .toString());
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: height * .18,
                                          width: width * .3,
                                          placeholder: (context, url) => Container(
                                            child: Center(
                                              child: SpinKitCircle(
                                                size: 40,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error_outline,
                                                  color: Colors.red),
                                        ),
                                      ),
                                     Expanded(
                                        child: Container(
                                          height: height * .18,
                                          padding: EdgeInsets.only(left: 5),
                                        child: Column(
                                          children: [
                                           Text(
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            snapshot
                                              .data!.articles![index].title
                                              .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700
                                              ),),
                                              Spacer(),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(snapshot
                                              .data!.articles![index].source!.name
                                              .toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600
                                              ),),
                                              Text(
                                                overflow: TextOverflow.ellipsis,
                                                dateFormat.format(dateTime),
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500
                                              ),),
                                                  
                                    ],
                                  ),
                                          ],
                                        ),
                                        ),
                                     ),
                                    ],
                                  ),
                                );
                              });
                        }
                      }),
          ),
      
         
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
