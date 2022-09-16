import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import '../Controller/home_post_controlle.dart';
import 'homedetailed.dart';
class searchscreen extends StatefulWidget {
  const searchscreen({Key? key}) : super(key: key);

  @override
  _searchscreenState createState() => _searchscreenState();
}

class _searchscreenState extends State<searchscreen> with SingleTickerProviderStateMixin {
  homepostcontroller hompost = homepostcontroller();
  TextEditingController search=TextEditingController();

  bool isloaded=true;
  List userlist=[];
  List searchlist=[];
  bool notfound=false;
  getlist() async{

    List templist= await hompost.getallsearchpost();
    setState((){
      userlist=templist;
      searchlist=userlist;
    });

    if(userlist.length>0)
    {
      setState(() {
        isloaded=false;
      });
    }



  }
  @override
  void initState() {
    getlist();
  }

  void _runFilter(String enteredKeyword) {
    setState(() {

      notfound=false;
    });
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = userlist;
    } else {
      results =userlist
          .where((user) =>
          user["title"]["rendered"].toString().toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      searchlist = results;
      if(searchlist==0) {
        notfound=true;

      }

    });

    }


  late final AnimationController _controller =
  AnimationController(vsync: this, duration: Duration(seconds: 1))
    ..repeat();
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: SingleChildScrollView(

        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44, width: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Image.asset("images/logo.png", width: 35,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Search",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight
                            .bold),),
                    )
                  ],),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.clear, size: 30,))

                ],
              ),
            ),
            SizedBox(height:10,),
            Center(
              child: Container(

                width:MediaQuery.of(context).size.width*0.9,
                decoration:BoxDecoration(

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 2,

                    ),
                  ],
                ),
                margin:EdgeInsets.symmetric(horizontal:10,vertical:10),
                child: TextField(
                    controller:search,
                    onChanged:(v)=>_runFilter(v),
                    decoration:InputDecoration(
                        border: InputBorder.none,


                        filled: true,
                        hintText: "Search",


                        prefixIcon:GestureDetector(
                            onTap: (){
                              // showDatePicker(context: context, initialDate: , firstDate: firstDate, lastDate: lastDate)

                            },
                            child: Icon(Icons.search,size:24,))
                    )
                ),
              ),
            ),
            SizedBox(height: 14, width: 20,),
            Container(
              margin: EdgeInsets.symmetric(horizontal:20),
              width: double.infinity,
              child:searchlist.length!=0
    ?ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: searchlist.length,
                          itemBuilder: (context, i) {
                            return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              homedetailedscreen(
                                                  searchlist![i])));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 7, horizontal: 4),
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

                                  width: MediaQuery.of(context).size.width,
                                  child: ListTile(
                                    isThreeLine: true,
                                    leading: Image.asset(
                                      "images/logo.png",
                                      width: 50,
                                    ),
                                    title: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width *
                                                0.85,
                                            child: Html(
                                              data:
                                              "${searchlist[i]["title"]["rendered"]}",
                                              defaultTextStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ))),
                                    subtitle: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 5),
                                        child: Text(
                                            "${searchlist[i]["date"].toString().substring(0, 10)} ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(searchlist![i]["date"].toString().substring(18 - 7)))}")),
                                    contentPadding: EdgeInsets.all(10),
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
                          })
                    :userlist.length>0?Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(child: Text("No Result Found")),
                    ):Center(child: Text(""))



            )
         ]
        ),
      ),
    );
  }}

