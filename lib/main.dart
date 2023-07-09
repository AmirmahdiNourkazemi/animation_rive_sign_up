import 'dart:ui';

import 'package:animation_flutter/componenet/AnimatedBtn.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'componenet/showCustomDialog.dart';

void main() {
  runApp(MaterialApp(home: const OnbodingScreen()));
}





class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({super.key});

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Positioned(
          //   width: MediaQuery.of(context).size.width * 1.7,
          //   left: 100,
          //   bottom: 100,
          //   child: Image.asset(
          //     "assets/Backgrounds/Spline.png",
          //   ),
          // ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/rive/align.riv",
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                   const SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          Text(
                            "Amirfluts using Rive package",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w700,
                            color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            "Sign up for free now",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.2,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                              () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            showCustomDialog(
                              context,
                              onValue: (_) {
                                setState(() {
                                  isShowSignInDialog = false;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}