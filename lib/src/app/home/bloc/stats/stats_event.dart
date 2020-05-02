import 'package:equatable/equatable.dart';

import 'package:document_manager/src/app/home/models/models.dart';


abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  final List<Azienda> aziende;

  const UpdateStats(this.aziende);

  @override
  List<Object> get props => [aziende];

  @override
  String toString() => 'UpdateStats { aziende: $aziende }';
}
