import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import 'dart:math' as math;

import '../Controller/categories_post_controller.dart';
import '../Screens/DetailScreen.dart';

class politics extends StatefulWidget {
  const politics({Key? key}) : super(key: key);

  @override
  _politicsState createState() => _politicsState();
}

class _politicsState extends State<politics> with SingleTickerProviderStateMixin{
  catgorypostcontroller catgory=catgorypostcontroller();
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: Duration(seconds: 1))..repeat();

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
  List ar=await catgory.getallpost("45", i);
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
    return Container(
      child:SingleChildScrollView(
        child:isloading
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
                          subtitle:Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [

                              Padding(
                                  padding: const EdgeInsets.only(left:10.0,top:5),
                                  child: Text("${articles[i]["date"].toString().substring(0,10)} ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(articles[i]["date"].toString().substring(18-7)))}")),

                            ],
                          ),                            contentPadding:EdgeInsets.all(10),
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




            Visibility(
                visible:true,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width:MediaQuery.of(context).size.width*0.25,
                        height:30,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical:10),
                        child: ElevatedButton(
                          onPressed: (){
                            if(i>1)
                            {
                              i--;
                              loadmore(i);
                            }

                          },
                          child: Text('Back'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange, // background
                            onPrimary: Colors.white, // foreground
                          ),
                        )),Container(
                        width:MediaQuery.of(context).size.width*0.25,
                        height:30,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical:10),
                        child: ElevatedButton(
                          onPressed: (){
                            i++;
                            loadmore(i);
                          },
                          child: Text('Next'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange, // background
                            onPrimary: Colors.white, // foreground
                          ),
                        )),
                  ],
                )

            )
          ],
        ),
      ),
    );
  }
}
