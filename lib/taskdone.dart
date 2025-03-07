import 'package:flutter/material.dart';

class TasksDone extends StatelessWidget {
  final String task;

  const TasksDone({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: SizedBox(
            width: 15,
            height: 34,
            child: Image.asset(
              'assets/gif/fire.gif',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(1, 3),
          child: Text(
            task,
            style: const TextStyle(
                fontFamily: 'Roboto',
                height: 0,
                fontSize: 17.5,
                overflow: TextOverflow.fade,
                color: Color.fromARGB(255, 135, 135, 135),
                decoration: TextDecoration.lineThrough,
                decorationColor: Color.fromARGB(255, 135, 135, 135),
                decorationThickness: 1.3),
          ),
        )
      ],
    );
  }
}
