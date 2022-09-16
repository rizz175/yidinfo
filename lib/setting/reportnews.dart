import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

class reportnews extends StatefulWidget {
  const reportnews({Key? key}) : super(key: key);

  @override
  _reportnewsState createState() => _reportnewsState();
}

class _reportnewsState extends State<reportnews> {
  int _groupValue = -1;
  File? attachfile;
  List<String>attachlist=[];
  String textt="Upload Documents";
  TextEditingController phone = TextEditingController();
  TextEditingController comment = TextEditingController();
  TextEditingController credit = TextEditingController();
  bool checkk=false;


  bool isloading=true;
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
  }
  var emailto=["rizzikhan175@gmail.com","rizvikhan175gmail.com"];
documentpicker()
async {


  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {

    setState(() {
      attachfile = File(result.files.single.path.toString());
      attachlist.add(attachfile!.path.toString());
      textt=attachfile!.path.toString();
    });
  } else {
    // User canceled the picker
  }
}
  Future<void> send(var body) async {


    final Email email = Email(
      body:body.toString(),
      subject: "Report News",
      recipients: ["office@YidInfo.net"],
      isHTML: false,
      attachmentPaths:attachlist
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Message is sent"),
      ),
    );
  }
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
                      child: Text("Report News",
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
            SizedBox(height: 14, width: 20,),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Text(
                "Do you have something that you would like to share?\nIf your submission is approved, it will be posted on our platforms.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),

                )),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,top:20),
              child: Text("Comments"
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: comment,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tells us everything!',
                  ),

                )),
            Container(
              margin: const EdgeInsets.only(left: 20.0,top:10,right:20),
              padding: const EdgeInsets.only(left: 20.0,top:0,right:20),

              width:MediaQuery.of(context).size.width,
              height:60,
               decoration:BoxDecoration(
                 border: Border.all(width:1)
               ),
              child:Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                      width:150,
                      child: Text("$textt")),
                  GestureDetector(
                    onTap:(){
log("asdsd");
                      documentpicker();
                    },
                    child: Container(decoration:BoxDecoration(shape:BoxShape.circle,color:Colors.black12),
                        child: Icon(Icons.add,color:Colors.white,)),
                  )
                ],),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,top:20),
              child: Text("Should we credit someone for this?"
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0,top:5),
              child: Row(
                children: [
                  Radio(
                    value: 0,
                    groupValue: _groupValue,
                    onChanged: (value) {
                      setState(() {
                        _groupValue = value as int;
                        checkk=true;
                      });
                    },
                  ), const Text('Yes'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,top:0),
              child: Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: (value) {
                      setState(() {
                        _groupValue = value as int;
                         checkk=false;


                      });
                    },
                  ), const Text('No'),
                ],
              ),
            ),


            Visibility(
                visible:checkk,
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0,top:20),
                child: Text("Who should we give credit to?"
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: credit,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Person name perhaps ?',
                    ),

                  )),


                  ],)),
            Container(
                width:MediaQuery.of(context).size.width,
                height:50,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical:10),
                child: ElevatedButton(
                    onPressed: (){

                      if(phone.text.toString()!="" && comment.text.toString()!="" && checkk==false)
                        {

                          var body={
                            "Phone":phone.text,
                            "Comments":comment.text,

                          };
send(body);
                        }
                      else if(phone.text.toString()!="" && comment.text.toString()!="" && credit.text.toString()!="" && checkk==true)
                        {
                          var body={
                            "Phone":phone.text.toString(),
                            "Comments":comment.text.toString(),
                            "Credit":credit.text.toString(),

                          };
                        send(body);}
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Fill Credentials"),
                            ),
                          );
                        }
                    },
                    child: Text('Submit'),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor
                    )
                )),SizedBox(height:20,)
          ],
        ),
      ),
    );
  }}
