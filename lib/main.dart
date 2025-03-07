import 'package:app/splash.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  runApp(Canard(
    token: token,
  ));
}

class Canard extends StatefulWidget {
  final dynamic token;
  const Canard({
    @required this.token,
    Key? key,
  }) : super(key: key);

  @override
  State<Canard> createState() => _CanardState();
}

class _CanardState extends State<Canard> {
  @override
  Widget build(BuildContext context) {
    String? myToken = widget.token;

    if (widget.token != null) {
      if (!JwtDecoder.isExpired(widget.token)) {}
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Canard",
      theme: ThemeData(
          primaryColor: const Color(0xFF161616),
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Splash(token: myToken),
    );
  }
}
