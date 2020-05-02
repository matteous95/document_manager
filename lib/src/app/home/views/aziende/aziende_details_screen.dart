import 'package:document_manager/src/app/home/models/models.dart';
import 'package:document_manager/src/shared/function.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:document_manager/src/app/home/bloc/aziende/aziende.dart';
import 'package:document_manager/src/app/home/views/views.dart';
import 'package:intl/intl.dart';

class DetailsScreenAzienda extends StatelessWidget {
  final String id;
  final AziendeBloc aziendeBloc;
  DetailsScreenAzienda({Key key, @required this.id,@required this.aziendeBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AziendeBloc, AziendeState>(
      builder: (context, state) {
        final azienda = (state as AziendeLoaded)
            .aziende
            .firstWhere((azienda) => azienda.id == id, orElse: () => null);
        return Scaffold(
          appBar: AppBar(
            title: Text('Dettaglio Azienda'),
            actions: [
              IconButton(
                tooltip: 'Elimina Azienda',
                icon: Icon(Icons.delete),
                onPressed: () {
                  BlocProvider.of<AziendeBloc>(context).add(DeleteAzienda(azienda));
                  Navigator.pop(context, azienda);
                },
              )
            ],
          ),
          body: azienda == null
              ? Container()
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(
                    children: [_aziendaDettaglio(context, azienda)],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Modifica Azienda',
            child: Icon(Icons.edit),
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: azienda == null
                ? null
                : () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddEditScreenAzienda(
                            onSave: (id,
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
                                uidUtente) {
                              BlocProvider.of<AziendeBloc>(context).add(
                                UpdateAzienda(
                                  azienda.copyWith(
                                      id: id,
                                      codiceAteco: codiceAteco,
                                      createdAt: createdAt,
                                      dataVisuraEC: dataVisuraEC,
                                      email: email,
                                      indirizzo: indirizzo,
                                      numeroRea: numeroRea,
                                      partitaIva: partitaIva,
                                      pec: pec,
                                      ragioneSociale: ragioneSociale,
                                      telefono: telefono,
                                      uidUtente: uidUtente),
                                ),
                              );
                            },
                            isEditing: true,
                            azienda: azienda,
                          );
                        },
                      ),
                    );
                  },
          ),
        );
      },
    );
  }

  Widget _aziendaDettaglio(context, Azienda azienda) {
    return Column(
      children: <Widget>[
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.ragioneSociale),
            Icons.account_circle,
            'Ragione Sociale'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.email),
            Icons.email,
            'Email'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.pec),
            Icons.email,
            'Pec'),
        dettaglioSingolo(
            context,
            azienda.telefono == null ? '' : FunctionString.processDynamicToString(azienda.telefono[0].numero),
            Icons.phone,
            'Telefono'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.indirizzo.nazione),
            Icons.map,
            'Nazione'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.indirizzo.citta),
            Icons.location_city,
            'Citta'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.indirizzo.provincia),
            Icons.add_location,
            'Provincia'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.indirizzo.cap),
            Icons.local_library,
            'CAP'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.indirizzo.via),
            Icons.location_on,
            'Via'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.indirizzo.civico),
            Icons.format_list_numbered_rtl,
            'Civico'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.partitaIva),
            Icons.code,
            'Partita iva'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.codiceAteco),
            Icons.clear_all,
            'Codice Ateneo'),
        dettaglioSingolo(
            context,
            FunctionString.processDynamicToString(azienda.numeroRea),
            Icons.power_input,
            'Numero Rea'),
        dettaglioSingolo(
            context,
            azienda.dataVisuraEC == null 
                ? ''
                : DateFormat('dd/MM/yyyy')
                    .format(azienda.dataVisuraEC),
            Icons.date_range,
            'DataNascita'),
      ],
    );
  }

  Widget dettaglioSingolo(
      context, String text, IconData icon, String tileCase) {
    return text == ''
        ? Container(
            child: null,
          )
        : GestureDetector(
            /*   onTap: () {
        switch (tileCase) {
          case 'Nome':
            break;
          case 'Cellulare':
            _launch("cell:" + azienda.cellulare);
            break;
          case 'Email':
            _launch("mailto:${contact.email}?");
            break;
          case Texts.ADDRESS:
            _launch(googleMapUrl(contact.latitude, contact.longitude));
            break;
          case Texts.LATITUDE:
            _launch(googleMapUrl(contact.latitude, contact.longitude));
            break;
          case Texts.LONGITUDE:
            _launch(googleMapUrl(contact.latitude, contact.longitude));
            break;
        }
      }, */
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    text,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  leading: Icon(
                    icon,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          );
  }
}
