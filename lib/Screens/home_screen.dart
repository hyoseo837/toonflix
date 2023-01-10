import 'dart:async';
import 'package:flutter/material.dart';

const int maxTime = 1500;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSeconds = maxTime;
  late Timer timer;
  int totalPomodoros = 0;
  bool isplaying = false;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isplaying = false;
        totalSeconds = maxTime;
        totalPomodoros += 1;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void onStartPressed() {
    setState(() {
      isplaying = true;
      timer = Timer.periodic(const Duration(seconds: 1), onTick);
    });
  }

  void onPausePressed() {
    setState(() {
      isplaying = false;
      timer.cancel();
    });
  }

  void onResetPressed() {
    setState(() {
      isplaying = false;
      totalSeconds = maxTime;
    });
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                '${totalSeconds ~/ 60}:${(totalSeconds % 60).toString().padLeft(2, '0')}',
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                children: [
                  !isplaying
                      ? IconButton(
                          icon: const Icon(Icons.play_circle_outlined),
                          iconSize: 120,
                          onPressed: onStartPressed,
                          color: Theme.of(context).cardColor,
                        )
                      : IconButton(
                          onPressed: onPausePressed,
                          icon: const Icon(Icons.pause_circle_outlined),
                          iconSize: 120,
                          color: Theme.of(context).cardColor,
                        ),
                  IconButton(
                    onPressed: onResetPressed,
                    icon: const Icon(Icons.keyboard_return_outlined),
                    iconSize: 20,
                    color: Theme.of(context).cardColor,
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(50)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Comfortaa',
                              color:
                                  Theme.of(context).textTheme.headline1?.color),
                        ),
                        Text(
                          totalPomodoros.toString(),
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Comfortaa',
                              color:
                                  Theme.of(context).textTheme.headline1?.color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
