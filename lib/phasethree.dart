import 'dart:convert';
import 'package:app/callingcard.dart';
import 'package:app/gifanim.dart';
import 'package:app/health.dart';
import 'package:app/navigation.dart';
import 'package:app/stats.dart';
import 'package:app/taskdone.dart';
import 'package:app/tasks.dart';
import 'package:app/team_details.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PhaseThree extends StatefulWidget {
  final dynamic token;
  const PhaseThree({@required this.token, Key? key}) : super(key: key);

  @override
  State<PhaseThree> createState() => _PhaseOneState();
}

class _PhaseOneState extends State<PhaseThree> {
    List<Map<String, dynamic>> entryList = [];

  late io.Socket socket;
  late String team;
  late String name;
  late String teamid;
  late double mainTaskPercentage = 0;
  late double leftPercentage = 0;
  late double rightPercentage = 0;
  late int mainTask = 0;
  late int minorTask = 0;
  late String callingcard;
  late String taskOne = "";
  late String taskTwo = "";
  late String taskThree = "";
  late String taskFour = "";
  late String taskFive = "";
  late String taskSix = "";
  late String taskSeven = "";
  late String taskEight = "";
  late String taskOneStatus = "";
  late String taskTwoStatus = "";
  late String taskThreeStatus = "";
  late String taskFourStatus = "";
  late String taskFiveStatus = "";
  late String taskFSixStatus = "";
  late String taskSevenStatus = "";
  late String taskEightStatus = "";
  late String status = "";
  late int timeTaken = 0;
  late int minutes = 0;
  late int seconds = 0;
  late bool taskoneHint = false;
  late bool tasktwoHint = false;
  late bool taskthreeHint = false;
  late bool taskfourHint = false;
  late bool taskfiveHint = false;
  late String hintOne = "";
  late String hintTwo = "";
  late String hintThree = "";
  late String hintFour = "";
  late String hintFive = "";
  late String locationOne = "";
  late String locationTwo = "";
  late String locationThree = "";
  late String locationFour = "";
  late String locationFive = "";
  late String locationSix = "";
  late String locationSeven = "";
  late String locationEight = "";
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    Map<String, dynamic> jwtDecodedtoken = JwtDecoder.decode(widget.token);
    team = jwtDecodedtoken['teamName'];
    name = jwtDecodedtoken['username'];
    callingcard = jwtDecodedtoken["callingCard"];
    teamid = jwtDecodedtoken['teamId'];
    socket = io.io('https://test-backend-7n6jp.ondigitalocean.app/', <String, dynamic>{
      'transports': ['websocket'],
      "autoConnect": false,
    });
    socket.onConnect((_) {
      print("socket connected");
    });
    socket.on(teamid, (data) {
      if (data['type'] == 'completion') {
        setState(() {
          getTasks();
          getLeftRight();
          sendNotifications(data['message']);
        });
      }

      if (data['type'] == 'hint') {
        setState(() {
          getTasks();
        });
      }
    });

    socket.on("hand/$teamid", (data) {
      if (data == 'rebuild') {
        getLeftRight();
      }
    });

    socket.on("all/$teamid", (data) {
      print(data);
      if (data['type'] == 'notification') {
        print("notifications sent");
        sendNotifications(data['message']);
      }
    });

    socket.connect();
    getTasks();
    getLeftRight();

