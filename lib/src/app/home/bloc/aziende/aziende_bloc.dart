import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:document_manager/src/app/authentication/bloc/bloc.dart';
import 'package:document_manager/src/app/authentication/models/user.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'aziende.dart';
import 'package:document_manager/src/app/home/repo/repository.dart';

class AziendeBloc extends Bloc<AziendeEvent, AziendeState> {
  final AziendeRepository _aziendeRepository;
  StreamSubscription _aziendeSubscription;
  StreamSubscription _authenticationSubscription;
  User _user;
  bool _hasReachedMax;
  String searchText = '';

  AziendeBloc(
      {@required AziendeRepository aziendeRepository,
      AuthenticationBloc authenticationBloc})
      : assert(aziendeRepository != null && authenticationBloc != null),
        _aziendeRepository = aziendeRepository {
    _authenticationSubscription = authenticationBloc.listen((state) {
      if (state is Authenticated) {
        _user = state.user;
        add(LoadAziende(1, null));
      }
    });
  }

  @override
  AziendeState get initialState => AziendeLoading();

  @override
  Stream<AziendeState> mapEventToState(AziendeEvent event) async* {
    if (event is LoadAziende) {
      yield* _mapLoadAziendeToState(event);
    } else if (event is AddAzienda) {
      yield* _mapAddAziendaToState(event);
    } else if (event is UpdateAzienda) {
      yield* _mapUpdateAziendaToState(event);
    } else if (event is DeleteAzienda) {
      yield* _mapDeleteAziendaToState(event);
    } else if (event is AziendeUpdated) {
      yield* _mapAziendeUpdateToState(event);
    } else if (event is AziendeSearchTextEdit) {
      yield* _mapSearchAziendeText(event);
    }
  }

  Stream<AziendeState> _mapLoadAziendeToState(LoadAziende event) async* {
    try {
      final currAziendeLenght = event.aziende != null ? event.aziende.length : 0 ;
      _aziendeSubscription?.cancel();
      _aziendeSubscription = _aziendeRepository
          .aziende(_user, event.incremetPage, event.aziende, searchText)
          .listen((aziende) {
        if (event.aziende != null && (currAziendeLenght == aziende.length)) {
          _hasReachedMax = true;
        } else {
          _hasReachedMax = false;
        }
        if (aziende.length < 10) {
          _hasReachedMax = true;
        }
        add(AziendeUpdated(aziende));
      } //=> add(AziendeUpdated(aziende)),
              );
    } catch (error) {
      yield AziendeNotLoaded();
    }
  }

  Stream<AziendeState> _mapAddAziendaToState(AddAzienda event) async* {
    _aziendeRepository.addNewAzienda(event.azienda);
  }

  Stream<AziendeState> _mapUpdateAziendaToState(UpdateAzienda event) async* {
    _aziendeRepository.updateAzienda(event.updatedAzienda);
  }

  Stream<AziendeState> _mapDeleteAziendaToState(DeleteAzienda event) async* {
    _aziendeRepository.deleteAzienda(event.azienda);
  }

  Stream<AziendeState> _mapAziendeUpdateToState(AziendeUpdated event) async* {
    yield AziendeLoaded(event.aziende, _hasReachedMax);
  }

  Stream<AziendeState> _mapSearchAziendeText(
      AziendeSearchTextEdit event) async* {
    searchText = event.searchText;
  }

  @override
  Future<void> close() {
    _aziendeSubscription?.cancel();
    _authenticationSubscription?.cancel();
    return super.close();
  }
}
