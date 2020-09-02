import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazy_loading_list/src/assets/app_colors.dart';
import 'package:lazy_loading_list/src/data/constants/app_text_constant.dart';
import 'package:lazy_loading_list/src/data/constants/screen_routes.dart';
import 'package:lazy_loading_list/src/data/constants/storage_constants.dart';

class Signin extends StatefulWidget {
  Signin({Key key}) : super(key: key);
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool passwordVisible = true;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: null,
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
                          color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(24, 8, 24, 8),
                  width: double.infinity,
                  height: 400,
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
                        AppTextConstant.LOGIN,
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
                        controller: _userNameController,
                        decoration: InputDecoration(
                          labelText: AppTextConstant.USERNAME,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.bordercolor),
                          ),
                        ),
                      ),
                      TextField(
                        obscureText: passwordVisible,
                        inputFormatters: [
                          new WhitelistingTextInputFormatter(
                              RegExp("[a-zA-Z0-9]"))
                        ],
                        controller: _passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: AppColors.bordercolor),
                          ),
                          labelText: AppTextConstant.PASSWORD,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _signinButton(),
                        child: Container(
                          height: 50.0,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            gradient: AppColors.buttongradient,
                          ),
                          child: Center(
                            child: Text(
                              AppTextConstant.LOGIN,
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
                            Text(AppTextConstant.DontHaveAccount,
                                style: TextStyle(
                                    color: AppColors.hintcolor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            GestureDetector(
                              onTap: () => _signupButton(),
                              child: Text(
                                ('  ${AppTextConstant.REGISTER}'),
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

  _signinButton() async {
    {
      String userName = _userNameController.text;
      String password = _passwordController.text;
      String loginData = await StorageConst().storageread('listUsers');

      if (userName == '') {
        _showScaffold('Enter Username');
      } else if (password == '') {
        _showScaffold('Enter Password');
      } else if (loginData != null) {
        List decodeUserData = json.decode(loginData);
        int index = decodeUserData.indexWhere((element) =>
            element['user'] == userName && element['pass'] == password);
        if (index != -1) {
          Navigator.of(context).pushReplacementNamed(ScreenRoutes.HOMEPAGE);
          _userNameController.clear();
          _passwordController.clear();
        } else {
          _showScaffold('User Name & Password is incorrect');
        }
      } else {
        _showScaffold('Users Not yet created');
      }
    }
  }

  _signupButton() {
    Navigator.of(context).pushReplacementNamed(ScreenRoutes.SIGNUP);
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
