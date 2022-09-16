import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yidinfo/setting/instapost.dart';

import '../Controller/changetheme.dart';
import '../setting/aboutus.dart';
import '../setting/adverstisewithus.dart';
import '../setting/contactus.dart';
import '../setting/reportnews.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  _settingState createState() => _settingState();
}

class _settingState extends State<setting> {
  int toggle = 0;
  bool value = false;
  bool notificationValue = false;
  late SharedPreferences prefs;
  int slider = 14;
  @override
  Widget build(BuildContext context) {
    ChangeTheme changeTheme = Provider.of<ChangeTheme>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width:MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
          ),
          Column(
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
                          "images/logo.png",
                          width: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Settings",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),

                    Row(
                      children: [
                        Text(" Dark Mode"),
                        SizedBox(
                          width: 10,
                        ),
                        FlutterSwitch(
                          width: 60.0,
                          height: 30.0,
                          toggleSize: 35.0,
                          value: value,
                          borderRadius: 30.0,
                          padding: 2.0,
                          activeToggleColor: Color(0xFF6E40C9),
                          inactiveToggleColor: Color(0xFF2F363D),
                          activeSwitchBorder: Border.all(
                            color: Colors.white,
                            width: 3.0,
                          ),
                          inactiveSwitchBorder: Border.all(
                            color: Color(0xFFD1D5DA),
                            width: 3.0,
                          ),
                          activeColor: Colors.black12,
                          inactiveColor: Colors.white,
                          activeIcon: Icon(
                            Icons.nightlight_round,
                            color: Color(0xFFF8E3A1),
                          ),
                          inactiveIcon: Icon(
                            Icons.wb_sunny,
                            color: Color(0xFFFFDF5D),
                          ),
                          onToggle: (val) {
                            setState(() {
                              if (!value) {
                                changeTheme.settheme(ThemeData.dark().copyWith(
                                  primaryColor: Colors.orangeAccent,
                                  focusColor: Colors.orangeAccent,
                                  elevatedButtonTheme: ElevatedButtonThemeData(
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Colors.orangeAccent, // Button color
                                      onPrimary: Colors.white, // Text color
                                    ),
                                  ),
                                ));

                                prefs.setInt("value", 0);
                                value = val;
                              } else {
                                changeTheme.settheme(ThemeData.light().copyWith(
                                  primaryColor: Colors.orangeAccent,
                                  focusColor: Colors.orangeAccent,
                                  elevatedButtonTheme: ElevatedButtonThemeData(
                                    style: ElevatedButton.styleFrom(
                                      primary:
                                          Colors.orangeAccent, // Button color
                                      onPrimary: Colors.white, // Text color
                                    ),
                                  ),
                                ));

                                prefs.setInt("value", 1);

                                value = val;
                              }
                            });
                          },
                        ),
                      ],
                    ),

                    // GestureDetector(
                    //     onTap: () async {
                    //       final prefs = await SharedPreferences.getInstance();
                    //       int   toggle=prefs.getInt("value")??0;
                    //       print(toggle);
                    //       // var toggle=changeTheme.gettheme();
                    //       if(toggle==1)
                    //         {
                    //           changeTheme.settheme(ThemeData.dark());
                    //           prefs.setInt("value",0);
                    //
                    //         }
                    //      else{
                    //         changeTheme.settheme(ThemeData.light());
                    //
                    //         prefs.setInt("value",1);
                    //
                    //       }
                    //
                    //
                    //     },
                    //     child: Icon(Icons.search_sharp,color:Colors.black,size: 30,))
                  ],
                ),
              ),
              SizedBox(
                height: 54,
                width: 20,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => reportnews()));
                },
                leading: Icon(
                  Icons.description,
                  color: Colors.orangeAccent,
                ),
                title: Text("Report News"),
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              ListTile(
                onTap: () {

                },
                leading: Icon(
                  notificationValue ? Icons.notifications : Icons.notifications_off,
                  color: Colors.orangeAccent,
                ),
                title: Text("Receive Notification"),
                trailing: Container(
                  child: FlutterSwitch(
                    width: 60.0,
                    height: 30.0,
                    toggleSize: 35.0,
                    value: notificationValue,
                    borderRadius: 30.0,
                    padding: 2.0,
                    activeToggleColor:Colors.orangeAccent,
                    inactiveToggleColor:Colors.grey,

                    activeColor: Colors.black12,
                    inactiveColor:Colors.black12,

                    onToggle: (val) {
                      if(val)
                      {
                        OneSignal.shared.disablePush(false);
                        prefs.setInt("receive_notification", 1);

                      }else{
                        OneSignal.shared.disablePush(true);
                        prefs.setInt("receive_notification", 0);
                      }
                      setState(() {
                        notificationValue = val;
                      });
                    },
                  ),
                  height: 80,
                  width: 80,
                ),
              ),
              // Container(
              //   height: 1,
              //   color: Colors.black12,
              // ),
              // ListTile(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => advertise()));
              //   },
              //   leading: Icon(
              //     Icons.speaker_group,
              //     color: Colors.orangeAccent,
              //   ),
              //   title: Text("Advertise with us"),
              // ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              ListTile(
                leading: Icon(
                  Icons.contact_phone,
                  color: Colors.orangeAccent,
                ),
                title: Text("Contact us"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => contactus()));
                },
              ),
              // Container(
              //   height: 1,
              //   color: Colors.black12,
              // ),
              // ListTile(
              //   leading: Icon(
              //     CupertinoIcons.settings,
              //     color: Colors.orangeAccent,
              //   ),
              //   title: Text("Instagram"),
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) =>  instapost()));
              //   },
              // ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              ListTile(
                onTap: () async {
                  var url = "https://wa.me/19293182046?text=Signup ";
                  await launch(Uri.encodeFull(url));
                },
                leading: Icon(
                  Icons.call,
                  color: Colors.orangeAccent,
                ),
                title: Text("Subscribe to Whatsapp"),
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => aboutus()));
                },
                leading: Icon(
                  Icons.people,
                  color: Colors.orangeAccent,
                ),
                title: Text("About us"),
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              ListTile(
                onTap: () {},
                leading: Text("Article Font Size "),
                title: Slider(
                  activeColor: Colors.orange,
                  min: 8,
                  max: 40,
                  value: slider.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      slider = value.toInt();
                      setsize(slider);
                    });
                  },
                ),
                trailing: Text("$slider"),
              ),
              Container(
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(height:73,),


            ],
          ),

          Positioned(
              bottom:20,left:50,
              right:50,
              child:  Center(
            child: Container(
              child:Column(children: [
                Container(
                  width:50,
                  height:50,
                  child: Image.asset('images/mainlogo.png'),

                ),
                SizedBox(height:0,),
                Text("Version 4.0")



              ],),
            ),
          ))
        ],
      ),
    );
  }

  getvalue() async {
    prefs = await SharedPreferences.getInstance();
    toggle = prefs.getInt("value") ?? 0;

    int prefNotificationValue = prefs.getInt("receive_notification") ?? 1;
    if(prefNotificationValue==0)
    {
      notificationValue = false;
    }else{
      notificationValue = true;
    }


    if (toggle == 1) {
      setState(() {
        value = false;
      });
    } else {
      setState(() {
        value = true;
      });
    }



  }

  getvalue2() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      slider = prefs.getInt("size") ?? 8;
    });
  }

  Future<void> setsize(int size) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setInt("size", size);
  }

  @override
  void initState() {
    getvalue();
    getvalue2();
  }
}
