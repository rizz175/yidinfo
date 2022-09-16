// @dart=2.9

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yidinfo/hive/notification_model.dart';
import 'dart:math' as math;

import 'Controller/changetheme.dart';
import 'Menubar/menubar.dart';
import 'Screens/notficationform.dart';
import 'Screens/notificationsscreen.dart';
import 'constants/constants.dart';
import 'provider/notification_provider.dart';
import 'package:yidinfo/constants/globals.dart' as globals;

const String notificationBoxName = "notification";
SharedPreferences prefs;

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  globals.appNavigator = GlobalKey<NavigatorState>();
  prefs = await SharedPreferences.getInstance();
  if (prefs.getInt(noOfNotification) == null) {
    prefs.setInt(noOfNotification, 0);
  }

  runApp(MyApp(prefs.getInt("value") ?? 0));
}

class MyApp extends StatelessWidget {
  int toggle;

  MyApp(this.toggle);
  ThemeData theme;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final provider=Provider.of<ChangeTheme>(context).darkTheme;

    return MultiProvider(providers: [
      ChangeNotifierProvider<ChangeTheme>(
          create: (context) => ChangeTheme(toggle),
          child: const MaterialAppTheme()),
      ChangeNotifierProvider<NotificationProvider>(
        create: (_) => NotificationProvider(
          prefs,
        ),
      ),
    ], child: const MaterialAppTheme());
  }
}

class MaterialAppTheme extends StatelessWidget {
  const MaterialAppTheme({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ChangeTheme>(context);

    return MaterialApp(
      theme: theme.gettheme(),
      debugShowCheckedModeBanner: false,
      navigatorKey: globals.appNavigator,
      // theme: ThemeData(
      //   primaryColor:Colors.orangeAccent,
      //   focusColor:Colors.orangeAccent
      // ),
      home: MyHomePage(
        context: context,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.context}) : super(key: key);
  final BuildContext context;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  void initState() {
    initPlatformState(widget.context);
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat();



    Timer(
        Duration(seconds: 3),
        () {
  check();
  });
  }


  check() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
if(prefs.getString("firsttimee11")==null)
  {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
  }
else{
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) =>  menubar()));
}

  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> initPlatformState(BuildContext context) async {
    if (!mounted) return;
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);
    await OneSignal.shared.setAppId('3b74938e-68cd-41cd-84b9-64a4bf0fd97d');
    OneSignal.shared
        .setNotificationWillShowInForegroundHandler((openedResult) async {
      OneSignal.shared.completeNotification(
          openedResult.notification.notificationId, false);
      log('NOTIIII foreground');

      final document = await getApplicationDocumentsDirectory();
      Hive.init(document.path);
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(NotificationModelAdapter());
      }
      await Hive.openBox<NotificationModel>(notificationBoxName)
          .whenComplete(() {
        Box<NotificationModel> notifyBox =
            Hive.box<NotificationModel>(notificationBoxName);
        var url =
            openedResult.notification.additionalData['myappurl'].toString();
        NotificationModel model = NotificationModel(
            title: openedResult.notification.title,
            detail: openedResult.notification.body,
            url: url,
            isCompleted: false);
        notifyBox.add(model);
        notifyBox.close();
        log('Added model');
        Provider.of<NotificationProvider>(context, listen: false).setCounter(1);
      }).catchError((e) {
        log(e.toString());
      });
    });

    OneSignal.shared.setNotificationOpenedHandler((openedResult) async {
      log('NOTIIII onclick');

      final document = await getApplicationDocumentsDirectory();
      Hive.init(document.path);
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(NotificationModelAdapter());
      }
      await Hive.openBox<NotificationModel>(notificationBoxName)
          .whenComplete(() {
        var url =
            openedResult.notification.additionalData['myappurl'].toString();
        Box<NotificationModel> notifyBox =
            Hive.box<NotificationModel>(notificationBoxName);
        NotificationModel model = NotificationModel(
            title: openedResult.notification.title,
            detail: openedResult.notification.body,
            url: url,
            isCompleted: false);
        notifyBox.add(model);
        notifyBox.close();
        log('Added model');
        Provider.of<NotificationProvider>(context, listen: false).setCounter(1);
      });

      globals.appNavigator.currentState.push(
          MaterialPageRoute(builder: (C) => NotificationPage(context: C)));
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getInt("receive_notification")==null)
    {
      OneSignal.shared.disablePush(false);
      print("PUSHNOTIFICATION ENABLED");

    }else if(prefs.getInt("receive_notification")==0){
      OneSignal.shared.disablePush(true);
      print("PUSHNOTIFICATION DISABLED");
    }else{
      OneSignal.shared.disablePush(false);
      print("PUSHNOTIFICATION ENABLED");
    }

    OneSignal.shared.getDeviceState().then((deviceState) {
      print("DeviceState: ${deviceState?.jsonRepresentation()}");
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * math.pi,
            child: child,
          );
        },
        child: Container(
            width: 120, height: 120, child: Image.asset("images/logo.png")),
      ),
    ));
  }
}
