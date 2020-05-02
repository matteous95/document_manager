import 'package:equatable/equatable.dart';

import 'package:document_manager/src/app/home/models/models.dart';

abstract class AziendeState extends Equatable {
  const AziendeState();

  @override
  List<Object> get props => [];
}

class AziendeLoading extends AziendeState {}

class AziendeLoaded extends AziendeState {
  final List<Azienda> aziende;
  final bool hasReachedMax;

  const AziendeLoaded([
    this.aziende = const [],
    this.hasReachedMax,
  ]);

  AziendeLoaded copyWith({
    List<Azienda> aziende,
    bool hasReachedMax,
  }) {
    return AziendeLoaded(
      aziende ?? this.aziende,
      hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [aziende, hasReachedMax];

  @override
  String toString() =>
      'AziendeLoaded { aziende: $aziende, hasReachedMax: $hasReachedMax  }';
}

class AziendeNotLoaded extends AziendeState {}
