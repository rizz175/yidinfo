import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yidinfo/Screens/notificationsscreen.dart';
import 'package:yidinfo/Screens/searchscreen.dart';

import '../Controller/categories_post_controller.dart';
import '../Controller/home_post_controlle.dart';
import '../provider/notification_provider.dart';
import 'DetailScreen.dart';
import 'Musicdetailscreen.dart';
import 'dart:math' as math;

import 'homedetailed.dart';

class homescreen extends StatefulWidget {
  const homescreen({Key? key}) : super(key: key);

  @override
  _homescreenState createState() => _homescreenState();
}

class _homescreenState extends State<homescreen>
    with SingleTickerProviderStateMixin {
  catgorypostcontroller catgory = catgorypostcontroller();
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 1))
        ..repeat();

  homepostcontroller hompost = homepostcontroller();
  catgorypostcontroller cat=catgorypostcontroller();


  List articles=[];
  bool isloading=true;
  int i=1;

  @override
  void initState() {
    loadmore(i);
//
  }

  loadmore(int i)
  async {articles.clear();

  setState(() {
    isloading=true;
  });
  List ar=await catgory.getallpost("25", i);
  setState(() {
    articles=ar;


  });
  if(ar.length>0)
  {

    setState(() {
      isloading=false;
    });
  }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 44,
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "images/mainlogo.png",
                      width: 50,
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => searchscreen()));
                        },
                        icon: const Icon(
                          Icons.search,
                          size: 32,
                        )),SizedBox(width:6,),
                    Stack(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NotificationPage(
                                        context: context,
                                      )));
                            },
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.orange,
                              size: 32,
                            )),
                        Positioned(
                            right: 5,
                            top: 5,
                            child: Text(
                              Provider.of<NotificationProvider>(context).counter !=
                                      0
                                  ? '${Provider.of<NotificationProvider>(context).counter}'
                                  : '',
                              style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //trending section

          // latest new section
          Padding(
            padding: const EdgeInsets.only(left: 12.0, top: 10, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, bottom: 0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: Colors.orangeAccent,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Trending News",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
               isloading
                    ?Center(
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * math.pi,
                        child: child,
                      );
                    },
                    child:Container(
                        height:50,
                        width:50,
                        child: Image.asset("images/logo.png")),
                  ),
                )
                    :Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),

                        shrinkWrap:true,
                        itemCount:articles.length,
                        itemBuilder: (context,i){

                          return GestureDetector(

                              onTap:(){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>detailedscreen(articles[i]),
                                    ));
                              },
                              child: Container(
                                margin:EdgeInsets.symmetric(vertical:7,horizontal:10),
// height:MediaQuery.of(context).size.height*0.14,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 0,
                                        blurRadius: 0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    )),

                                width:MediaQuery.of(context).size.width,
                                child:ListTile(
                                  leading:ClipRRect(
                                    borderRadius:BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: "images/img.png",
                                      image: "${articles[i]["jetpack_featured_media_url"]}",
                                      width:100,
                                      imageErrorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                            'images/img.png',
                                            height:100,
                                            width:100,

                                            fit:BoxFit.cover);
                                      },
                                      height:100,
                                      fit:BoxFit.cover,
                                    ),
                                  ),
                                  title:Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child:Container(
                                        width:MediaQuery.of(context).size.width*0.85, child:
                                      Html(
                                        data:"${articles[i]["title"]["rendered"].toString()}",
                                        defaultTextStyle: TextStyle(
                                            fontSize:15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      )),
                                  subtitle:Padding(
                                      padding: const EdgeInsets.only(left:10.0,top:5),
                                      child: Text("${articles[i]["date"].toString().substring(0,10)} ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(articles[i]["date"].toString().substring(18-7)))}")),                            contentPadding:EdgeInsets.all(10),
                                  // Stack(
                                  //   children: [
                                  //     Container(
                                  //       decoration: BoxDecoration(
                                  //           color: Colors.white,
                                  //           boxShadow: [
                                  //             BoxShadow(
                                  //                 color: Colors.black12,
                                  //                 offset: Offset(1, 1),
                                  //                 blurRadius: 1)
                                  //           ],
                                  //           borderRadius: BorderRadius.all(
                                  //             Radius.circular(15.0),
                                  //           )),
                                  //
                                  //       width:MediaQuery.of(context).size.width,
                                  //
                                  //       child: ClipRRect(
                                  //         borderRadius: BorderRadius.circular(8.0),
                                  //
                                  //         child: FadeInImage.assetNetwork(
                                  //           placeholder: "images/img.png",
                                  //           image: "${snapshot.data![i]["_embedded"]["wp:featuredmedia"][0]["source_url"]}",
                                  //           fit: BoxFit.cover,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       color:Colors.black26,
                                  //       child: Padding(
                                  //         padding: const EdgeInsets.all(18.0),
                                  //         child:Container(
                                  //           width:MediaQuery.of(context).size.width*0.85,
                                  //           child: Text("${snapshot.data![i]["title"]["rendered"]}",maxLines:2,style:TextStyle(
                                  //               color:Colors.white,fontSize:24,fontWeight:FontWeight.bold,overflow:TextOverflow.ellipsis
                                  //           ),),
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     Positioned(
                                  //         right:10,bottom:10,
                                  //         child:Text("${snapshot.data![i]["date"]}",style:TextStyle(
                                  //             color:Colors.white,fontSize:18,fontWeight:FontWeight.bold,overflow:TextOverflow.ellipsis
                                  //         ),))
                                  //   ],
                                  // ),

                                ),
                              ));

                        }),

                  ],
                ),
              ],
            ),
          ),
          //latest news wall
          // Padding(
          //   padding: const EdgeInsets.only(left: 12.0,top:10,right:12),
          //   child: Column(
          //     crossAxisAlignment:CrossAxisAlignment.start,
          //
          //     children: [
          //
          //       // Padding(
          //       //   padding: const EdgeInsets.only(top: 12.0,bottom:12),
          //       //   child: Row(
          //       //     children: [
          //       //       Icon(Icons.pin_drop,color:Colors.orangeAccent,),SizedBox(width:7,),
          //       //       Text("News Wall",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
          //       //     ],
          //       //   ),
          //       // ),
          //       Container(
          //
          //         height: 150,
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(5),
          //               topRight: Radius.circular(5),
          //               bottomLeft: Radius.circular(5),
          //               bottomRight: Radius.circular(5)
          //           ),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black12,
          //               spreadRadius: 0,
          //               blurRadius: 0,
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          //latest weather
          // Padding(
          //   padding: const EdgeInsets.only(left: 12.0,top:10,right:12),
          //   child: Column(
          //     crossAxisAlignment:CrossAxisAlignment.start,
          //
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.only(top: 12.0,bottom:12),
          //         child: Row(
          //           children: [
          //             Icon(Icons.cloud_circle_rounded,color:Colors.orangeAccent,),SizedBox(width:7,),
          //             Text("Weather",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
          //           ],
          //         ),
          //       ),
          //       Container(
          //
          //         height: 150,
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.only(
          //               topLeft: Radius.circular(5),
          //               topRight: Radius.circular(5),
          //               bottomLeft: Radius.circular(5),
          //               bottomRight: Radius.circular(5)
          //           ),
          //           boxShadow: [
          //             BoxShadow(
          //               color: Colors.black12,
          //               spreadRadius: 0,
          //               blurRadius: 0,
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          //latest medianews
//               Padding(
//                 padding: const EdgeInsets.only(left: 12.0,top:10,right:12),
//                 child: Column(
//                   crossAxisAlignment:CrossAxisAlignment.start,
//
//                   children: [
//
//                     Padding(
//                       padding: const EdgeInsets.only(top: 18.0,bottom:0),
//                       child: Row(
//                         children: [
//                           Icon(Icons.assignment,color:Colors.orangeAccent,),SizedBox(width:7,),
//                           Text("Media News",style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),),
//                         ],
//                       ),
//                     ),
        ],
      ),
    ));
  }
}
