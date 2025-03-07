import 'dart:convert';

import 'package:app/phaseone.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late SharedPreferences prefs;

  TextEditingController team = TextEditingController();

  TextEditingController password = TextEditingController();

  @override
  void initState() {
    initsharedpref();
    super.initState();
  }

  void initsharedpref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void loginUser(BuildContext context) async {
    if (team.text.isNotEmpty && password.text.isNotEmpty) {
      var reqBody = {
        "username": team.text.trim(),
        "password": password.text.trim()
      };

      var response = await http.post(
          Uri.parse('https://test-backend-7n6jp.ondigitalocean.app/user/login'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));

      var jsonRes = jsonDecode(response.body);
      print(jsonRes);
      if (jsonRes['status']) {
        var myToken = jsonRes['data']['userToken'];
        await prefs.setString('token', myToken);
        if (!context.mounted) return;

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PhaseOne(token: myToken),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
      child: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, 60),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Image.asset(
                  'assets/gif/login.gif',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GlassmorphicContainer(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      borderRadius: 20,
                      alignment: Alignment.center,
                      linearGradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 38, 38, 38),
                          Color.fromARGB(255, 9, 9, 9),
                        ],
                      ),
                      blur: 6,
                      borderGradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.grey,
                        ],
                      ),
                      border: 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Server Locked',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white38),
                        ),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: TextField(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            cursorColor: Colors.white,
                            cursorWidth: 2,
                            textAlignVertical: TextAlignVertical.center,
                            cursorHeight: 20,
                            cursorOpacityAnimates: true,
                            cursorRadius: const Radius.circular(20),
                            decoration: InputDecoration(
                              labelText: "Enter your username",
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 13),
                              fillColor: const Color.fromARGB(255, 67, 67, 67),
                              filled: true,
                              contentPadding: const EdgeInsets.all(10),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            controller: team,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: TextField(
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            cursorColor: Colors.white,
                            obscureText: true,
                            obscuringCharacter: "\$",
                            cursorWidth: 2,
                            textAlignVertical: TextAlignVertical.center,
                            cursorHeight: 20,
                            cursorOpacityAnimates: true,
                            cursorRadius: const Radius.circular(20),
                            decoration: InputDecoration(
                              labelText: "Enter your password",
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 13),
                              fillColor: const Color.fromARGB(255, 67, 67, 67),
                              filled: true,
                              contentPadding: const EdgeInsets.all(10),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            controller: password,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            loginUser(context);
                          },
                          style: ButtonStyle(
                              alignment: Alignment.center,
                              backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color.fromARGB(255, 67, 67, 67)),
                              shape: WidgetStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                          child: const Text(
                            'Hack System',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 13,
                                color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
