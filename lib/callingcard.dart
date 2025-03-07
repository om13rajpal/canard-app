import 'package:flutter/material.dart';

class CallingCard extends StatelessWidget {
  final String gifPath;

  const CallingCard({super.key, required this.gifPath});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.92,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          gifPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}