import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazy_loading_list/src/assets/app_colors.dart';
import 'package:lazy_loading_list/src/data/constants/app_text_constant.dart';
import 'package:lazy_loading_list/src/data/constants/screen_routes.dart';
import 'package:lazy_loading_list/src/data/constants/storage_constants.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _passConfirmController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => loginscreen(),
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.gradient,
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Center(
                  child: Text(AppTextConstant.TITLE,
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textcolor)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  width: double.infinity,
                  height: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: AppColors.appBackgroundColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppTextConstant.REGISTER,
                        style: TextStyle(
                            fontSize: 24,
                            color: AppColors.boldtextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        inputFormatters: [
                          new WhitelistingTextInputFormatter(
                              RegExp("[a-zA-Z0-9]"))
                        ],
                        controller: _userController,
                        decoration: InputDecoration(
                          labelText: AppTextConstant.USERNAME,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.bordercolor),
                          ),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        inputFormatters: [
                          new WhitelistingTextInputFormatter(
                              RegExp("[a-zA-Z0-9]"))
                        ],
                        controller: _passController,
                        decoration: InputDecoration(
                          labelText: AppTextConstant.PASSWORD,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.bordercolor),
                          ),
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        inputFormatters: [
                          new WhitelistingTextInputFormatter(
                              RegExp("[a-zA-Z0-9]"))
                        ],
                        controller: _passConfirmController,
                        decoration: InputDecoration(
                          labelText: AppTextConstant.CONFIRMPASSWORD,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.bordercolor),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _signupButton(),
                        child: Container(
                          height: 50.0,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            gradient: AppColors.buttongradient,
                          ),
                          child: Center(
                            child: Text(
                              AppTextConstant.REGISTER,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: AppColors.textcolor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(AppTextConstant.AlreadyHaveAccount,
                                style: TextStyle(
                                    color: AppColors.hintcolor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () => loginscreen(),
                              child: Text(
                                ("  ${AppTextConstant.LOGIN}"),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.boldtextColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  loginscreen() {
    Navigator.of(context).pushReplacementNamed(ScreenRoutes.SIGNIN);
  }

  Future<void> _signupButton() async {
    String user = _userController.text;
    String pass = _passController.text;
    String passconfirm = _passConfirmController.text;
    List userList = List();
    if (user.length < 6) {
      _showScaffold("Enter user Name With 6 Characters long");
    } else if (pass.length < 6) {
      _showScaffold("Enter Password With 6 Characters long");
    } else if (pass != passconfirm) {
      _showScaffold("Password Not Matching");
    } else {
      String loginData = await StorageConst().storageread('listUsers');
      Map currentUserData = {'user': user, 'pass': pass};
      if (loginData != null) {
        userList = json.decode(loginData);
        int index = userList.indexWhere((element) => element['user'] == user);
        if (index != -1) {
          _showScaffold("$user is already Taken");
        } else {
          _adduser(userList, currentUserData);
        }
      } else {
        _adduser(userList, currentUserData);
      }
    }
  }

  Future<void> _adduser(List userList, Map currentUserData) async {
    userList.add(currentUserData);
    await StorageConst().storagewrite('listUsers', userList);
    Navigator.of(context).pushReplacementNamed(ScreenRoutes.SIGNIN);
  }

  _showScaffold(String message) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: new Duration(seconds: 1),
        action: SnackBarAction(
          label: AppTextConstant.SnackBarDismiss,
          textColor: AppColors.boldtextColor,
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
