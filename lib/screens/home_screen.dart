import 'package:flutter/material.dart';
import 'dart:async';

import 'package:toonflix2/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static late String returnData;
  late int inputSeconds;
  late int totalSeconds;
  late Timer timer;
  bool isRunning = false;
  bool isComplete = false;
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        isRunning = false;
        isComplete = true;
        totalSeconds = inputSeconds;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
        isComplete = false;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onResetPressed() {
    setState(() {
      totalPomodoros = 0;
    });
  }

  void onRefreshPressed() {
    setState(() {
      isComplete = true;
      totalSeconds = inputSeconds;
    });
  }

  void goToSettingPressed() async {
    returnData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingScreen()),
    );
    setState(() {
      inputSeconds = int.parse(returnData) * 60;
      totalSeconds = inputSeconds;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  void initState() {
    returnData = '1500';
    inputSeconds = 1500;
    totalSeconds = inputSeconds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Transform.translate(
              offset: const Offset(0, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: goToSettingPressed,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      format(totalSeconds),
                      style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 89,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  /*
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        returnData,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '$inputSeconds',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '$totalSeconds',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      
                    ],
                  ),
                  */
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: isRunning
                  ? Center(
                      child: IconButton(
                        iconSize: 120,
                        color: Theme.of(context).cardColor,
                        onPressed: isRunning ? onPausePressed : onStartPressed,
                        icon: Icon(isRunning
                            ? Icons.pause_circle_rounded
                            : Icons.play_circle_outline),
                      ),
                    )
                  : isComplete
                      ? IconButton(
                          iconSize: 120,
                          color: Theme.of(context).cardColor,
                          onPressed:
                              isRunning ? onPausePressed : onStartPressed,
                          icon: Icon(isRunning
                              ? Icons.pause_circle_rounded
                              : Icons.play_circle_outline),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 120,
                              color: Theme.of(context).cardColor,
                              onPressed:
                                  isRunning ? onPausePressed : onStartPressed,
                              icon: Icon(isRunning
                                  ? Icons.pause_circle_rounded
                                  : Icons.play_circle_outline),
                            ),
                            IconButton(
                              iconSize: 120,
                              color: Theme.of(context).cardColor,
                              onPressed: onRefreshPressed,
                              icon: const Icon(Icons.refresh_rounded),
                            ),
                          ],
                        ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Transform.translate(
                    offset: const Offset(0, 35),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pomodors',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color),
                          ),
                          Text(
                            '$totalPomodoros',
                            style: TextStyle(
                                fontSize: 60,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .color),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  iconSize: 30,
                                  onPressed: onResetPressed,
                                  icon: const Icon(Icons.restart_alt_rounded))
                            ],
                          )
                        ],
                      ),
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
