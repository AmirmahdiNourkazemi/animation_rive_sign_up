import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rive/rive.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;

  late SMITrigger confetti;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void singIn(BuildContext context) {
    // confetti.fire();
    setState(() {
      isShowConfetti = true;
      isShowLoading = true;
    });
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (_formKey.currentState!.validate()) {
          success.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                isShowLoading = false;
              });
              confetti.fire();
              // Navigate & hide confetti
              Future.delayed(const Duration(seconds: 1), () {
                // Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const EntryPoint(),
                //   ),
                // );
              });
            },
          );
        } else {
          error.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                isShowLoading = false;
              });
              reset.fire();
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Email",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        // prefixIcon: Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8),
                        //   child: SvgPicture.asset("assets/icons/email.svg"),
                        // ),
                        ),
                  ),
                ),
                const Text(
                  "Password",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: TextFormField(
                    controller: passController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        // prefixIcon: Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 8),
                        //   child: SvgPicture.asset("assets/icons/password.svg"),
                        // ),
                        ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  child: ElevatedButton(
                    onPressed: () {
                      fast();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 53, 47, 48),
                      minimumSize: const Size(double.infinity, 56),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Sign In",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 68,
                      width: 84,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff2F2F2F).withOpacity(0.2),
                        ),
                        color: Color(0xffF2F2F2).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/google.png',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      height: 68,
                      width: 84,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff2F2F2F).withOpacity(0.2),
                        ),
                        color: Color(0xffF2F2F2).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/apple.png',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      height: 68,
                      width: 84,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff2F2F2F).withOpacity(0.2),
                        ),
                        color: Color(0xffF2F2F2).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/facebook.png',
                        ),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 58),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Log in',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: isShowLoading,
            child: const CustomPositioned(
              scale: 1.5,
              child: RiveAnimation.asset(
                'assets/rive/correct1.riv',
                fit: BoxFit.cover,
                //onInit: _onCheckRiveInit,
              ),
            ),
          ),
          Visibility(
            visible: isShowConfetti,
            child: const CustomPositioned(
              scale: 6,
              child: RiveAnimation.asset(
                "assets/rive/wrong1.riv",
                //onInit: _onConfettiRiveInit,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  void fast() {
    if (emailController.text.isEmpty && passController.text.isEmpty) {
      setState(() {
        isShowConfetti = true;
      });
    } else if (emailController.text.isEmpty && passController.text.isNotEmpty) {
      setState(() {
        isShowConfetti = true;
      });
    } else if (emailController.text.isNotEmpty && passController.text.isEmpty) {
      setState(() {
        isShowConfetti = true;
      });
    } else {
      setState(() {
        isShowLoading = true;
      });
    }
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
