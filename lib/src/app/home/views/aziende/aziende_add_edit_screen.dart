import 'package:document_manager/src/app/authentication/bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:document_manager/src/app/home/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

typedef OnSaveCallbackAzienda = Function(
  String id,
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
  String uidUtente,
);

class AddEditScreenAzienda extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallbackAzienda onSave;
  final Azienda azienda;

  AddEditScreenAzienda({
    Key key,
    @required this.onSave,
    @required this.isEditing,
    this.azienda,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreenAzienda> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _id;
  String _codiceAteco;
  DateTime _createdAt;
  DateTime _dataVisuraEC;
  String _email;
  Indirizzo _indirizzo = Indirizzo();
  String _numeroRea;
  String _partitaIva;
  String _pec;
  String _ragioneSociale;
  List<Telefono> _telefono = [Telefono()];
  String _uidUtente;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Modifica Azienda' : 'Aggiungi Azienda',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.azienda.ragioneSociale : '',
                autofocus: !isEditing,
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Ragione Sociale',
                  //hintText: 'Ragione Sociale',
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? 'Inserire la Ragione Sociale'
                      : null;
                },
                onSaved: (value) => _ragioneSociale = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.email : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Email',
                  //hintText: 'Email',
                ),
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.pec : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'PEC',
                  //hintText: 'PEC',
                ),
                onSaved: (value) => _pec = value,
              ),
              TextFormField(
                initialValue: isEditing
                    ? widget.azienda.telefono == null
                        ? ''
                        : widget.azienda.telefono[0].numero
                    : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Telefono',
                  //hintText: 'Telefono',
                ),
                onSaved: (value) =>
                    value != null && value != '' ? _telefono[0].numero = value : null,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.indirizzo.nazione : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Nazione',
                  //hintText: 'Nazione',
                ),
                onSaved: (value) => value != null && value != ''
                    ? _indirizzo.nazione = value
                    : null,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.indirizzo.citta : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Citta',
                  //hintText: 'Citta',
                ),
                onSaved: (value) => value != null && value != ''
                    ? _indirizzo.citta = value
                    : null,
              ),
              TextFormField(
                initialValue:
                    isEditing ? widget.azienda.indirizzo.provincia : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Provincia',
                  //hintText: 'Provincia',
                ),
                onSaved: (value) => value != null && value != ''
                    ? _indirizzo.provincia = value
                    : null,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.indirizzo.cap : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Cap',
                  //hintText: 'Cap',
                ),
                onSaved: (value) => value != null && value != ''
                    ? _indirizzo.cap = value
                    : null,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.indirizzo.via : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Via',
                  //hintText: 'Via',
                ),
                onSaved: (value) => value != null && value != ''
                    ? _indirizzo.via = value
                    : null,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.indirizzo.civico : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Civico',
                  //hintText: 'Civico',
                ),
                onSaved: (value) => value != null && value != ''
                    ? _indirizzo.civico = value
                    : null,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.partitaIva : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Partita Iva',
                  //hintText: 'Partita Iva',
                ),
                onSaved: (value) => _partitaIva = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.codiceAteco : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Codice Ateco',
                  //hintText: 'Codice Ateco',
                ),
                onSaved: (value) => _codiceAteco = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.azienda.numeroRea : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Numero Rea',
                  //hintText: 'Numero Rea',
                ),
                onSaved: (value) => _numeroRea = value,
              ),
              TextFormField(
                initialValue: isEditing
                    ? widget.azienda.dataVisuraEC != null
                        ? DateFormat('dd/MM/yyyy')
                            .format(widget.azienda.dataVisuraEC)
                        : ''
                    : '',
                style: textTheme.headline6,
                decoration: InputDecoration(
                  labelText: 'Data Visura Evasione Ccia',
                  //hintText: 'Data Visura Evasione Ccia',
                ),
                onSaved: (value) =>
                    //_dataVisuraEC = value == '' ? null : DateTime.parse(value),
                    _dataVisuraEC = value == ''
                        ? null
                        : DateFormat("dd/MM/yyyy").parse(value),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing ? 'Salva modifiche' : 'Aggiungi Azienda',
        child: Icon(isEditing ? Icons.check : Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            if (!isEditing) {
              _uidUtente = (BlocProvider.of<AuthenticationBloc>(context).state
                      as Authenticated)
                  .user
                  .authUid;
              _createdAt = DateTime.now();
            }

            widget.onSave(
                _id,
                _codiceAteco,
                _createdAt,
                _dataVisuraEC,
                _email,
                _indirizzo,
                _numeroRea,
                _partitaIva,
                _pec,
                _ragioneSociale,
                _telefono,
                _uidUtente);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
