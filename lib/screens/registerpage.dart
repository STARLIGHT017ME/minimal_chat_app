import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/reusables/customTF.dart';
import 'package:minimal_chat_app/reusables/custombutton.dart';
import 'package:minimal_chat_app/reusables/glassbox.dart';

class Registerpage extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();
  final void Function()? ontap;

  Registerpage({super.key, this.ontap});

  void register(BuildContext context) async {
    final authservice = await AuthService();
    if (passwordcontroller.text == confirmpasswordcontroller.text) {
      try {
        authservice.signUpWithEmailPassword(
            emailcontroller.text, passwordcontroller.text, context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
            backgroundColor: Colors.red[900],
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password Don't Match"),
          backgroundColor: Colors.red[900],
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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
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
                          child: Customtf(
                              text: const Text("confirm password"),
                              controller: confirmpasswordcontroller,
                              hinttext: "confirm password",
                              keyboardType: TextInputType.visiblePassword,
                              obsecuretext: true),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Custombutton(
                            text: "Register",
                            onTap: () => register(context),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Have an account ",
                              style: TextStyle(color: Colors.black),
                            ),
                            GestureDetector(
                              onTap: ontap,
                              child: Text(
                                "Sign in here",
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
              ),
              Expanded(flex: 1, child: Container())
            ],
          )
        ],
      ),
    );
  }
}
