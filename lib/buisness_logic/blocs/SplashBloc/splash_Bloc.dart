// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenfins_wiki/buisness_logic/blocs/SplashBloc/splash_Event.dart';
import 'package:tenfins_wiki/buisness_logic/blocs/SplashBloc/splash_State.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(super.initialState);

  @override
  SplashState get initialState => InitialState();

  @override
  Stream<SplashState> mapEventToState(
    SplashEvent event,
  ) async* {
    if (event is NavigateToHomeScreenEvent) {
       LoadingState();
      //todo: add some actions like checking the connection etc.
      //I simulate the process with future delayed for 3 second
      await Future.delayed(Duration(seconds: 3));
       LoadedState();
    }
  }
}