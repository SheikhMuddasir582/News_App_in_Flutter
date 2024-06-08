import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatefulWidget {
   String newImage, newData, newTitle, auhor, description, content, source;
   NewsDetails({super.key,
   required this.newImage,
  required this.newData,
  required this.newTitle,
  required this.auhor,
  required this.description,
  required this.content,
  required this.source,
   });

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final dateFormat = DateFormat('MMMM, dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    DateTime dateTime= DateTime.parse(widget.newData);
    return Scaffold(
       appBar: AppBar(),
       body: Stack(
        children: [
          Container(
            height: height * .45,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30), 
              ),
              child: Container(
                child: CachedNetworkImage(
                  imageUrl: widget.newImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                  ),
              ),
            ),
          ),
          Container(
            height: height * .6,
            margin: EdgeInsets.only(top: height * .4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30), 
              ),
            ),
            child: ListView(
              children: [
                Text(widget.newTitle, style: GoogleFonts.poppins(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),),
                SizedBox(height: height * .02,),
                Row(
                  children: [
                    Expanded(child: Text(widget.source, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),)),
                    Text(dateFormat.format(dateTime), style: GoogleFonts.poppins(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),),
                  ],
                ),
                SizedBox(height: height * .03,),
                Text(widget.description, style: GoogleFonts.poppins(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),),
              ],
            ),
          )
        ],
       ),
    );
  }
}