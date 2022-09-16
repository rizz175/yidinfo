import 'package:flutter/material.dart';

import '../latestnews_tabscreen/Jewishnews.dart';
import '../latestnews_tabscreen/Worldnews.dart';
import '../latestnews_tabscreen/israelnews.dart';
import '../latestnews_tabscreen/local.dart';
import '../latestnews_tabscreen/photos.dart';
import '../latestnews_tabscreen/politics.dart';

class latestnews extends StatefulWidget {
  const latestnews({Key? key}) : super(key: key);

  @override
  _latestnewsState createState() => _latestnewsState();
}

class _latestnewsState extends State<latestnews> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
        child:Scaffold(
         body:Column(

             children: [
             Expanded(
  flex:3,
  child:Column(
    children: [    SizedBox(height:44,width:20,),
      Padding(
        padding: const EdgeInsets.only(left: 12.0,right:12),
        child: Row(
          // mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Image.asset("images/logo.png",width:35,),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text("News By Filter",style:TextStyle(fontSize: 30,fontWeight:FontWeight.bold),),
              )
            ],),
            // Icon(Icons.search_sharp,color:Colors.black,size: 30,)

          ],
        ),
      ),
      TabBar(

        indicatorColor:Colors.orangeAccent,isScrollable:true,
        labelColor:Colors.orange,
        tabs: [
          Tab(
            child:Text("World News",style:TextStyle(fontWeight:FontWeight.bold)),
          ),
          Tab(
            child:Text("Israel News",style:TextStyle(fontWeight:FontWeight.bold)),
          ),
          Tab(
            child:Text("Jewish  News",style:TextStyle(fontWeight:FontWeight.bold)),
          ),
          Tab(
            child:Text("Local",style:TextStyle(fontWeight:FontWeight.bold)),
          ),
          Tab(
            child:Text("Politics",style:TextStyle(fontWeight:FontWeight.bold)),
          ),
          Tab(
            child:Text("Photos",style:TextStyle(fontWeight:FontWeight.bold)),
          ),

        ],
      ),

    ],
  ),
),
               Expanded(
                   flex:9 ,
                   child:TabBarView(
                     children: [
                       worldsnews(),israelnews(),jewishnews(),localnews(),politics(),photos()
                     ],
                   ),   )





          ],
           ),
         ),



    );
  }
}
