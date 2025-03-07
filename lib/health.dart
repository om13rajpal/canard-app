import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lottie/lottie.dart';

class Health extends StatelessWidget {
  final double leftPercentage;
  final double rightPercentage;
  const Health({super.key, required this.leftPercentage, required this.rightPercentage});

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const Text(
                'Left Hand',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: Color.fromARGB(255, 169, 169, 169),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 9,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 45,
                    animateFromLastPercent: true,
                    animation: true,
                    animationDuration: 1000,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: leftPercentage,
                    progressColor: const Color(0xffbebebe),
                    backgroundColor: const Color(0xff434343),
                    lineWidth: 10,
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Lottie.asset(
                      'assets/lottie/life.json',
                      fit: BoxFit.contain,
                      repeat: true,
                      renderCache: RenderCache.raster
                    ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            children: [
              const Text(
                'Right Hand',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: Color.fromARGB(255, 169, 169, 169),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 6,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 45,
                    animateFromLastPercent: true,
                    animation: true,
                    animationDuration: 1000,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: rightPercentage,
                    progressColor: const Color(0xffbebebe),
                    backgroundColor: const Color(0xff434343),
                    lineWidth: 10,
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Lottie.asset(
                      'assets/lottie/life.json',
                      fit: BoxFit.contain,
                      renderCache: RenderCache.raster,
                      repeat: true,
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
