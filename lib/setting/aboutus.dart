import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class aboutus extends StatefulWidget {
  const aboutus({Key? key}) : super(key: key);

  @override
  _aboutusState createState() => _aboutusState();
}

class _aboutusState extends State<aboutus> {


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
                      child: Text("About us",
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
            SizedBox(height: 10, width: 20,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "YidInfo – the most prime, accurate, and punctual up-to-the-minute news within the Jewish world, providing a combination of local and world news to keep you updated when it happens, as it happens.\n\nWe pride ourselves in bringing you the best news written directly to our readers from the best writers out there.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 20),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Text("Contact Details",style: TextStyle(
                fontSize: 23),)
            ),

           GestureDetector(
             onTap:() async {
               var url = "mailto:office@YidInfo.net";
               await launch(Uri.encodeFull(url));
             },
             child: Padding(
               padding: const EdgeInsets.only(left: 20.0, right: 20,top:20),

               child: Row(
                 children: [
                   Icon(Icons.email),SizedBox(width:10,),
                   Text("office@YidInfo.net",style: TextStyle(
                       fontSize: 18,))
                 ],
               ),
             ),
           )
,           GestureDetector(
              onTap:() async {
                var url = "tel:718-313-6501";
                await launch(Uri.encodeFull(url));
              },
  child:   Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20,top:20),

                child: Row(
                  children: [
                    Icon(Icons.call,color:Colors.green,),SizedBox(width:10,),
                    Text("718-313-6501",style: TextStyle(
                      fontSize: 18,))
                  ],
                ),
              ),
)
,           GestureDetector(
              onTap:() async {
                var uri = Uri.parse("google.navigation:q=40.631130,-73.995970&mode=d");

                await launch(Uri.encodeFull(uri.toString()));
              },
  child:   Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20,top:20),

                child: Row(
                  children: [
                    Icon(Icons.add_location,color:Colors.red,),SizedBox(width:10,),
                    Text("5511 13th Avenue\nBrooklyn, NY 11219",style: TextStyle(
                      fontSize: 18,))
                  ],
                ),
              ),
)



          ],
        ),
      ),
    );
  }}
