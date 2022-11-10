import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialx/utils/constant.dart';

import '../pages/home_page.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  Box? box = Hive.box("data");
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Constant.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ListView(
                    children: [
                      Text(
                        "Signin to your \nAccount",
                        style: TextStyle(
                          color: Constant.appColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          validator: (s) {
                            if (s!.isEmpty) return 'Email is required';
                            return null;
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Email",
                            labelStyle: TextStyle(
                              color: Constant.black,
                              fontWeight: FontWeight.w600,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: "johndoe@gmail.com",
                            suffixIcon: Icon(
                              Icons.email,
                              color: Constant.appColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          controller: password,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (s) {
                            if (s!.isEmpty) return 'Password is required';
                            return null;
                          },
                          decoration: InputDecoration(
                            alignLabelWithHint: false,
                            labelText: "Password",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                              color: Constant.black,
                              fontWeight: FontWeight.w600,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: "password",
                            suffixIcon: Icon(
                              Icons.lock,
                              color: Constant.appColor,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            child: Text(
                              "Forgot Password",
                              style: TextStyle(
                                color: Constant.appColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            "Login With",
                            style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Route route = MaterialPageRoute(
                                        builder: (context) => const HomePage());
                                    Navigator.push(context, route);
                                  },
                                  icon: Image.asset(
                                    "assets/images/google.png",
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Route route = MaterialPageRoute(
                                        builder: (context) => const HomePage());
                                    Navigator.push(context, route);
                                  },
                                  icon: Image.asset(
                                    "assets/images/facebook.png",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(TextSpan(
                              text: "Don't have an Account ? ",
                              children: [
                                TextSpan(
                                    text: " Register Now",
                                    style: TextStyle(
                                        color: Constant.appColor,
                                        fontWeight: FontWeight.w600))
                              ]))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                color: Constant.appColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Center(
              child: MaterialButton(
                splashColor: Colors.white,
                minWidth: double.maxFinite,
                onPressed: () async {
                  if (email.text.isEmpty) {
                    toasty(context, "please enter email");
                  } else {
                    if (password.text.isEmpty) {
                      toasty(context, "please enter password");
                    } else {
                      if (email.text != "user@gmail.com" &&
                          password.text != "admin") {
                        toasty(context, "enter the correct credential");
                      } else {
                        await box!.put("login", true);
                        Route route = MaterialPageRoute(
                            builder: (context) => const HomePage());
                        Navigator.push(context, route);
                      }
                    }
                  }
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Constant.white,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
