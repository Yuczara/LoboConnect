import 'package:flutter/material.dart';
import 'package:loboconnectnotif/pages/home_page.dart';
import 'package:loboconnectnotif/pages/message_page.dart';
import 'package:loboconnectnotif/services/push_notification_service.dart';
 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

  runApp(MyApp());
}  
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
 
class _MyAppState extends State<MyApp>{
    @override
     void initState() { 
    super.initState();
    //context
    PushNotificationService.messageStream.listen((message) { 
      print('******MyApp: $message');
    });
  }
    Widget build(BuildContext context) {
    return MaterialApp(
      title: 'home',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePage(),
        'message':(_) => MessagePage(),
      },
      
    );
  }
}