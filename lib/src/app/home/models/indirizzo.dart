import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Indirizzo {
   String cap;
   String citta;
   String civico;
   String nazione;
   String provincia;
   String via;

  Indirizzo(
      {this.cap,
      this.citta,
      this.civico,
      this.nazione,
      this.provincia,
      this.via});

  Indirizzo copyWith(
      {String cap,
      String citta,
      String civico,
      String nazione,
      String provincia,
      String via}) {
    return Indirizzo(
      cap: cap ?? this.cap,
      citta: citta ?? this.citta,
      civico: civico ?? this.civico,
      nazione: nazione ?? this.nazione,
      provincia: provincia ?? this.provincia,
      via: via ?? this.via,
    );
  }
@override
  int get hashCode =>
      cap.hashCode ^
      citta.hashCode ^
      civico.hashCode ^
      nazione.hashCode ^
      provincia.hashCode ^
      via.hashCode;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Indirizzo &&
          runtimeType == other.runtimeType &&
          cap == other.cap &&
          citta == other.citta &&
          civico == other.civico &&
          nazione == other.nazione &&
          provincia == other.provincia &&
          via == other.via;

  @override
  String toString() {
    return 'Indirizzo {cap: $cap, citta: $citta, civico: $civico, nazione: $nazione, provincia: $provincia, via: $via}';
  }

  IndirizzoEntity toEntity() {
    return IndirizzoEntity(
      cap,
      citta,
      civico,
      nazione,
      provincia,
      via);
  }

  static Indirizzo fromEntity(IndirizzoEntity entity) {
    return Indirizzo(
      cap: entity.cap,
      citta: entity.citta,
      civico: entity.civico,
      nazione: entity.nazione,
      provincia: entity.provincia,
      via: entity.via,
    );
  }

}


class IndirizzoEntity extends Equatable {
  final String cap;
  final String citta;
  final String civico;
  final String nazione;
  final String provincia;
  final String via;


  const IndirizzoEntity(
      this.cap,
      this.citta,
      this.civico,
      this.nazione,
      this.provincia,
      this.via);

  Map<String, Object> toJson() {
    return {
      "cap": cap,
      "citta": citta,
      "civico": civico,
      "nazione": nazione,
      "provincia": provincia,
      "via": via,
    };
  }

  @override
  List<Object> get props => [
        cap,
        citta,
        civico,
        nazione,
        provincia,
        via
      ];

  @override
  String toString() {
    return 'Indirizzo {cap: $cap, citta: $citta, civico: $civico, nazione: $nazione, provincia: $provincia, via: $via}';
  }

  static IndirizzoEntity fromJson(Map<String, Object> json) {
    return IndirizzoEntity(
        json["cap"] as String,
        json["citta"] as String,
        json["civico"] as String,
        json["nazione"] as String,
        json["provincia"] as String,
        json["via"] as String);
  }

  static IndirizzoEntity fromSnapshot(DocumentSnapshot snap) {
    return IndirizzoEntity(
      snap.data['cap'],
      snap.data['citta'],
      snap.data['civico'],
      snap.data['nazione'],
      snap.data['provincia'],
      snap.data['via'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "cap": cap,
      "citta": citta,
      "civico": civico,
      "nazione": nazione,
      "provincia": provincia,
      "via": via,
    };
  }
}

