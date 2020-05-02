import 'package:equatable/equatable.dart';

import 'package:document_manager/src/app/home/models/models.dart';


abstract class AziendeEvent extends Equatable {
  const AziendeEvent();

    @override
  List<Object> get props => [];
}


class LoadAziende extends AziendeEvent {
 final int incremetPage;
 final List<Azienda> aziende;

const LoadAziende(this.incremetPage,this.aziende);

  @override
  String toString() => 'LoadAziende';
}

class AddAzienda extends AziendeEvent {
  final Azienda azienda;

  const AddAzienda(this.azienda);

  @override
  List<Object> get props => [azienda];

  @override
  String toString() => 'AddAzienda { azienda: $azienda }';
}

class UpdateAzienda extends AziendeEvent {
  final Azienda updatedAzienda;

  const UpdateAzienda(this.updatedAzienda);

  @override
  List<Object> get props => [updatedAzienda];

  @override
  String toString() => 'UpdateAzienda { updatedAzienda: $updatedAzienda }';
}

class DeleteAzienda extends AziendeEvent {
  final Azienda azienda;

  const DeleteAzienda(this.azienda);

  @override
  List<Object> get props => [azienda];

  @override
  String toString() => 'DeleteAzienda { azienda: $azienda }';
}


class AziendeUpdated extends AziendeEvent {
  final List<Azienda> aziende;

  const AziendeUpdated(this.aziende);

  @override
  List<Object> get props => [aziende];
}

class AziendeSearchTextEdit extends AziendeEvent {
  final String searchText;

  const AziendeSearchTextEdit(this.searchText);

  @override
  String toString() => 'SearchTextEdit { search: $searchText }';
}