part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class UserfetchEvent extends HomeEvent {
  String count;
  UserfetchEvent(this.count);
}