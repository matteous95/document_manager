import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Telefono {
   String nota;
   String prefisso;
   String numero;

  Telefono(
      {this.nota,
      this.prefisso,
      this.numero});

  Telefono copyWith(
      {String nota,
      String prefisso,
      String numero}) {
    return Telefono(
      nota: nota ?? this.nota,
      prefisso: prefisso ?? this.numero,
      numero: numero ?? this.numero
    );
  }
@override
  int get hashCode =>
      nota.hashCode ^
      prefisso.hashCode ^
      numero.hashCode ;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Telefono &&
          runtimeType == other.runtimeType &&
          nota == other.nota &&
          prefisso == other.prefisso &&
          numero == other.numero;

  @override
  String toString() {
    return 'Telefono {nota: $nota, prefisso: $prefisso, numero: $numero}';
  }

  TelefonoEntity toEntity() {
    return TelefonoEntity(
      nota,
      prefisso,
      numero);
  }

  static Telefono fromEntity(TelefonoEntity entity) {
    return Telefono(
      nota: entity.nota,
      prefisso: entity.prefisso,
      numero: entity.numero,
    );
  }

}


class TelefonoEntity extends Equatable {
  final String nota;
  final String prefisso;
  final String numero;



  const TelefonoEntity(
      this.nota,
      this.prefisso,
      this.numero);

  Map<String, Object> toJson() {
    return {
      "nota": nota,
      "prefisso": prefisso,
      "numero": numero,
    };
  }

  @override
  List<Object> get props => [
        nota,
        prefisso,
        numero
      ];

  @override
  String toString() {
    return 'Telefono {nota: $nota, prefisso: $prefisso, numero: $numero}';
  }

  static TelefonoEntity fromJson(Map<String, Object> json) {
    return TelefonoEntity(
        json["nota"] as String,
        json["prefisso"] as String,
        json["numero"] as String);
  }

  static TelefonoEntity fromSnapshot(DocumentSnapshot snap) {
    return TelefonoEntity(
      snap.data['nota'],
      snap.data['prefisso'],
      snap.data['numero'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "nota": nota,
      "prefisso": prefisso,
      "numero": numero,
    };
  }
}

