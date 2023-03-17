// ignore_for_file: file_names

import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class NavigateToHomeScreenEvent extends SplashEvent {
  @override
  List<Object?> get props => [];
}
