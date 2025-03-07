import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class Tasks extends StatelessWidget {
  final String task;
  final bool? hint;
  final String? hinttext;
  final String location;

  const Tasks({super.key, required this.task, this.hint, this.hinttext, required this.location});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8, top: 17),
          child: Transform.translate(
            offset: const Offset(0, -6),
            child: SizedBox(
                width: 14,
                height: 14,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: const Color.fromARGB(255, 170, 170, 170),
                          width: 1.5)),
                )),
          ),
        ),
        Transform.translate(
          offset: const Offset(1, 3),
          child: InkWell(
            onDoubleTap: () {
              showDialog(
                context: context,
                barrierDismissible:
                    true, // Allow dismissing the popup by tapping outside
                builder: (BuildContext context) {
                  return Dialog(
                    backgroundColor: Colors
                        .transparent, // Transparent background for the glass effect
                    child: GlassmorphicContainer(
                      width: 300,
                      height: 200,
                      borderRadius: 20,
                      blur: 10,
                      alignment: Alignment.center,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFFffffff).withOpacity(0.2),
                          const Color(0xFFffffff).withOpacity(0.1),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                      border: 1.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Location', // Popup title
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            location,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70), // Popup description
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the popup
                            },
                            child: const Text('Close'), // Close button
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            onLongPress: () {
              if (hint != null && hint == true) {
                showDialog(
                  context: context,
                  barrierDismissible:
                      true, // Allow dismissing the popup by tapping outside
                  builder: (BuildContext context) {
                    return Dialog(
                      backgroundColor: Colors
                          .transparent, // Transparent background for the glass effect
                      child: GlassmorphicContainer(
                        width: 300,
                        height: 200,
                        borderRadius: 20,
                        blur: 10,
                        alignment: Alignment.center,
                        linearGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color(0xFFffffff).withOpacity(0.2),
                            const Color(0xFFffffff).withOpacity(0.1),
                          ],
                        ),
                        borderGradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.5),
                            Colors.white.withOpacity(0.1),
                          ],
                        ),
                        border: 1.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Hint', // Popup title
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              hinttext!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white70), // Popup description
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the popup
                              },
                              child: const Text('Close'), // Close button
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: Text(
              task, // Text that is displayed for the task
              style: const TextStyle(
                fontFamily: 'Roboto',
                height: 0,
                fontSize: 17.5,
                color: Color.fromARGB(255, 213, 213, 213),
              ),
            ),
          ),
        ), // InkWell and Text ends her
      ],
    );
  }
}
