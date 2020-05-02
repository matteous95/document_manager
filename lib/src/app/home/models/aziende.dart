import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './models.dart';

@immutable
class Azienda {
  final String id;
  final String codiceAteco;
  final DateTime createdAt;
  final DateTime dataVisuraEC;
  final String email;
  final Indirizzo indirizzo;
  final String numeroRea;
  final String partitaIva;
  final String pec;
  final String ragioneSociale;
  final List<Telefono> telefono;
  final String uidUtente;

  Azienda(
      {this.id,
      this.codiceAteco,
      this.createdAt,
      this.dataVisuraEC,
      this.email,
      this.indirizzo,
      this.numeroRea,
      this.partitaIva,
      this.pec,
      this.ragioneSociale,
      this.telefono,
      this.uidUtente});

  Azienda copyWith(
      {String id,
      String codiceAteco,
      DateTime createdAt,
      DateTime dataVisuraEC,
      String email,
      Indirizzo indirizzo,
      String numeroRea,
      String partitaIva,
      String pec,
      String ragioneSociale,
      List<Telefono> telefono,
      String uidUtente}) {
    return Azienda(
      id: id ?? this.id,
      codiceAteco: codiceAteco ?? this.codiceAteco,
      createdAt: createdAt ?? this.createdAt,
      dataVisuraEC: dataVisuraEC ?? this.dataVisuraEC,
      email: email ?? this.email,
      indirizzo: indirizzo ?? this.indirizzo,
      numeroRea: numeroRea ?? this.numeroRea,
      partitaIva: partitaIva ?? this.partitaIva,
      pec: pec ?? this.pec,
      ragioneSociale: ragioneSociale ?? this.ragioneSociale,
      telefono: telefono ?? this.telefono,
      uidUtente: uidUtente ?? this.uidUtente,
    );
  }

  @override
  int get hashCode =>
      id.hashCode ^
      codiceAteco.hashCode ^
      createdAt.hashCode ^
      dataVisuraEC.hashCode ^
      email.hashCode ^
      indirizzo.hashCode ^
      numeroRea.hashCode ^
      partitaIva.hashCode ^
      pec.hashCode ^
      ragioneSociale.hashCode ^
      telefono.hashCode ^
      uidUtente.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Azienda &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          codiceAteco == other.codiceAteco &&
          createdAt == other.createdAt &&
          dataVisuraEC == other.dataVisuraEC &&
          email == other.email &&
          indirizzo == other.indirizzo &&
          numeroRea == other.numeroRea &&
          partitaIva == other.partitaIva &&
          pec == other.pec &&
          ragioneSociale == other.ragioneSociale &&
          telefono == other.telefono &&
          uidUtente == other.uidUtente;

  @override
  String toString() {
    return 'Azienda {id: $id, codiceAteco: $codiceAteco,createdAt: $createdAt, dataVisuraEC: $dataVisuraEC, email: $email, indirizzo: $indirizzo, numeroRea: $numeroRea, partitaIva: $partitaIva, pec: $pec, ragioneSociale: $ragioneSociale, telefono: $telefono, uidUtente: $uidUtente}';
  }

  AziendaEntity toEntity() {
    return AziendaEntity(id, codiceAteco,createdAt, dataVisuraEC, email, indirizzo,
        numeroRea, partitaIva, pec, ragioneSociale, telefono, uidUtente);
  }

  static Azienda fromEntity(AziendaEntity entity) {
    return Azienda(
      id: entity.id,
      codiceAteco: entity.codiceAteco,
      createdAt: entity.createdAt,
      dataVisuraEC: entity.dataVisuraEC,
      email: entity.email,
      indirizzo: entity.indirizzo,
      numeroRea: entity.numeroRea,
      partitaIva: entity.partitaIva,
      pec: entity.pec,
      ragioneSociale: entity.ragioneSociale,
      telefono: entity.telefono,
      uidUtente: entity.uidUtente,
    );
  }
}

