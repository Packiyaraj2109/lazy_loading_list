import 'dart:async';

import 'package:lazy_loading_list/src/data/repository/home/home_repository.dart';
import 'package:lazy_loading_list/src/models/home/home_response_model.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitState();
  int count = 0;
  bool _isloading = false;
  UserfetchState userfetchstate = UserfetchState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is UserfetchEvent) {
      if (_isloading == false) {
        count = (event.type == 'refresh') ? 1 : count + 1;
        _isloading = true;
        HomeResponseModel userList =
            await HomeRepository().fetchusers(count.toString());
        _isloading = false;
        if (userList.data.isNotEmpty) {
          List<Data> userdata = (count == 1) ? [] : userfetchstate.usersdata;
          userdata = userdata + userList.data;
          yield HomeInitState();
          yield userfetchstate..usersdata = userdata;
        } else {
          count -= 1;
        }
      }
    }
  }
}
