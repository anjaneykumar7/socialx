// ignore_for_file: must_be_immutable

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:socialx/utils/constant.dart';

import '../pages/home_page.dart';

class SignupTab extends StatefulWidget {
  SignupTab({Key? key}) : super(key: key);

  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
  var name = TextEditingController();
  Box? box = Hive.box("data");
  var email = TextEditingController();
  var mobile = TextEditingController();

  var password = TextEditingController();
  bool ischecked = false;

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
                child: Container(
                  margin: const EdgeInsets.all(25.0),
                  child: ListView(
                    children: [
                      Text(
                        "Create an \nAccount",
                        style: TextStyle(
                          color: Constant.appColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: TextFormField(
                          controller: name,
                          keyboardType: TextInputType.name,
                          validator: (s) {
                            if (s!.isEmpty) return 'Name is required';
                            return null;
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: Constant.black,
                              fontWeight: FontWeight.w600,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: "John Doe",
                            suffixIcon: Icon(
                              Icons.person,
                              color: Constant.appColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
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
                        padding: const EdgeInsets.only(top: 5.0),
                        child: TextFormField(
                          controller: mobile,
                          keyboardType: TextInputType.number,
                          validator: (s) {
                            if (s!.isEmpty) return 'Mobile Number is required';
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: CountryPickerDropdown(
                              initialValue: 'IN',
                              itemBuilder: _buildDropdownItem,
                              priorityList: [
                                CountryPickerUtils.getCountryByIsoCode('IN'),
                                CountryPickerUtils.getCountryByIsoCode('US'),
                              ],
                              sortComparator: (Country a, Country b) =>
                                  a.isoCode.compareTo(b.isoCode),
                              onValuePicked: (Country country) {
                                print("${country.name}");
                              },
                            ),
                            alignLabelWithHint: false,
                            labelText: "Mobile Number",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(
                              color: Constant.black,
                              fontWeight: FontWeight.w600,
                            ),
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                            ),
                            hintText: "9875644859",
                            suffixIcon: Icon(
                              Icons.phone,
                              color: Constant.appColor,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
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
                            hintText: "********",
                            suffixIcon: Icon(
                              Icons.lock,
                              color: Constant.appColor,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                              value: ischecked,
                              onChanged: (c) {
                                ischecked = c!;
                                setState(() {});
                              }),
                          const SizedBox(
                            width: 10,
                          ),
                          Text.rich(
                              TextSpan(text: "I agree to with ", children: [
                            TextSpan(
                                onEnter: (f) {},
                                text: " terms and condition",
                                style: TextStyle(
                                    color: Constant.appColor,
                                    fontWeight: FontWeight.w600))
                          ])),
                        ],
                      ),
                      Center(
                        child: Text.rich(TextSpan(
                            text: "Already have an Account ? ",
                            children: [
                              TextSpan(
                                  onEnter: (f) {},
                                  text: " Sign in!",
                                  style: TextStyle(
                                      color: Constant.appColor,
                                      fontWeight: FontWeight.w600))
                            ])),
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
                  if (name.text.isEmpty) {
                    toasty(context, "please enter name");
                  } else {
                    if (email.text.isEmpty) {
                      toasty(context, "please enter email");
                    } else {
                      if (mobile.text.isEmpty) {
                        toasty(context, "please enter mobile number");
                      } else {
                        if (password.text.isEmpty) {
                          toasty(context, "please enter password");
                        } else {
                          if (ischecked) {
                            await box!.put("login", true);
                            Route route = MaterialPageRoute(
                                builder: (context) => const HomePage());
                            Navigator.push(context, route);
                          } else {
                            toasty(context, "please accept term and condition");
                          }
                        }
                      }
                    }
                  }
                },
                child: Text(
                  "SIGNUP",
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

  Widget _buildDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CountryPickerUtils.getDefaultFlagImage(country),
            SizedBox(
              width: 8.0,
            ),
            Text("+${country.phoneCode}(${country.isoCode})"),
          ],
        ),
      );
}