class AziendaEntity extends Equatable {
  final String id;
  final String codiceAteco;
  final DateTime createdAt;
  final DateTime dataVisuraEC;
  final String email;
  final Indirizzo indirizzo;
  final String numeroRea;
  final String partitaIva;
  final String pec;
  final String ragioneSociale;
  final List<Telefono> telefono;
  final String uidUtente;

  const AziendaEntity(
      this.id,
      this.codiceAteco,
      this.createdAt,
      this.dataVisuraEC,
      this.email,
      this.indirizzo,
      this.numeroRea,
      this.partitaIva,
      this.pec,
      this.ragioneSociale,
      this.telefono,
      this.uidUtente);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "codice_ateco": codiceAteco,
      "created_at": createdAt,
      "data_visura_evasione_ccia": dataVisuraEC,
      "email": email,
      "indirizzo": indirizzo,
      "numero_rea": numeroRea,
      "partita_iva": partitaIva,
      "pec": pec,
      "ragione_sociale": ragioneSociale,
      "telefono": telefono,
      "uid_utente": uidUtente,
    };
  }

  @override
  List<Object> get props => [
        id,
        codiceAteco,
        createdAt,
        dataVisuraEC,
        email,
        indirizzo,
        numeroRea,
        partitaIva,
        pec,
        ragioneSociale,
        telefono,
        uidUtente
      ];

  @override
  String toString() {
    return 'Azienda {id: $id, codiceAteco: $codiceAteco,createdAt: $createdAt, dataVisuraEC: $dataVisuraEC, email: $email, indirizzo: $indirizzo, numeroRea: $numeroRea, partitaIva: $partitaIva, pec: $pec, ragioneSociale: $ragioneSociale, telefono: $telefono, uidUtente: $uidUtente}';
  }

  static AziendaEntity fromJson(Map<String, Object> json) {
    return AziendaEntity(
        json["id"] as String,
        json["codice_ateco"] as String,
        DateTime.parse(json['created_at']),
        DateTime.parse(json['data_visura_evasione_ccia']),//FunctionDate.processStringToTimeStamp(json["data_visura_evasione_ccia"]),
        json["email"] as String,
        json["indirizzo"] as Indirizzo,
        json["numero_rea"] as String,
        json["partita_iva"] as String,
        json["pec"] as String,
        json["ragione_sociale"] as String,
        json["telefono"] as List<Telefono>,
        json["uid_utente"] as String);
  }

  static AziendaEntity fromSnapshot(DocumentSnapshot snap) {
    return AziendaEntity(
      snap.documentID,
      snap.data['codice_ateco'],
      snap.data['created_at'] == null ? null : (snap.data['created_at'] as Timestamp).toDate(),
      snap.data['data_visura_evasione_ccia'] == null ? null : (snap.data['data_visura_evasione_ccia'] as Timestamp).toDate(),//FunctionDate.processStringToTimeStamp(snap.data['data_visura_evasione_ccia']),
      snap.data['email'],
      snap.data['indirizzo'] == null ? Indirizzo() : Indirizzo.fromEntity(IndirizzoEntity.fromJson(snap.data['indirizzo'])),
      snap.data['numero_rea'],
      snap.data['partita_iva'],
      snap.data['pec'],
      snap.data['ragione_sociale'],
      snap.data['telefono'] == null ? [Telefono()] : List<Telefono>.from(snap.data['telefono'].map((item) {
            return Telefono(
                nota: item['nota'],
                prefisso: item['prefisso'],
                numero: item['numero']);
          })),
      snap.data['uid_utente'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "codice_ateco": codiceAteco,
      "created_at": createdAt,
      "data_visura_evasione_ccia": dataVisuraEC,
      "email": email,
      "indirizzo": indirizzo.toEntity().toDocument(),
      "numero_rea": numeroRea,
      "partita_iva": partitaIva,
      "pec": pec,
      "ragione_sociale": ragioneSociale,
      "telefono": List<Map<String, Object>>.from(telefono.map((item) {
        return item.toEntity().toDocument();
      },)),
      "uid_utente": uidUtente,
    };
  }
}
