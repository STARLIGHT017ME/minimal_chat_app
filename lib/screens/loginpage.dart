import 'package:flutter/material.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/reusables/customTF.dart';
import 'package:minimal_chat_app/reusables/custombutton.dart';
import 'package:minimal_chat_app/reusables/glassbox.dart';

class Loginpage extends StatelessWidget {
  final void Function()? ontap;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

  Loginpage({super.key, this.ontap});

  void login(BuildContext context) async {
    //Call the auth service and initializing it
    final authService = AuthService();

    //try logining in

    try {
      await authService.signInWithEmailPassword(
          emailcontroller.text, passwordcontroller.text);
    }
    //check for any errors

    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red[
              900], // Optional: Change the background color to indicate error
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            height: double.infinity,
            width: double.infinity,
            "assets/images/image2.jpg",
            fit: BoxFit.cover,
          ),
          Column(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: Glassbox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Customtf(
                            text: const Text("E-mail"),
                            controller: emailcontroller,
                            hinttext: "E-mail",
                            keyboardType: TextInputType.emailAddress,
                            obsecuretext: false),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Customtf(
                            text: const Text("Password"),
                            controller: passwordcontroller,
                            hinttext: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            obsecuretext: true),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Custombutton(
                          text: "Login",
                          onTap: () => login(context),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ",
                            style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: ontap,
                            child: const Text(
                              "Sign up here",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container())
            ],
          )
        ],
      ),
    );
  }
}
