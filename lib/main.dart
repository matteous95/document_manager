import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:document_manager/simple_bloc_delegate.dart';

import 'package:document_manager/src/app/app.dart';


void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    App()
  );
}
