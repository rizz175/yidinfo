import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class contactus extends StatefulWidget {
  const contactus({Key? key}) : super(key: key);

  @override
  _contactusState createState() => _contactusState();
}

class _contactusState extends State<contactus> {
  int _groupValue = -1;

  TextEditingController phone = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController emaill = TextEditingController();
  TextEditingController message = TextEditingController();


  Future<void> send() async {

    var body={
      "Name":name.text,
      "Phone":phone.text,
      "Email":emaill.text,
      "Message":message.text
    };

    final Email email = Email(
      body:body.toString(),
      subject: "Contact Us",
      recipients: ["office@YidInfo.net"],
      isHTML: false,
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
    return Scaffold(
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
                      child: Text("Contact us",
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight
                            .bold,),),
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
            SizedBox(height: 34, width: 20,),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your Name (Required)',
                  ),

                )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: emaill,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your email (Required)',
                  ),

                )),

            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: phone,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone',
                  ),

                )),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  maxLines:5,
                  controller: message,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Message (Required)',
                  ),

                )),
            Container(
              width:MediaQuery.of(context).size.width,
                height:50,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ElevatedButton(
                    onPressed: (){





                      if(name.text.toString()!="" && emaill.text.toString()!="" && message.text.toString()!="")
                      {
                        send();


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
                    child: Text('Send'),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor
                    )
                )),

          ],
        ),
      ),
    );
  }}
