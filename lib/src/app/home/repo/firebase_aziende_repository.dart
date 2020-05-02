import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_manager/src/app/authentication/models/user.dart';
import './repository.dart';
import 'package:document_manager/src/app/home/models/models.dart';

class FirebaseAziendeRepository implements AziendeRepository {
  final aziendeCollection = Firestore.instance.collection('aziende');
  DocumentSnapshot lastDocument;

  @override
  Future<void> addNewAzienda(Azienda azienda) {
    return aziendeCollection.add(azienda.toEntity().toDocument());
  }

  @override
  Future<void> deleteAzienda(Azienda azienda) async {
    return aziendeCollection.document(azienda.id).delete();
  }

  @override
  Future<void> updateAzienda(Azienda update) {
    return aziendeCollection
        .document(update.id)
        .updateData(update.toEntity().toDocument());
  }

  @override
  Stream<List<Azienda>> aziende(
      User user, int page, List<Azienda> aziende, String searchText) {
    if (searchText == '') {
      if (page == 1) {
        return loadFirstAziende(user);
      } else {
        return loadContinueAziende(user, aziende);
      }
    } else {
      if (page == 1) {
        return loadFirstSearchAziende(user, searchText);
      } else {
        return loadContinueSearchAziende(user, searchText, aziende);
      }
    }
  }

  Stream<List<Azienda>> loadFirstAziende(User user) {
    return aziendeCollection
        .where('uid_utente', isEqualTo: user.authUid)
        .orderBy("ragione_sociale")
        .limit(10)
        .snapshots()
        .map((snapshot) {
      lastDocument = snapshot.documents.length < 1
          ? null
          : snapshot.documents[snapshot.documents.length - 1];
      return snapshot.documents
          .map((doc) => Azienda.fromEntity(AziendaEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Stream<List<Azienda>> loadContinueAziende(User user, List<Azienda> aziende) {
    return aziendeCollection
        .where('uid_utente', isEqualTo: user.authUid)
        .orderBy("ragione_sociale")
        .startAfter([aziende[aziende.length - 1].ragioneSociale])
        .limit(10)
        .snapshots()
        .map((snapshot) {
          if (snapshot.documents.isNotEmpty) {
            lastDocument = snapshot.documents.length < 1
                ? null
                : snapshot.documents[snapshot.documents.length - 1];
          }
          aziende.addAll(snapshot.documents
              .map((doc) => Azienda.fromEntity(AziendaEntity.fromSnapshot(doc)))
              .toList());
          return aziende;
        });
  }

  Stream<List<Azienda>> loadFirstSearchAziende(User user, String searchText) {
    return aziendeCollection
        .where('uid_utente', isEqualTo: user.authUid)
        .where('ragione_sociale', isGreaterThanOrEqualTo: searchText)
        .where('ragione_sociale', isLessThanOrEqualTo: searchText+ '\uf8ff')
        .orderBy("ragione_sociale")
        .limit(10)
        .snapshots()
        .map((snapshot) {
      lastDocument = snapshot.documents.length < 1
          ? null
          : snapshot.documents[snapshot.documents.length - 1];
      return snapshot.documents
          .map((doc) => Azienda.fromEntity(AziendaEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  Stream<List<Azienda>> loadContinueSearchAziende(
      User user, String searchText, List<Azienda> aziende) {
    return aziendeCollection
        .where('uid_utente', isEqualTo: user.authUid)
        .where('rag_sociale', isGreaterThanOrEqualTo: searchText)
        .where('ragione_sociale', isLessThanOrEqualTo: searchText+ '\uf8ff')
        .orderBy("ragione_sociale")
        .startAfter([aziende[aziende.length - 1].ragioneSociale])
        .limit(10)
        .snapshots()
        .map((snapshot) {
          if (snapshot.documents.isNotEmpty) {
            lastDocument = snapshot.documents.length < 1
                ? null
                : snapshot.documents[snapshot.documents.length - 1];
          }
          aziende.addAll(snapshot.documents
              .map((doc) => Azienda.fromEntity(AziendaEntity.fromSnapshot(doc)))
              .toList());
          return aziende;
        });
  }
}
