
import 'dart:async';

import 'package:document_manager/src/app/authentication/models/user.dart';
import 'package:document_manager/src/app/home/models/models.dart';


abstract class AziendeRepository {
  Future<void> addNewAzienda(Azienda azienda);

  Future<void> deleteAzienda(Azienda azienda);

  Stream<List<Azienda>> aziende(User user,int page,List<Azienda> aziende,String searchText);

  Future<void> updateAzienda(Azienda azienda);
}
