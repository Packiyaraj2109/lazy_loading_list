import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_loading_list/src/bloc/home/home_bloc.dart';
import 'package:lazy_loading_list/src/models/home/home_response_model.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data> _usersdata = [];
  int count;
  HomeBloc _homebloc;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        _homebloc = BlocProvider.of<HomeBloc>(context);
        _homebloc.add(
          UserfetchEvent(count.toString()),
        );
      },
    );
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          // fetchsecondusers();
        }
      });
  }

  test() {
    print("sds");
    count=1;
    _homebloc.add(
      UserfetchEvent(count.toString()),
    );
  }

  // Future<void> fetchUsers() async {
  //   count = 1;
  //   HomeResponseModel _users =
  //       await HomeRepository().fetchusers(count.toString());
  //   setState(() {
  //     _users = _users;
  //     _usersdata = _users.data;
  //   });
  // }

  // Future<void> fetchsecondusers() async {
  //   count = count + 1;
  //   print("List count $count");

  //   HomeResponseModel _users =
  //       await HomeRepository().fetchusers(count.toString());
  //   if (_users.data.isNotEmpty) {
  //     setState(() {
  //       _users = _users;
  //       _usersdata = _usersdata + _users.data;
  //     });
  //   } else {
  //     count = count - 1;
  //   }
  // }

  Widget _buildList() {
    return _usersdata.length != 0
        ? RefreshIndicator(
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
                        title:
                            Text(userdata.firstName + " " + userdata.lastName),
                        subtitle: Text(userdata.email),
                      ),
                    ],
                  ),
                );
              },
            ),
            onRefresh: () => test(),
          )
        : Center(child: CircularProgressIndicator());
  }

  // Future<void> _getData() async {
  //   setState(() {
  //     fetchUsers();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User List'),
        ),
        body: Container(
          child: BlocBuilder<HomeBloc, HomeState>(
              condition: (HomeState previous, HomeState current) {
            return current is UserfetchState;
          }, builder: (context, state) {
            if (state is UserfetchState && state.usersdata.isNotEmpty) {
              _usersdata = state.usersdata;
              return _buildList();
            }
          }),
        ));
  }
}