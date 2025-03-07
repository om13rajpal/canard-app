import 'package:app/login.dart';
import 'package:app/phaseone.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Splash extends StatefulWidget {
  final dynamic token;
  const Splash({
    @required this.token,
    Key? key,
  }) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool exists = false;

  @override
  void initState() {
    checkExist(widget.token);
    super.initState();
  }

  void checkExist(token) {
    if (token != null) {
      if (!JwtDecoder.isExpired(token)) {
        exists = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String? token = widget.token;
    Future.delayed(const Duration(seconds: 3), () {
      if (exists) {
        if(!context.mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => (PhaseOne(token: token))),
        );
      } else {
        if(!context.mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => (const Login())),
        );
      }
    });

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Center(
          child: SizedBox(
            child: Image.asset(
              'assets/gif/splash.gif',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}