import 'dart:convert';
import 'package:app/login.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class GifAnim extends StatefulWidget {
  final String gifPath;
  final bool phaseTwo;
  final bool? first;
  final bool? second;
  final bool? third;
  final bool? fourth;
  final int phase;
  final String teamid;
  const GifAnim(
      {super.key,
      required this.gifPath,
      required this.phaseTwo,
      this.first,
      this.second,
      this.third,
      this.fourth,
      required this.phase,
      required this.teamid});

  @override
  State<GifAnim> createState() => _GifAnimState();
}

class _GifAnimState extends State<GifAnim> {
  List<Map<String, dynamic>> entryList = [];
  TextEditingController answer = TextEditingController();
  void getList() async {
    var response = await http.get(
      Uri.parse('https://test-backend-7n6jp.ondigitalocean.app/settings/'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(response.body);
      print(jsonRes);
      if (jsonRes['status']) {
        var listData = jsonRes['data']['settings']["announcements"];
        if (listData is List) {
          setState(() {
            entryList = listData.map((item) {
              return Map<String, dynamic>.from(item);
            }).toList();
          });
        }
      }
    }
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  void logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    if (!context.mounted) return;

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(0, -15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              widget.gifPath,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Positioned(
          top: 27,
          left: 15,
          child: InkWell(
            onTap: () {
              logout(context);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color(0xff747474), width: 1.3)),
                ),
                SizedBox(
                    width: 12,
                    height: 12,
                    child: Image.asset(
                      'assets/icons/logout.png',
                      fit: BoxFit.cover,
                    ))
              ],
            ),
          ),
        ),
        Positioned(
          top: 34,
          right: 58,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return GlassmorphicContainer(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      borderRadius: 20,
                      alignment: Alignment.center,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.2),
                          const Color.fromARGB(255, 153, 153, 153)
                              .withOpacity(0.1),
                        ],
                      ),
                      blur: 5,
                      borderGradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white,
                          Colors.grey,
                        ],
                      ),
                      border: 0,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 10, right: 10),
                        child: Column(
                          children: [
                            TextField(
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                              cursorColor: Colors.white,
                              cursorWidth: 2,
                              textAlignVertical: TextAlignVertical.center,
                              cursorHeight: 20,
                              cursorOpacityAnimates: true,
                              cursorRadius: const Radius.circular(20),
                              decoration: InputDecoration(
                                labelText: "Phase Answer",
                                labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Roboto',
                                    fontSize: 13),
                                fillColor:
                                    const Color.fromARGB(129, 79, 79, 79),
                                filled: true,
                                contentPadding: const EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              controller: answer,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                var body = {
                                  "answer": answer.text,
                                };
                                var response = await http.post(
                                    Uri.parse(
                                        "https://test-backend-7n6jp.ondigitalocean.app/team/${widget.teamid}/${widget.phase}/"),
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: jsonEncode(body));

                                var jsonRes = await jsonDecode(response.body);
                                print(jsonRes);
                                if (jsonRes['status']) {
                                  print(jsonRes['message']);
                                }
                              },
                              style: ButtonStyle(
                                  alignment: Alignment.center,
                                  backgroundColor: WidgetStateProperty.all<
                                          Color>(
                                      const Color.fromARGB(255, 67, 67, 67)),
                                  shape: WidgetStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)))),
                              child: const Text(
                                'Complete Mission',
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  child: GlassmorphicContainer(
                    width: 29,
                    height: 29,
                    borderRadius: 20,
                    alignment: Alignment.center,
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color.fromARGB(255, 164, 164, 164)
                            .withOpacity(0.2),
                        const Color.fromARGB(255, 205, 205, 205)
                            .withOpacity(0.1),
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
                SizedBox(
                  width: 13,
                  height: 13,
                  child: Image.asset(
                    'assets/icons/story.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 34,
          right: 15,
          child: InkWell(
            onTap: () {
              getList();
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  barrierColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        GlassmorphicContainer(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          borderRadius: 20,
                          alignment: Alignment.center,
                          linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.2),
                              const Color.fromARGB(255, 153, 153, 153)
                                  .withOpacity(0.1),
                            ],
                          ),
                          blur: 5,
                          borderGradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white,
                              Colors.grey,
                            ],
                          ),
                          border: 0,
                          child: ListView.builder(
                            reverse: false,
                            itemCount: entryList.length,
                            itemBuilder: (context, index) {
                              final listItem = entryList[index];
                              print(listItem);
                              return Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            139, 255, 255, 255),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          listItem['message'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontFamily: 'inter',
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const Column(
                          children: [],
                        )
                      ],
                    );
                  });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                GlassmorphicContainer(
                  width: 29,
                  height: 29,
                  borderRadius: 20,
                  alignment: Alignment.center,
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(255, 164, 164, 164).withOpacity(0.2),
                      const Color.fromARGB(255, 205, 205, 205).withOpacity(0.1),
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
                SizedBox(
                  width: 13,
                  height: 13,
                  child: Image.asset(
                    'assets/icons/announcement.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            ),
          ),
        ),
        (widget.phaseTwo)
            ? Positioned(
                top: 34,
                right: 100,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Stack(
                            children: [
                              GlassmorphicContainer(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  borderRadius: 20,
                                  alignment: Alignment.center,
                                  linearGradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      const Color.fromARGB(255, 255, 255, 255)
                                          .withOpacity(0.2),
                                      const Color.fromARGB(255, 153, 153, 153)
                                          .withOpacity(0.1),
                                    ],
                                  ),
                                  blur: 5,
                                  borderGradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.white,
                                      Colors.grey,
                                    ],
                                  ),
                                  border: 0,
                                  child: Center(
                                    child: GridView.count(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1,
                                      mainAxisSpacing: 5,
                                      padding: const EdgeInsets.all(10),
                                      crossAxisSpacing: 5,
                                      children: [
                                        (widget.first! == true)
                                            ? ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                20)),
                                                child: Image.asset(
                                                  "assets/gif/1.gif",
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : const SizedBox(),
                                        (widget.second! == true)
                                            ? ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                20)),
                                                child: Image.asset(
                                                  "assets/gif/2.gif",
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : const SizedBox(),
                                        (widget.third! == true)
                                            ? ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(
                                                                20)),
                                                child: Image.asset(
                                                  "assets/gif/3.gif",
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : const SizedBox(),
                                        (widget.fourth! == true)
                                            ? ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(
                                                                20)),
                                                child: Image.asset(
                                                  "assets/gif/4.gif",
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  )),
                              const Column(
                                children: [],
                              )
                            ],
                          );
                        });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GlassmorphicContainer(
                        width: 29,
                        height: 29,
                        borderRadius: 20,
                        alignment: Alignment.center,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color.fromARGB(255, 164, 164, 164)
                                .withOpacity(0.2),
                            const Color.fromARGB(255, 205, 205, 205)
                                .withOpacity(0.1),
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
                      SizedBox(
                        width: 13,
                        height: 13,
                        child: Image.asset(
                          'assets/icons/cctv.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
