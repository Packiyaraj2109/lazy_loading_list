part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitState extends HomeState {}

class UserfetchState extends HomeState {

  List<Data> usersdata;
  UserfetchState({this.usersdata});
}