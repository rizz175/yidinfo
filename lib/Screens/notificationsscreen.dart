import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:yidinfo/Screens/show_notification.dart';
import 'dart:math' as math;

import '../Controller/home_post_controlle.dart';
import '../hive/notification_model.dart';
import '../provider/notification_provider.dart';
import 'homedetailed.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key, required this.context}) : super(key: key);
  final BuildContext context;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

enum TodoFilter { all, completed, incompleted }

class _NotificationPageState extends State<NotificationPage>  with SingleTickerProviderStateMixin  {
  late Box<NotificationModel> notifyBox;
  bool boxInit = false;
  homepostcontroller hompost = homepostcontroller();
  late final AnimationController _controller =
  AnimationController(vsync: this, duration: Duration(seconds: 1))
    ..repeat();
  @override
  void initState() {
    openHive();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<NotificationProvider>(widget.context, listen: false)
          .setZero();
    });
    super.initState();
  }

  void openHive() async {
    final document = await getApplicationDocumentsDirectory();
    Hive.init(document.path);
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(NotificationModelAdapter());
    }
    await Hive.openBox<NotificationModel>('notification').whenComplete(() {
      notifyBox = Hive.box<NotificationModel>('notification');
      if (notifyBox.isOpen) {
        boxInit = true;
        setState(() {});
      }
    }).catchError((onError) {
      log(onError.toString());
    });
  }

  TodoFilter filter = TodoFilter.all;
  @override
  void dispose() {
    notifyBox.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "images/logo.png",
                          width: 35,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Notifications",
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.clear,
                          size: 30,
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: FutureBuilder<List>(
                  future: hompost.getallhomepost(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length != 0) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 10,
                            itemBuilder: (context, i) {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                homedetailedscreen(
                                                    snapshot.data![i])));
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
                                                "${snapshot.data![i]["title"]["rendered"]}",
                                                defaultTextStyle: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ))),
                                      subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 5),
                                          child: Text(
                                              "${snapshot.data![i]["date"].toString().substring(0, 10)} ${DateFormat.jm().format(DateFormat("hh:mm:ss").parse(snapshot.data![i]["date"].toString().substring(18 - 7)))}")),
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
                            });
                      } else {
                        return Center(
                          child: Text("No Post"),
                        );
                      }
                    } else {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (_, child) {
                              return Transform.rotate(
                                angle: _controller.value * 2 * math.pi,
                                child: child,
                              );
                            },
                            child: Container(
                                height: 50,
                                width: 50,
                                child: Image.asset("images/logo.png")),
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
              // Expanded(
              //   child: boxInit
              //       ? ValueListenableBuilder(
              //           valueListenable: notifyBox.listenable(),
              //           builder: (context, Box<NotificationModel> todos, _) {
              //             if (!notifyBox.isOpen) {
              //               boxInit = false;
              //               openHive();
              //             }
              //             List<int> keys = todos.keys
              //                 .cast<int>()
              //                 .where((key) => !todos.get(key)!.isCompleted)
              //                 .toList();
              //
              //             return ListView.separated(
              //               itemBuilder: (_, index) {
              //                 final int key = keys[index];
              //
              //                 final NotificationModel todo = todos.get(key)!;
              //
              //                 return ListTile(
              //                   title: Text(
              //                     todo.title,
              //                     style: const TextStyle(
              //                         fontSize: 16,
              //                         color: Colors.orangeAccent,
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   subtitle: Text(todo.detail,
              //                       style: const TextStyle(
              //                           fontSize: 14)),
              //                   leading: Image.asset(
              //                     "images/logo.png",
              //                     width: 50,
              //                   ),
              //                   onTap: () {
              //                     log(todo.url);
              //                     showDialog(
              //                         context: context,
              //                         builder: (_) => Dialog(
              //                                 child: Container(
              //                               padding: const EdgeInsets.all(16),
              //                               child: Column(
              //                                 mainAxisSize: MainAxisSize.min,
              //                                 children: <Widget>[
              //                                   ElevatedButton(
              //                                     child: Text(
              //                                       "Open News",
              //                                       style: TextStyle(
              //                                           color: Colors.white),
              //                                     ),
              //                                     onPressed: () {
              //                                       log(todo.url);
              //                                       Navigator.push(
              //                                           context,
              //                                           MaterialPageRoute(
              //                                               builder: (_) =>
              //                                                   ShowNotification(
              //                                                       url: todo
              //                                                           .url)));
              //                                     },
              //                                   )
              //                                 ],
              //                               ),
              //                             )));
              //                   },
              //                 );
              //               },
              //               separatorBuilder: (_, index) => const Divider(
              //                 color: Colors.grey,
              //               ),
              //               itemCount: keys.length,
              //               shrinkWrap: true,
              //             );
              //           },
              //         )
              //       : Container(),
              // )
            ],
          ),
        ),
      ),
      // floatingActionButton: boxInit
      //     ? notifyBox.isNotEmpty
      //         ? FloatingActionButton(
      //             backgroundColor: Colors.orangeAccent,
      //             onPressed: () {
      //               notifyBox.clear();
      //               setState(() {
      //                 boxInit = false;
      //               });
      //             },
      //             child: const Icon(
      //               Icons.delete_forever,
      //                 color:Colors.white,
      //               size: 30,
      //             ))
      //         : Container()
      //     : Container(),
    );
  }
}
