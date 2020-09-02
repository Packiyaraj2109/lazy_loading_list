import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_loading_list/src/bloc/home/home_bloc.dart';
import 'package:lazy_loading_list/src/data/constants/app_text_constant.dart';
import 'package:lazy_loading_list/src/data/constants/screen_routes.dart';
import 'package:lazy_loading_list/src/models/home/home_response_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data> _usersdata = [];

  HomeBloc _homebloc;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _homebloc = BlocProvider.of<HomeBloc>(context);
        _homebloc.add(
          UserfetchEvent('fetch'),
        );
      },
    );
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          fetchUsers();
        }
      });
  }

  Future<void> pullrefresh() async {
    _homebloc.add(
      UserfetchEvent('refresh'),
    );
  }

  Future<void> fetchUsers() async {
    _homebloc.add(
      UserfetchEvent('fetch'),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(8),
        itemCount: _usersdata.length,
        itemBuilder: (BuildContext context, int index) {
          Data userdata = _usersdata[index];
          return Container(
            height: 100,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(userdata.avatar)),
                  title: Text(userdata.firstName + " " + userdata.lastName),
                  subtitle: Text(userdata.email),
                ),
              ],
            ),
          );
        },
      ),
      onRefresh: () => pullrefresh(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=> null,
          child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: RotatedBox(
            quarterTurns: 2,
            child: GestureDetector(
              child: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onTap: () => logout(),
            ),
          ),
          title: Text(AppTextConstant.TITLE),
          centerTitle: true,
        ),
        body: Container(
          child: BlocBuilder<HomeBloc, HomeState>(
            condition: (HomeState previous, HomeState current) {
              return current is UserfetchState;
            },
            builder: (context, state) {
              if (state is UserfetchState && state.usersdata.isNotEmpty) {
                _usersdata = state.usersdata;
                return _buildList();
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> logout() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppTextConstant.LOGOUT),
          content: Text(AppTextConstant.ExitMsg),
          actions: <Widget>[
            FlatButton(
              child: Text(
                AppTextConstant.CONFIRM,
              ),
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    ScreenRoutes.SIGNIN, (route) => false);
              },
            ),
            FlatButton(
              child: Text(
                AppTextConstant.CANCEL,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}