    super.initState();
  }

  void sendNotifications(String body) {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'New announcement',
            body: body));
  }

  void getTasks() async {
    var response = await http.get(
      Uri.parse('https://test-backend-7n6jp.ondigitalocean.app/team/$teamid'),
      headers: {
        "Content-Type": "application/json",
        "authorization": "Bearer ${widget.token}"
      },
    );

    var jsonRes = jsonDecode(response.body);
    print(jsonRes);
    if (jsonRes['status']) {
      var listData = jsonRes['data']['team']["powerUpsData"];
      if (listData is List) {
        setState(() {
          entryList = listData.map((item) {
            return Map<String, dynamic>.from(item);
          }).toList();
        });
      }
      mainTaskPercentage =
          (jsonRes['data']['team']['phase3']['completedTasks'] / 5) * 100;
      int task1 = jsonRes['data']['team']['phase3']['taskOrder'][0];
      int task2 = jsonRes['data']['team']['phase3']['taskOrder'][1];
      int task3 = jsonRes['data']['team']['phase3']['taskOrder'][2];
      int task4 = jsonRes['data']['team']['phase3']['taskOrder'][3];
      int task5 = jsonRes['data']['team']['phase3']['taskOrder'][4];

      mainTask = jsonRes['data']['team']['phase3']['completedTasks'];
      minorTask = jsonRes['data']['team']['phase3']['minorCompletedTasks'];
      print(minorTask);
      taskOne = jsonRes['data']['team']['phase3']['tasks']['$task1']['title'];
      taskTwo = jsonRes['data']['team']['phase3']['tasks']['$task2']['title'];
      taskThree = jsonRes['data']['team']['phase3']['tasks']['$task3']['title'];
      taskFour = jsonRes['data']['team']['phase3']['tasks']['$task4']['title'];
      taskFive = jsonRes['data']['team']['phase3']['tasks']['$task5']['title'];
      taskSix = jsonRes['data']['team']['phase3']['tasks']['306']['title'];
      taskSeven = jsonRes['data']['team']['phase3']['tasks']['307']['title'];
      hintOne = jsonRes['data']['team']['phase3']['tasks']['$task1']['hint'];
      hintTwo = jsonRes['data']['team']['phase3']['tasks']['$task2']['hint'];
      hintThree = jsonRes['data']['team']['phase3']['tasks']['$task3']['hint'];
      hintFour = jsonRes['data']['team']['phase3']['tasks']['$task4']['hint'];
      hintFive = jsonRes['data']['team']['phase3']['tasks']['$task5']['hint'];
      taskEight = jsonRes['data']['team']['phase3']['tasks']['308']['title'];
      locationOne =
          jsonRes['data']['team']['phase3']['tasks']['$task1']['description'];
      locationTwo =
          jsonRes['data']['team']['phase3']['tasks']['$task2']['description'];
      locationThree =
          jsonRes['data']['team']['phase3']['tasks']['$task3']['description'];
      locationFour =
          jsonRes['data']['team']['phase3']['tasks']['$task4']['description'];
      locationFive =
          jsonRes['data']['team']['phase3']['tasks']['$task5']['description'];
      locationSix =
          jsonRes['data']['team']['phase3']['tasks']['306']['description'];
      locationSeven =
          jsonRes['data']['team']['phase3']['tasks']['307']['description'];
      locationEight =
          jsonRes['data']['team']['phase3']['tasks']['308']['description'];
      taskoneHint =
          jsonRes['data']['team']['phase3']['tasks']['$task1']['hintActive'];
      tasktwoHint =
          jsonRes['data']['team']['phase3']['tasks']['$task2']['hintActive'];
      taskthreeHint =
          jsonRes['data']['team']['phase3']['tasks']['$task3']['hintActive'];
      taskfourHint =
          jsonRes['data']['team']['phase3']['tasks']['$task4']['hintActive'];
      taskfiveHint =
          jsonRes['data']['team']['phase3']['tasks']['$task5']['hintActive'];
      status = jsonRes['data']['team']['phase3']['status'];
      if (status == 'completedAll' ||
          status == 'completed' ||
          status == 'failed') {
        timeTaken = jsonRes['data']['team']['phase3']['timeTaken'];
        Duration duration = Duration(milliseconds: timeTaken);

        // Extract minutes and seconds
        minutes = duration.inMinutes; // Total minutes
        seconds = duration.inSeconds % 60; // Remaining seconds
      }
      print(status);

      taskOneStatus =
          jsonRes['data']['team']['phase3']['tasks']['$task1']['status'];
      taskTwoStatus =
          jsonRes['data']['team']['phase3']['tasks']['$task2']['status'];
      taskThreeStatus =
          jsonRes['data']['team']['phase3']['tasks']['$task3']['status'];
      taskFourStatus =
          jsonRes['data']['team']['phase3']['tasks']['$task4']['status'];
      taskFiveStatus =
          jsonRes['data']['team']['phase3']['tasks']['$task5']['status'];

      taskFSixStatus =
          jsonRes['data']['team']['phase3']['tasks']['306']['status'];
      taskSevenStatus =
          jsonRes['data']['team']['phase3']['tasks']['307']['status'];
      taskEightStatus =
          jsonRes['data']['team']['phase3']['tasks']['308']['status'];

      setState(() {});
    } else {
      mainTask = 0;
      minorTask = 0;
    }
  }

  void getLeftRight() async {
    var response = await http.get(Uri.parse("https://test-backend-7n6jp.ondigitalocean.app/hand"));

    var jsonRes = jsonDecode(response.body);
    print(jsonRes);
    if (jsonRes["status"]) {
      leftPercentage = jsonRes['data']["leftHandHealth"] / 1000;
      print(leftPercentage);
      rightPercentage = jsonRes['data']["rightHandHealth"] / 1000;
      print(rightPercentage);
      setState(() {});
    }
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: const Color(0xFF0A0A0A),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GifAnim(
                    gifPath: 'assets/gif/phasethree.gif',
                    phaseTwo: false,
                    phase: 3,
                    teamid: teamid,
                  ),
                  Stats(
                      phase: 'Phase 3',
                      percentage: mainTaskPercentage.toString(),
                      maintask: mainTask.toString(),
                      sidetask: minorTask.toString()),
                  Transform.translate(
                      offset: const Offset(0, -19),
                      child: CallingCard(gifPath: callingcard)),
                  Transform.translate(
                      offset: const Offset(0, -16),
                      child: TeamDetails(teamname: team, name: name)),
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.92,
                      child: const Text(
                        'Mission Intel',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 169, 169, 169)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.92,
                      child: const Text(
                        'Major Tasks',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 169, 169, 169)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.92,
                    child: Transform.translate(
                      offset: const Offset(-10, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          taskOneStatus == 'completed'
                              ? TasksDone(
                                  task: taskOne,
                                )
                              : Tasks(
                                  task: taskOne,
                                  hint: taskoneHint,
                                  hinttext: hintOne,
                                  location: locationOne,
                                ),
                          taskTwoStatus == 'completed'
                              ? TasksDone(
                                  task: taskTwo,
                                )
                              : Tasks(
                                  task: taskTwo,
                                  hint: tasktwoHint,
                                  hinttext: hintTwo,
                                  location: locationTwo,
                                ),
                          taskThreeStatus == 'completed'
                              ? TasksDone(
                                  task: taskThree,
                                )
                              : Tasks(
                                  task: taskThree,
                                  hint: taskthreeHint,
                                  hinttext: hintThree,
                                  location: locationThree,
                                ),
                          taskFourStatus == 'completed'
                              ? TasksDone(
                                  task: taskFour,
                                )
                              : Tasks(
                                  task: taskFour,
                                  hint: taskfourHint,
                                  location: locationFour,
                                  hinttext: hintFour,
                                ),
                          taskFiveStatus == 'completed'
                              ? TasksDone(
                                  task: taskFive,
                                )
                              : Tasks(
                                  task: taskFive,
                                  hint: taskfiveHint,
                                  hinttext: hintFive,
                                  location: locationFive,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 17),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.92,
                      child: const Text(
                        'Minor Tasks',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 169, 169, 169)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.92,
                    child: Transform.translate(
                      offset: const Offset(-10, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          taskFSixStatus == 'completed'
                              ? TasksDone(
                                  task: taskSix,
                                )
                              : Tasks(
                                  task: taskSix,
                                  location: locationSix,
                                ),
                          taskSevenStatus == 'completed'
                              ? TasksDone(
                                  task: taskSeven,
                                )
                              : Tasks(
                                  task: taskSeven,
                                  location: locationThree,
                                ),
                          taskEightStatus == 'completed'
                              ? TasksDone(
                                  task: taskEight,
                                )
                              : Tasks(
                                  task: taskEight,
                                  location: locationEight,
                                ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Divider(
                        endIndent: 50,
                        indent: 50,
                        color: Colors.grey,
                      ),
                      Text("Power Ups",
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 169, 169, 169))),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.92,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: entryList.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          entry['title'] ?? '',
                                          style: const TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 169, 169, 169),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      Divider(endIndent: 50, indent: 50, color: Colors.grey),
                    ],
                  ),
                  Transform.translate(
                      offset: const Offset(0, 30),
                      child: Health(
                        leftPercentage: leftPercentage,
                        rightPercentage: rightPercentage,
                      )),
                  (status == 'completedAll' ||
                          status == 'completed' ||
                          status == 'failed')
                      ? Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.92,
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    'Congratulations! You have completed Phase 3',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 169, 169, 169)),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Center(
                                  child: Text(
                                    '${minutes}M : ${seconds}S',
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color:
                                            Color.fromARGB(255, 169, 169, 169)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
            const Positioned(bottom: 17, left: 0, right: 0, child: Navigation())
          ],
        ),
      ),
    ));
  }
}
