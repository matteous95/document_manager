import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:document_manager/src/app/home/bloc/bloc.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StreamSubscription _aziendeSubscription;

  StatsBloc({AziendeBloc aziendeBloc}) : assert(aziendeBloc != null) {
    _aziendeSubscription = aziendeBloc.listen((state) {
      if (state is AziendeLoaded) {
        add(UpdateStats(state.aziende));
      }
    });
  }

  @override
  StatsState get initialState => StatsLoading();

  @override
  Stream<StatsState> mapEventToState(StatsEvent event) async* {
    if (event is UpdateStats) {
      int numActive =
          event.aziende.where((todo) => true).toList().length;
      int numCompleted =
          event.aziende.where((todo) => true).toList().length;
      yield StatsLoaded(numActive, numCompleted);
    }
  }

  @override
  Future<void> close() {
    _aziendeSubscription?.cancel();
    return super.close();
  }
}
