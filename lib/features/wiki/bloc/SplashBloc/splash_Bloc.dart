// ignore_for_file: prefer_const_constructors, override_on_non_overriding_member, file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenfins_wiki/features/wiki/bloc/SplashBloc/splash_Event.dart';
import 'package:tenfins_wiki/features/wiki/bloc/SplashBloc/splash_State.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc():super(LoadingState()){
    on<NavigateToHomeScreenEvent>((event, emit) {
      emit(LoadingState());
      emit(LoadedState());
    },);
  }
}
