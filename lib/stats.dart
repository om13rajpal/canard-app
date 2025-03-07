import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Stats extends StatelessWidget {
  final String phase;
  final String percentage;
  final String maintask;
  final String sidetask;

  const Stats(
      {super.key,
      required this.phase,
      required this.percentage,
      required this.maintask,
      required this.sidetask});
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Transform.translate(
        offset: const Offset(0, -58),
        child: Stack(children: [
          GlassmorphicContainer(
            width: MediaQuery.of(context).size.width * 0.92,
            height: 82,
            borderRadius: 20,
            alignment: Alignment.center,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF494949).withOpacity(0.2),
                const Color(0xFF494949).withOpacity(0.1),
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
          const Positioned(
            top: 23,
            left: 17,
            child: Text(
              'Current progress',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  color: Color.fromARGB(255, 169, 169, 169)),
            ),
          ),
          Positioned(
            top: 38,
            left: 17,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "$percentage%",
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Color.fromARGB(255, 213, 213, 213),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  'completed',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      color: Color.fromARGB(255, 169, 169, 169)),
                )
              ],
            ),
          ),
          const Positioned(
            top: 23,
            right: 17,
            child: Text(
              'Tasks Completed',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 10,
                  color: Color.fromARGB(255, 169, 169, 169)),
            ),
          ),
          Positioned(
            top: 38,
            right: 17,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  maintask,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Color.fromARGB(255, 213, 213, 213),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Text(
                  'main',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      color: Color.fromARGB(255, 169, 169, 169)),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  sidetask,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      color: Color.fromARGB(255, 213, 213, 213),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 3,
                ),
                const Text(
                  'side',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Roboto',
                      color: Color.fromARGB(255, 169, 169, 169)),
                ),
              ],
            ),
          ),
        ]),
      ),
      Transform.translate(
        offset: const Offset(0, -39),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.92,
          child: Text(
            phase,
            style: const TextStyle(
                fontSize: 27,
                fontFamily: 'Roboto',
                color: Color.fromARGB(255, 169, 169, 169),
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Transform.translate(
        offset: const Offset(0, -35),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.92,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(alignment: Alignment.center, children: [
                  Container(
                    width: 35,
                    height: 17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xff434343),
                    ),
                  ),
                  SizedBox(
                      width: 11.5,
                      child: Image.asset(
                        'assets/icons/arrow.png',
                        fit: BoxFit.cover,
                      ))
                ]),
                Expanded(
                  child: LinearPercentIndicator(
                    lineHeight: 17,
                    padding: const EdgeInsets.only(left: 5),
                    animation: true,
                    animateFromLastPercent: true,
                    animationDuration: 1000,
                    progressColor: const Color(0xFFBEBEBE),
                    percent: double.parse(percentage) / 100,
                    barRadius: const Radius.circular(10),
                    backgroundColor: const Color(0xFF434343),
                  ),
                )
              ],
            )),
      ),
    ]);
  }
}
