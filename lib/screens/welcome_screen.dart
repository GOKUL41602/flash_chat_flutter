import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_flutter/constants.dart';
import 'package:flash_chat_flutter/screens/register_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);

    animation =
        ColorTween(begin: Colors.purple, end: Colors.red).animate(controller);

    controller.forward();
    animation.addStatusListener((status) {});
    controller.addStatusListener((status) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              textBaseline: TextBaseline.ideographic,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 60.0,
                      child: Image.asset("images/flash.png"),
                    ),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Expanded(
                    flex: 3,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "Flash Chat",
                          speed: const Duration(milliseconds: 300),
                          textStyle: TextStyle(
                              fontSize: 50.0,
                              color: animation.value,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ))
              ],
            ),
            sizedBox(70.0),
            actionButtons("Login", () {
              Navigator.pushNamed(context, LoginScreen.id);
            }, Colors.lightBlue, MediaQuery.of(context).size.width - 80),
            sizedBox(40.0),
            actionButtons("Register", () {
              Navigator.pushNamed(context, RegisterScreen.id);
            }, Colors.blue.shade900, MediaQuery.of(context).size.width - 80)
          ],
        ),
      ),
    );
  }
}
