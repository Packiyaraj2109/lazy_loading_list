import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazy_loading_list/src/assets/app_colors.dart';
import 'package:lazy_loading_list/src/assets/app_images.dart';
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
  final _storage = FlutterSecureStorage();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
          child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.appBackgroundColor,
        body: _buildBody(context),
      ),
    );
  }

  SingleChildScrollView _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildLogo(),
            _buildSignup(context),
          ],
        ),
      ),
    );
  }

  Expanded _buildSignup(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, left: 24, right: 24, top: 8),
              child: TextField(
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                controller: _userNameController,
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: AppTextConstant.USERNAME,
                  fillColor: AppColors.borderColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide:
                        BorderSide(color: AppColors.borderColor, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color: AppColors.borderColor)),
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(bottom: 10.0, left: 20.0, right: 10.0),
                  // errorText: _validate ? 'Value Can\'t Be Empty' : null,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16, left: 24, right: 24, top: 16),
              child: TextField(
                inputFormatters: [
                  new WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),
                ],
                controller: _passwordController,
                cursorColor: Colors.grey,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  hintText: AppTextConstant.PASSWORD,
                  fillColor: AppColors.borderColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(36),
                    borderSide:
                        BorderSide(color: AppColors.borderColor, width: 0.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(color: AppColors.borderColor)),
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
                padding: const EdgeInsets.only(top: 8),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0),
                  onPressed: _signinButton,
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      gradient: AppColors.buttongradient,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppTextConstant.LOGIN,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 8, left: 24, right: 24, top: 40),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(AppTextConstant.DontHaveAccount,
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 13,
                            fontWeight: FontWeight.bold)),
                    Center(
                      child: InkWell(
                        onTap: _signupButton,
                        child: Text(
                          ("    ${AppTextConstant.REGISTER}"),
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded _buildLogo() {
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
              padding: const EdgeInsets.only(top:16.0),
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
                  (AppTextConstant.LOGIN),
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   Future<bool> _onWillPop() async {
   SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  _signinButton() async {
    {
      String userName = _userNameController.text;
      String password = _passwordController.text;
      String loginData = await StorageConst().storageread('listUsers');

      if (userName == '') {
        _showScaffold(AppTextConstant.EnterUsername);
      } else if (password == '') {
        _showScaffold(AppTextConstant.EnterPassword);
      } else if (loginData != null) {
        List decodeUserData = json.decode(loginData);
        int index = decodeUserData.indexWhere((element) =>
            element['user'] == userName && element['pass'] == password);

        if (index != -1) {
          _storage.write(key: 'Loggeduser', value: userName);
          Navigator.of(context)
              .pushNamed(ScreenRoutes.HOMEPAGE, arguments: userName);
          _userNameController.clear();
          _passwordController.clear();
        } else {
          _showScaffold(AppTextConstant.UserNameIncorrect);
        }
      } else {
        _showScaffold(AppTextConstant.UserNotCreated);
      }
    }
  }

  _signupButton() {
    Navigator.of(context).pushNamed(ScreenRoutes.SIGNUP);
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
