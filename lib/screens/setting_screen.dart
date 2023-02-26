import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String inputs = '';

  void goToBackPressed() {
    setState(() {
      Navigator.pop(context, inputs);
    });
  }

  void inputSeconds(String str) {
    setState(() {
      inputs = str;
    });
  }

  void checkFunction() {}

  @override
  void initState() {
    inputs = '1500';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  iconSize: 30,
                  onPressed: goToBackPressed,
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    'TIME',
                    style: TextStyle(
                      fontSize: 80,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 200,
                        child: TextField(
                          style: TextStyle(
                              fontSize: 32, color: Theme.of(context).cardColor),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(hintText: '단위 : 분'),
                          onChanged: inputSeconds,
                        ),
                      ),
                      IconButton(
                        color: Theme.of(context).cardColor,
                        iconSize: 50,
                        onPressed: checkFunction,
                        icon: const Icon(Icons.check_circle_outline),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
