import 'dart:async';
import 'package:flutter_webview_pro/webview_flutter.dart';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../Controller/categories_post_controller.dart';
class advertise extends StatefulWidget {


  @override
  _advertiseState createState() => _advertiseState();

}

class _advertiseState extends State<advertise>  with SingleTickerProviderStateMixin{
    // Add this attribute
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: Duration(seconds: 1))..repeat();

  Completer<WebViewController> controller = Completer<WebViewController>();
bool isloading=true;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

      child:Stack(
        children: [
          WebView(
            initialUrl: 'https://yidinfo.net/advertise-with-us/',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller.complete(webViewController);
            },

            javascriptChannels: <JavascriptChannel>{
            },

            onPageStarted: (String url) {
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              setState(() {
                isloading=false;
              });
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
//support geolocation or not
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
            ))
            :Container(),

        ],
      ),
      ));



    //
    //
    //   WebView(
    //   initialUrl: 'https://yidinfo.net/advertise-with-us/',
    //   javascriptMode: JavascriptMode.unrestricted,        // Add this line
    //
    //   onWebViewCreated: (webViewController) {
    //     controller.complete(webViewController);
    //   },
    // );
  }}

  // int _groupValue = -1;
  //
  // TextEditingController email = TextEditingController();
  // TextEditingController url = TextEditingController();
  // TextEditingController addditional = TextEditingController();
  // File? imagefile;
  // bool checkk=false;
  // String value="";
  // bool costperday=false;
  // _getFromGallery() async {
  //   File pickedFile = (await ImagePicker().getImage(
  //     source: ImageSource.gallery,)) as File;
  //   if (pickedFile != null) {
  //     setState(() {
  //       imagefile = File(pickedFile.path);
  //
  //     });
  //   }
  // }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //
  //       child: Column(
  //         crossAxisAlignment:CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(height: 44, width: 20,),
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20.0, right: 20),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(children: [
  //                   Image.asset("images/logo.png", width: 35,),
  //                   Padding(
  //                     padding: const EdgeInsets.only(left: 8.0),
  //                     child: Text("Advertise with us",
  //                       style: TextStyle(fontSize: 26, fontWeight: FontWeight
  //                           .bold, color: Colors.black54),),
  //                   )
  //                 ],),
  //                 GestureDetector(
  //                     onTap: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Icon(Icons.clear, color: Colors.black, size: 30,))
  //
  //               ],
  //             ),
  //           ),
  //           SizedBox(height: 14, width: 20,),
  //           Padding(
  //             padding: const EdgeInsets.all(20.0),
  //             child: Text("Create new Ad",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(color: Colors.black87,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 23),),
  //           ),    Padding(
  //             padding: const EdgeInsets.only(left: 20.0,top:0),
  //             child: Text("Should we credit someone for this?"
  //             ),
  //           ),            Container(
  //             margin: const EdgeInsets.only(left: 20.0,top:10,right:20),
  //             padding: const EdgeInsets.only(left: 20.0,top:0,right:20),
  //
  //             width:MediaQuery.of(context).size.width,
  //             height:60,
  //             color:Colors.white,
  //             child: DropdownButtonHideUnderline(
  //               child: DropdownButton<String>(
  //                 items: <String>['Telegram -1 Post',"WhatsApp Status Post (2 Posts)",'Zmanim Page Sponsor - 728X90', 'YidInfo Social Media Full Package'].map((String value) {
  //                   return DropdownMenuItem<String>(
  //                     value: value,
  //                     child: Text(value),
  //                   );
  //                 }).toList(),
  //                 hint:value==""
  //                 ?Text("Telegram -1 Post")
  //                 :Text(value,),
  //                 onChanged: (value1) {
  //
  //                   setState(() {
  //                     value=value1.toString();
  //                   });
  //                 },
  //               ),
  //             ),
  //
  //           ),
  //
  //           Container(
  //               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //               child: TextField(
  //                 controller: email,
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   labelText: 'Your Email',
  //                 ),
  //
  //               )),
  //
  //           Container(
  //               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //               child: TextField(
  //                 controller: url,
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   labelText: 'Add Url (255)',
  //                 ),
  //
  //               )),
  //           Container(
  //             margin: const EdgeInsets.only(left: 20.0,top:10,right:20),
  //             padding: const EdgeInsets.only(left: 20.0,top:0,right:20),
  //
  //             width:MediaQuery.of(context).size.width,
  //             height:60,
  //             color:Colors.white,
  //             child:Row(
  //               mainAxisAlignment:MainAxisAlignment.spaceBetween,
  //               children: [
  //
  //                 Container(
  //                   width:120,
  //                     child: Text("Upload Thumbnail",overflow:TextOverflow.ellipsis,)),
  //                 GestureDetector(
  //                   onTap:_getFromGallery,
  //                   child: Container(decoration:BoxDecoration(shape:BoxShape.circle,color:Colors.black12),
  //                       child: Icon(Icons.add,color:Colors.white,)),
  //                 )
  //               ],),
  //           ),
  //           Container(
  //               margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //               child: TextField(
  //                 controller: addditional,
  //                 decoration: InputDecoration(
  //                   border: OutlineInputBorder(),
  //                   labelText: 'Additional information (Optional)',
  //                 ),
  //
  //               )),
  //
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20.0,top:20),
  //             child: Text("Choose Billing model and Limit display"
  //             ),
  //           ),
  //
  //           Padding(
  //             padding: const EdgeInsets.only(left: 20.0,top:5),
  //             child: Row(
  //               children: [
  //                 Radio(
  //                   value: 0,
  //                   groupValue: _groupValue,
  //                   onChanged: (value) {
  //                     setState(() {
  //                       _groupValue = value as int;
  //                       costperday=true;
  //                     });
  //                   },
  //                 ), const Text('Cost per Day (CPD)'),
  //               ],
  //             ),
  //           ),
  //
  //
  //
  //           Container(
  //               width:MediaQuery.of(context).size.width,
  //               height:50,
  //               margin: EdgeInsets.symmetric(horizontal: 20, vertical:10),
  //               child: ElevatedButton(
  //                   onPressed: (){
  //
  //
  //                     if(email.text.toString()!="" && url.text.toString()!="" && value!="")
  //                     {
  //                       // var body={
  //                       //   "Phone":phone.text.toString(),
  //                       //   "Comments":comment.text.toString(),
  //                       //
  //                       // };
  //                       // send(body);
  //                     }
  //
  //                     else
  //                     {
  //                       log("not found");
  //                     }
  //
  //                   },
  //                   child: Text('Pay Now'),
  //                   style: ElevatedButton.styleFrom(
  //                       primary: Theme.of(context).primaryColor
  //                   )
  //               )),SizedBox(height:20,)
  //         ],
  //       ),
  //     ),
  //   );
  // }}
