import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hexahealth/res/AppContextExtension.dart';
import 'package:hexahealth/view/HomeScreen.dart';
import 'package:hexahealth/view/MovieDetailsScreen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'models/MoviesMain.dart';
import 'utils/notification.dart';
void main() async {
  await init();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

 await runZonedGuarded(() async{
    runApp(MyApp());
  }, (error, stackTrace) {
   FirebaseCrashlytics.instance.recordError(error, stackTrace);
 });
}
Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);



    super.initState();
  }

  _changeData(String msg){
    setState(() => notificationData = msg);


  }
  _changeBody(String msg) => setState(() => notificationBody = msg);
  _changeTitle(String msg){
    setState(() => notificationTitle = msg);
      if(notificationTitle!='No Title') {
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        await showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              AlertDialog(
                title: Text(notificationData),
                content: Text(notificationBody),
                actions: <Widget>[
                  FlatButton(
                    child: Text(notificationTitle),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hexa Health',
        theme: ThemeData(
          primarySwatch: context.resources.color.colorPrimary,
          accentColor: context.resources.color.colorAccent,
        ),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id : (context) => HomeScreen(),
          MovieDetailsScreen.id : (context) => MovieDetailsScreen(ModalRoute.of(context)!.settings.arguments as Movie),
        },
      ),
    );
  }
}
