import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:world_news/models/category%20news/news_category_model.dart';
import 'package:world_news/res/api_urls/api_url.dart';
import 'package:world_news/view_model/category%20view%20model/category_view_model.dart';

class CategoryNewsScreen extends StatefulWidget {
  const CategoryNewsScreen({super.key});

  @override
  State<CategoryNewsScreen> createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  CategoryNewsViewModel categoryViewModel = CategoryNewsViewModel();
  final dateFormat = DateFormat('MMMM, dd, yyyy');
  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Sports',
    'Health',
    'Business',
    'Technology',
  ];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesList.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        ApiUrl.categoryName = categoriesList[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ApiUrl.categoryName == categoriesList[index]
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Center(
                                child: Text(
                              categoriesList[index].toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                    );
                  })),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
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
                                   )
                                  ],
                                ),
                              );
                            });
                      }
                    }),
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
