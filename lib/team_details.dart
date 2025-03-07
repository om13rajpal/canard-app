import 'package:flutter/material.dart';

class TeamDetails extends StatelessWidget {
  final String teamname;
  final String name;

  const TeamDetails({super.key, required this.teamname, required this.name});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.92,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            teamname,
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 169, 169, 169)),
          ),
          const SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 12,
            child: Image.asset(
              'assets/icons/team_arrow.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            name,
            style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 169, 169, 169)),
          ),
        ],
      ),
    );
  }
}
