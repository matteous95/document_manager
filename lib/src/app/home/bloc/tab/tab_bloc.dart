import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:document_manager/src/app/home/bloc/tab/tab.dart';
import 'package:document_manager/src/app/home/models/models.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  bool isSearching = false;

  @override
  AppTab get initialState => AppTab.aziende;

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is UpdateTab) {
      yield event.tab;
    } 
  }
}
