import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService{
  static FirebaseMessaging messaging= FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = new StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;

//Metodos para los diferentes tipos de notificaciones

//segundo plano
  static Future _backgroundHandler( RemoteMessage message)async{
    print('**background Handler** ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.body?? 'No titulo');
  }

  static Future _onMessageHandler( RemoteMessage message)async{
    print('**onMessageHandler** ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.title?? 'No titulo');
  }

//app abierta
  static Future _onMessageOpenApp( RemoteMessage message)async{
    print('**onMessageOpenApp** ${message.messageId}');
    print(message.data);
    _messageStream.add(message.notification?.title?? 'No titulo');
  }

  static Future initializeApp() async{
    //push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('TOKEN!!!!!: $token');
    FirebaseMessaging.instance.subscribeToTopic('test');
    //print('suscrito al topic test');
    //HANDLERS
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);


    //local notifications

   
  }

   static closeStreams(){
      _messageStream.close();
    }

}
