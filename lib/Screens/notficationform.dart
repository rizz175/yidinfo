// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Menubar/menubar.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool isHide = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();



  Future<void>sendemail(String name,String email,String location,String interest)async
  {

    var bodydata=json.encode({
      "service_id":"service_xcz4208","template_id":"template_apj5lf2","user_id":"B3I79Rtp0dNbqJOxe",
       "template_params":{
      "location":location,"name":name,"email":email,"subject_name":"Notification Form","interest":interest
    }});
    var url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    var response= await http.post(url,body:bodydata,headers:{"Content-Type": 'application/json',"origin":'http://localhost'});

    log(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Thanks for subscribing."),
    ));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("firsttimee11","ds");
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => menubar()));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ))
            : SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                transform: Matrix4.rotationZ(0.5),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topLeft,
                        colors: [Colors.orange.shade200, Colors.orangeAccent.shade100])),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          children: [
                            Text(
                              'Welcome',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Username';
                            }
                          },
                          onSaved: (value) {
                            _emailController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          controller: _usernameController,
                          decoration: InputDecoration(
                            fillColor: Colors.orange.shade400,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade200),
                            hintText: 'Name (must be at least 6 alphabets)',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Email';
                            }
                          },
                          onSaved: (value) {
                            _emailController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(

                            fillColor: Colors.orange.shade400,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade200),
                            hintText: 'Email',
                            prefixIcon: Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          readOnly: true,
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Location';
                            }
                          },
                          onSaved: (value) {
                            _categoryController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          controller: _categoryController,
                          decoration: InputDecoration(
                            suffixIcon: PopupMenuButton(
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: 35,
                              ),
                              itemBuilder: ((context) => [
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'BoroPark';
                                          });
                                        },
                                        child: Text('BoroPark'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Flatbush';
                                          });
                                        },
                                        child: Text('Flatbush'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Staten Island';
                                          });
                                        },
                                        child: Text('Staten Island'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Monsey';
                                          });
                                        },
                                        child: Text('Monsey'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Williamsburg';
                                          });
                                        },
                                        child: Text('Williamsburg'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Upstate';
                                          });
                                        },
                                        child: Text('Upstate'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Israel';
                                          });
                                        },
                                        child: Text('Israel'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Boro Park';
                                          });
                                        },
                                        child: Text('Boro Park'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Flatbush';
                                          });
                                        },
                                        child: Text('Flatbush'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Crown Heights';
                                          });
                                        },
                                        child: Text('Crown Heights'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Williamsburg';
                                          });
                                        },
                                        child: Text('Williamsburg'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Queens';
                                          });
                                        },
                                        child: Text('Queens'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Far Rockaway';
                                          });
                                        },
                                        child: Text('Far Rockaway'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Far Rockaway';
                                          });
                                        },
                                        child: Text('Far Rockaway'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Monsey';
                                          });
                                        },
                                        child: Text('Monsey'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Lakewood';
                                          });
                                        },
                                        child: Text('Lakewood'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Toms River';
                                          });
                                        },
                                        child: Text('Toms River'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Kiryas Joel';
                                          });
                                        },
                                        child: Text('Kiryas Joel'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Upstate';
                                          });
                                        },
                                        child: Text('Upstate'))),  PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Catskills';
                                          });
                                        },
                                        child: Text('Catskills'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'California';
                                          });
                                        },
                                        child: Text('California')))

                                ,
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Florida';
                                          });
                                        },
                                        child: Text('FLorida')))
                                ,
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Ukraine';
                                          });
                                        },
                                        child: Text('Ukraine'))) , PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Canada';
                                          });
                                        },
                                        child: Text('Canada'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Australia';
                                          });
                                        },
                                        child: Text('Austrialia'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Europe';
                                          });
                                        },
                                        child: Text('Europe'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _categoryController.text =
                                            'Other';
                                          });
                                        },
                                        child: Text('Other'))),






                              ]),
                            ),
                            fillColor: Colors.orange.shade400,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade200),
                            hintText: 'Location',
                            prefixIcon: Icon(
                              Icons.category,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          readOnly: true,
                          obscureText: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'What type of news interests you the most?';
                            }
                          },
                          onSaved: (value) {
                            interestController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          controller: interestController,
                          decoration: InputDecoration(
                            suffixIcon: PopupMenuButton(
                              icon: Icon(
                                Icons.interests,
                                color: Colors.black,
                                size: 35,
                              ),
                              itemBuilder: ((context) => [

                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            interestController.text =
                                            'Jewish News';
                                          });
                                        },
                                        child: Text('Jewish News')))
                                ,
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            interestController.text =
                                            'Local News';
                                          });
                                        },
                                        child: Text('Local News')))
                                ,
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            interestController.text =
                                            'World News';
                                          });
                                        },
                                        child: Text('World News'))),

                                PopupMenuItem(
                            child: GestureDetector(
                            onTap: () {
                      setState(() {
                      interestController.text =
                      'Israeli News';
                      });
                      },
                          child: Text('Israeli News'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            interestController.text =
                                            'Political News';
                                          });
                                        },
                                        child: Text('Political News'))),
                                PopupMenuItem(
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            interestController.text =
                                            'Business News';
                                          });
                                        },
                                        child: Text('Business News')))





                              ]),
                            ),
                            fillColor: Colors.orange.shade400,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(50)),
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade200),
                            hintText: 'What type of news interests you the most?',
                            prefixIcon: Icon(
                              Icons.category,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () async {
if(_usernameController.text.toString()!=""&& _categoryController.text.toString()!="" &&_emailController.text.toString()!=""&&interestController.text.toString()!="")
{
  sendemail(_usernameController.text, _emailController.text,_categoryController.text,interestController.text);

}
                              else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Fill Credentials"),
                          ),
                        );
                      }


                            },
                            child: Container(
                              height: 50,
                              width:
                              MediaQuery.of(context).size.width / 2,
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(

                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color:Colors.orangeAccent,
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 1,
                                        color: Colors.orange)
                                  ],
                                  borderRadius: BorderRadius.circular(50),
                                 ),
                            ),
                          ),
                          SizedBox(height:20),

                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  height:MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                      children:[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: () async {

                                SharedPreferences prefs = await SharedPreferences.getInstance();

                        prefs.setString("firsttimee11","ds");
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) => menubar()));
                                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>menubar()));
                              }, icon: Icon(Icons.cancel)

                              )
                            ],),
                        )
                      ]
                  ),
                ),
              )
            ]),
          ),
        ));
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, 0), radius: size.height / 2));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}












// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
//
// import 'package:flutter/material.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Menubar/menubar.dart';
//
// class noticationform extends StatefulWidget {
//   const noticationform({Key? key}) : super(key: key);
//
//   @override
//   _noticationformState createState() => _noticationformState();
// }
//
// class _noticationformState extends State<noticationform> {
//   int _groupValue = -1;
//
//   TextEditingController name = TextEditingController();
//   TextEditingController emaill = TextEditingController();
// String location="";
//
//
//   // Future<void> send() async {
//   //
//   //   var body={
//   //     "Name":name.text,
//   //
//   //     "Email":emaill.text,
//   //     "Location":location
//   //   };
//   //
//   //   final Email email = Email(
//   //     body:body.toString(),
//   //     subject: "Notication",
//   //     recipients: ["office@YidInfo.net"],
//   //     isHTML: false,
//   //   );
//   //
//   //   String platformResponse;
//   //   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //
//   //   try {
//   //     await FlutterEmailSender.send(email);
//   //     platformResponse = 'success';
//   //     prefs.setString("firsttimee11","yes");
//   //
//   //     Navigator.pushReplacement(
//   //         context, MaterialPageRoute(builder: (context) => menubar()));
//   //
//   //   } catch (error) {
//   //     print(error);
//   //     platformResponse = error.toString();
//   //   }
//   //
//   //   if (!mounted) return;
//   //
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(
//   //       content: Text("Message is sent"),
//   //     ),
//   //   );
//   // }
//   //
//
//   Future<void>sendemail(String name,String email,String location)async
//   {
//
//     var bodydata=json.encode({
//       "service_id":"service_poqlp9i","template_id":"template_f9o8rel","user_id":"9i9bpfdZl4ET2pSMW",
//        "template_params":{
//       "location":location,"name":name,"email":email,"subject_name":"Notification Form"
//     }});
//     var url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
//     var response= await http.post(url,body:bodydata,headers:{"Content-Type": 'application/json',"origin":'http://localhost'});
//
//     log(response.body);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text("Thanks for subscribing."),
//     ));
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     prefs.setString("firsttimee11","ds");
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => menubar()));
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//
//         child: Column(
//           crossAxisAlignment:CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 44, width: 20,),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(children: [
//                     Image.asset("images/logo.png", width: 35,),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: Text("Welcome",
//                         style: TextStyle(fontSize: 26, fontWeight: FontWeight
//                             .bold,),),
//                     )
//                   ],),
//                   GestureDetector(
//                       onTap: () async {
//                         SharedPreferences prefs = await SharedPreferences.getInstance();
//
//                         prefs.setString("firsttimee11","ds");
//                         Navigator.pushReplacement(
//                             context, MaterialPageRoute(builder: (context) => menubar()));
//                       },
//                       child: Icon(Icons.clear, size: 30,))
//
//                 ],
//               ),
//             ),
//             SizedBox(height: 34, width: 20,),
//             Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: TextField(
//                   controller: name,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Your Name (Required)',
//                   ),
//
//                 )),
//             Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: TextField(
//                   controller: emaill,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     labelText: 'Your email (Required)',
//                   ),
//
//                 )),
//
//             Container(
//               margin: EdgeInsets.symmetric(
//                   horizontal: 20, vertical: 10),
//               width: MediaQuery.of(context).size.width,
//               child: DropdownButton<String>(
//                 hint: location == ""
//                     ? Text("Location")
//                     : Text("$location"),
//                 items: <String>[
//                   'Boro Park',
//                   'Flatbush',
//                   'Monsey',
//                   'StalenIsland',
//                   'Upstate',
//                   'Williamsburg','Israel','London','Other'
//                 ].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 isExpanded:true,
//                 onChanged: (v) {
//                   setState(() {
//                     location = v.toString();
//                   });
//                 },
//               ),
//             ),
//             SizedBox(height:20,),
//             Container(
//                 width:MediaQuery.of(context).size.width,
//                 height:50,
//                 margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: ElevatedButton(
//                     onPressed: (){
//
//
//
//
//
//                       if(name.text.toString()!="" && emaill.text.toString()!="" && location.toString()!="")
//                       {
// sendemail(name.text, emaill.text, location);
//
//                       }
//
//                       else
//                       {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             content: Text("Fill Credentials"),
//                           ),
//                         );
//                       }
//                     },
//                     child: Text('Send'),
//                     style: ElevatedButton.styleFrom(
//                         primary: Theme.of(context).primaryColor
//                     )
//                 )),
//             SizedBox(height:20,),
//             Center(
//               child: GestureDetector(
//                 onTap: () async {
//                   SharedPreferences prefs = await SharedPreferences.getInstance();
//
//                   prefs.setString("firsttimee11","ds");
//                   Navigator.pushReplacement(
//                       context, MaterialPageRoute(builder: (context) => menubar()));
//                 },
//                 child:Text("Skip",style:TextStyle(fontSize:20,color:Colors.orange,fontWeight: FontWeight.bold),),
//               ),
//             )
//
//           ],
//         ),
//       ),
//     );
//   }}
