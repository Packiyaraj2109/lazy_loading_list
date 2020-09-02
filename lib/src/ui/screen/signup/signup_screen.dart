import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazy_loading_list/src/assets/app_colors.dart';
import 'package:lazy_loading_list/src/assets/app_images.dart';
import 'package:lazy_loading_list/src/data/constants/app_text_constant.dart';
import 'package:lazy_loading_list/src/data/constants/storage_constants.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _passConfirmController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBackgroundColor,
      body: _buildBody(),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _builldLogoSection(),
            _buildInputSection(),
          ],
        ),
      ),
    );
  }

  Expanded _builldLogoSection() {
    return Expanded(
      flex: 2,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius:
              new BorderRadius.only(bottomLeft: new Radius.circular(120)),
          gradient: AppColors.gradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(80),
              ),
              child:ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child:AppImages.appLogo(height: 80, width: 80),
                ),
            ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  AppTextConstant.REGISTER,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildInputSection() {
    return Expanded(
      flex: 3,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 8),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 8),
              child: TextField(
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                controller: _userController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: AppTextConstant.USERNAME,
                  fillColor:  AppColors.borderColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide(color:  AppColors.borderColor, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color:  AppColors.borderColor)),
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(bottom: 10.0, left: 20.0, right: 10.0),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 8),
              child: TextField(
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                obscureText: true,
                controller: _passController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  hintText: AppTextConstant.PASSWORD,
                  fillColor:  AppColors.borderColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide(color:  AppColors.borderColor, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color:  AppColors.borderColor)),
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(bottom: 10.0, left: 20.0, right: 10.0),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 8),
              child: TextField(
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                obscureText: true,
                controller: _passConfirmController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.security),
                  hintText: AppTextConstant.Confirm+" "+AppTextConstant.PASSWORD,
                  fillColor:  AppColors.borderColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide: BorderSide(color:  AppColors.borderColor, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color:  AppColors.borderColor)),
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(bottom: 10.0, left: 20.0, right: 10.0),
                ),
              ),
            ),
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 24.0),
              height: 50.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0),
                  onPressed: _signupButtonPressed,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      gradient: AppColors.buttongradient,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppTextConstant.REGISTER,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(AppTextConstant.AlreadyHaveAccount,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('signin');
                        },
                        child: Text(
                          ("    ${AppTextConstant.LOGIN}"),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _signupButtonPressed() async {
    String user = _userController.text;
    String pass = _passController.text;
    String passconfirm = _passConfirmController.text;
    List userList = List();
    if (user.length < 5) {
      _showScaffold("Enter user Name With 6 Characters long");
    } else if (pass.length < 5) {
      _showScaffold("Enter Password With 6 Characters long");
    } else if (pass != passconfirm) {
      _showScaffold("Password Not Matching");
    } else {
      String loginData=await StorageConst().storageread('listUsers');
      Map currentUserData = {'user': user, 'pass': pass};
      if (loginData != null) {
        userList = json.decode(loginData);
        int index = userList.indexWhere((element) => element['user'] == user);
        if (index != -1) {
          _showScaffold("user :  $user is already Taken");
        } else {
          userList.add(currentUserData);
          await StorageConst().storagewrite('listUsers', userList);
          Navigator.of(context).pushNamed('login');
        }
      } else {
        userList.add(currentUserData);
        await StorageConst().storagewrite('listUsers', userList);
        Navigator.of(context).pushNamed('login');
      }
    }
  }

  _showScaffold(String message) {
    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: new Duration(seconds: 1),
        action: SnackBarAction(
          label: AppTextConstant.SnackBarDismiss,
          textColor: Colors.blue,
          onPressed: () {
            _scaffoldKey.currentState.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
