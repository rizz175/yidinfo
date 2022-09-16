import 'package:flutter/material.dart';

import '../Controller/categories_post_controller.dart';
import '../locanews_screens/Monsey.dart';
import '../locanews_screens/boropark.dart';
import '../locanews_screens/flatbush.dart';
import '../locanews_screens/stalenisland.dart';
import '../locanews_screens/upstate.dart';
import '../locanews_screens/williamsburg.dart';
class localnews extends StatefulWidget {
  const localnews({Key? key}) : super(key: key);

  @override
  _localnewsState createState() => _localnewsState();
}

class _localnewsState extends State<localnews> {
  catgorypostcontroller catgory=catgorypostcontroller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:DefaultTabController(
        length:6,
        child:Column(

          children: [
            Expanded(
              flex:2,
              child:Column(
                children: [

                  TabBar(
                    labelColor:Colors.orange,

                    indicatorColor:Colors.orangeAccent,isScrollable:true,
                    tabs: [
                      Tab(
                        child:Text("Boro Park",style:TextStyle(fontWeight:FontWeight.bold)),
                      ),
                      Tab(
                        child:Text("Flatbush",style:TextStyle(fontWeight:FontWeight.bold)),
                      ),
                      Tab(
                        child:Text("Williamsburg",style:TextStyle(fontWeight:FontWeight.bold)),
                      ),
                      Tab(
                        child:Text("Upstate",style:TextStyle(fontWeight:FontWeight.bold)),
                      ),
                      Tab(
                        child:Text("Monsey",style:TextStyle(fontWeight:FontWeight.bold)),
                      ),

                    Tab(
      child:Text("Staten Island",style:TextStyle(fontWeight:FontWeight.bold)),
    ),


                    ],
                  ),

                ],
              ),
            ),
            Expanded(
              flex:11 ,
              child:TabBarView(
                children: [
        Boropark(),flatbush(),williamsburg(),upstate(),monsey(),stalenisland()
                ],
              ),   )





          ],
        ),
      ),
    );
  }
}
