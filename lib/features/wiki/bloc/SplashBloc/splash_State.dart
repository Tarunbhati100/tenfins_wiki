// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class InitialState extends SplashState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends SplashState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends SplashState {
  @override
  List<Object?> get props => [];
}
