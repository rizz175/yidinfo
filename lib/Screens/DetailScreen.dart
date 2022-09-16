import 'dart:developer';
import 'package:html/parser.dart' show parse;

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class detailedscreen extends StatefulWidget {

  final data;
  detailedscreen(this.data);

  @override
  _detailedscreenState createState() => _detailedscreenState();
}

class _detailedscreenState extends State<detailedscreen> {


  int fontsize=20;
  late SharedPreferences prefs;

  getvalue2()
  async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      fontsize=prefs.getInt("size")??20;
    });
  }

  @override
  void initState() {
    getvalue2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: new FloatingActionButton(
        backgroundColor:Colors.orangeAccent,
        onPressed: () {
          Share.share(widget.data!["link"].toString());
          log(widget.data!["link"].toString());


        },
        child: const Icon(Icons.share,color:Colors.white),
      ),

      body:SingleChildScrollView(
        child: Column(
           children: [

             //mainimage

             Container(
               width: MediaQuery.of(context).size.width,
               margin:EdgeInsets.symmetric(horizontal:17),
               child:Padding(
                 padding: const EdgeInsets.only(bottom: 11.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height:44,),
                     GestureDetector(
                       onTap:(){
                         Navigator.of(context).pop();
                       },
                       child: Container(

                         padding:EdgeInsets.only(left:5),
                         width:30,
                         height:30,
                         decoration:BoxDecoration(
                             boxShadow: [
                               BoxShadow(
                                   color: Colors.black12,
                                   offset: Offset(1, 1),
                                   blurRadius: 1)
                             ],
                             shape:BoxShape.circle,
                             color:Colors.white54
                         ),
                         child: Center(
                           child: Icon(
                             Icons.arrow_back_ios,color:Colors.black,size:20,
                           ),
                         ),
                       ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top:18.0),
                       child: Html(
                         data: "${widget.data!["title"]["rendered"].toString()}",
                         defaultTextStyle: TextStyle(
                             fontSize: 27, fontWeight: FontWeight.bold),
                       ),
                     ),SizedBox(height:10,),
                     Row(
                       mainAxisAlignment:MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             Text("By: " ),
                             Text(widget.data!["acf"]["author_name"]==""?"Yidinfo Staff":widget.data!["acf"]["author_name"],style:TextStyle(
                                fontSize:17,fontWeight:FontWeight.bold
                             ))
                             ,
                           ],
                         ),

                          Text("${widget.data!["date"].toString().substring(0,10)} ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(widget.data!["date"].toString().substring(18-7)))}"),

                       ],
                     ),
                     SizedBox(height:20,),
                     Stack(
                       children: [
                         Container(
                           width:MediaQuery.of(context).size.width,
                           height:MediaQuery.of(context).size.height*0.40,
                           child:FadeInImage.assetNetwork(
                             placeholder: "images/img.png",
                             image: "${widget.data["jetpack_featured_media_url"]}",
                             fit: BoxFit.cover,
                             imageErrorBuilder:
                                 (context, error, stackTrace) {
                               return Image.asset(
                                   'images/img.png',
                                   height:100,
                                   width:100,

                                   fit:BoxFit.cover);
                             },
                           ),

                         ),



                       ],
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top: 26.0),
                       child:Html(
                         data: widget.data!["content"]["rendered"],
                         defaultTextStyle:TextStyle(fontSize:fontsize.toDouble()),
                         onLinkTap: (url) async {
                           if (await canLaunch(url)){
                             await launch(url);
                           }
                           else {
                             // can't launch url
                           }                          },
                       )
                     ),

                   ],
                 ),
               ),
             )


           ],

        ),
      ),
    );
  }
}


