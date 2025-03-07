import 'package:app/phaseone.dart';
import 'package:app/phasethree.dart';
import 'package:app/phasetwo.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late SharedPreferences prefs;
  late String? myToken;

  @override
  void initState() {
    initsharedpref().then((_) {
      myToken = prefs.getString('token');
    });
    super.initState();
  }

  Future<void> initsharedpref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GlassmorphicContainer(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 44,
          borderRadius: 15,
          alignment: Alignment.center,
          linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 169, 169, 169).withOpacity(0.2),
              const Color.fromARGB(255, 174, 174, 174).withOpacity(0.1),
            ],
          ),
          blur: 3,
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
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => PhaseOne(
                        token: myToken,
                      ),
                      transitionsBuilder: (_, animation, __, child) {
                        return Stack(
                          children: [
                            FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.0, 0.5,
                                      curve: Curves.easeInOut),
                                ),
                              ),
                              child: Container(
                                color: Colors.black,
                              ),
                            ),
                            FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.5, 1.0,
                                      curve: Curves.easeInOut),
                                ),
                              ),
                              child: child,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
                child: SizedBox(
                    width: 16,
                    height: 16,
                    child: Image.asset(
                      'assets/icons/fire.png',
                      fit: BoxFit.cover,
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => PhaseTwo(
                        token: myToken,
                      ),
                      transitionsBuilder: (_, animation, __, child) {
                        return Stack(
                          children: [
                            FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.0, 0.5,
                                      curve: Curves.easeInOut),
                                ),
                              ),
                              child: Container(
                                color: Colors.black,
                              ),
                            ),
                            FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.5, 1.0,
                                      curve: Curves.easeInOut),
                                ),
                              ),
                              child: child,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
                child: SizedBox(
                    width: 16,
                    height: 16,
                    child: Image.asset(
                      'assets/icons/lens.png',
                      fit: BoxFit.cover,
                    )),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => PhaseThree(
                        token: myToken,
                      ),
                      transitionsBuilder: (_, animation, __, child) {
                        return Stack(
                          children: [
                            FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.0, 0.5,
                                      curve: Curves.easeInOut),
                                ),
                              ),
                              child: Container(
                                color: Colors.black,
                              ),
                            ),
                            FadeTransition(
                              opacity: Tween<double>(
                                begin: 0.0,
                                end: 1.0,
                              ).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: const Interval(0.5, 1.0,
                                      curve: Curves.easeInOut),
                                ),
                              ),
                              child: child,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                },
                child: SizedBox(
                    width: 16,
                    height: 16,
                    child: Image.asset(
                      'assets/icons/cloud.png',
                      fit: BoxFit.cover,
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
