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
  UserfetchState userfetchstate = UserfetchState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is UserfetchEvent) {
      print("block");
      HomeResponseModel userList =
          await HomeRepository().fetchusers(event.count);
      List<Data> userdata = userList.data ?? [];
      yield userfetchstate..usersdata = userdata;
    }
  }
}
