import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialx/tabs/login_tab.dart';
import 'package:socialx/tabs/signup_tab.dart';

import '../utils/constant.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(Constant.appColor,
        systemNavigationBarColor: Constant.black);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 255, 17, 0),
          title: const Text.rich(
            TextSpan(
              text: "Social",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.w300, letterSpacing: 2),
              children: [
                TextSpan(
                    text: "X",
                    style:
                        TextStyle(fontSize: 33, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(color: Constant.appColor, spreadRadius: 2)
                ],
              ),
              child: TabBar(
                unselectedLabelColor: const Color.fromARGB(255, 44, 41, 41),
                indicator: BoxDecoration(
                  color: Constant.appColor,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                labelColor: Colors.white,
                tabs: const [
                  Tab(
                    text: "LOGIN",
                  ),
                  Tab(
                    text: "SIGN UP",
                  ),
                ],
                controller: tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                // ignore: sort_child_properties_last
                children: [
                  const LoginTab(),
                  SignupTab(),
                ],
                controller: tabController,
              ),
            )
          ],
        ),
      ),
    );
  }
}
