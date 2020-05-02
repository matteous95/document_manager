import 'package:document_manager/src/app/home/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:document_manager/src/app/home/widgets/widgets.dart';
import 'package:document_manager/src/app/home/bloc/bloc.dart';
import 'package:document_manager/src/app/home/views/views.dart';

class Aziende extends StatefulWidget {
  Aziende({Key key}) : super(key: key);

  @override
  _AziendeState createState() => _AziendeState();
}

class _AziendeState extends State<Aziende> {
  AziendeBloc aziendeBloc;
  //List<Azienda> aziende;
  final scrollController = ScrollController();
  final scrollThreshold = 200.0;
  bool scrollLoading;
  int currPage = 1;

  void initState() {
    aziendeBloc = BlocProvider.of<AziendeBloc>(context);
    scrollController.addListener(_onScroll);
    scrollLoading = false;
    super.initState();
  }

  void disposeState() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //SearchBar(
            //aziendeBloc: aziendeBloc,
          //),
          Expanded(
            child: BlocBuilder<AziendeBloc, AziendeState>(
              bloc: aziendeBloc,
              builder: (context, state) {
                scrollLoading = false;

                if (state is AziendeNotLoaded) {
                  return Text('Problemi nel caricamento dei dati');
                }

                if (state is AziendeLoading) {
                  return LoadingIndicator();
                }

                if (state is AziendeLoaded) {
                  if (state.aziende.isEmpty) {
                    return Center(
                      child: Text('Nessun azienda presente'),
                    );
                  }

                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 1,
                    ),
                    itemCount: state.hasReachedMax && !scrollLoading
                        ? state.aziende.length
                        : state.aziende.length + 1,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      if (index >= state.aziende.length) {
                        return BottomLoader(
                          finishLoad: state.hasReachedMax,
                          numeroAziende: state.aziende.length,
                        );
                      }

                      final azienda = state.aziende[index];
                      return AziendaItem(
                        azienda: azienda,
                        onDismissed: (direction) {
                          if (direction == DismissDirection.endToStart) {
                            BlocProvider.of<AziendeBloc>(context)
                                .add(DeleteAzienda(azienda));
                            Scaffold.of(context)
                                .showSnackBar(DeleteAziendaSnackBar(
                              azienda: azienda,
                              onUndo: () =>
                                  BlocProvider.of<AziendeBloc>(context)
                                      .add(AddAzienda(azienda)),
                            ));
                          }
                        },
                        onTap: () async {
                          final removedAzienda =
                              await Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) {
                              return DetailsScreenAzienda(
                                id: azienda.id,
                                aziendeBloc:
                                    BlocProvider.of<AziendeBloc>(context),
                              );
                            }),
                          );
                          if (removedAzienda != null) {
                            Scaffold.of(context).showSnackBar(
                              DeleteAziendaSnackBar(
                                azienda: azienda,
                                onUndo: () =>
                                    BlocProvider.of<AziendeBloc>(context)
                                        .add(AddAzienda(azienda)),
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
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
                      AddAzienda(Azienda(
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
                          uidUtente: uidUtente)),
                    );
                  },
                  isEditing: false,
                );
              },
            ),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Aggiungi Aziende',
      ),
    );
  }

  /*bool _handleScrollNotification(ScrollNotification scrollInfo) {
    if (!scrollLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      scrollLoading = true;
      currPage += 1;
      aziendeBloc.add(
          LoadAziende(currPage, (aziendeBloc.state as AziendeLoaded).aziende));
    }

    return false;
  }*/

  void _onScroll() {
    if (aziendeBloc.state is AziendeLoaded) {
      if ((aziendeBloc.state as AziendeLoaded).hasReachedMax) {
        return;
      }

      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= scrollThreshold &&
          scrollLoading == false) {
        scrollLoading = true;
        currPage += 1;
        aziendeBloc
          ..add(LoadAziende(
              currPage, (aziendeBloc.state as AziendeLoaded).aziende));
      }
    }
  }
}

class BottomLoader extends StatelessWidget {
  final bool finishLoad;
  final int numeroAziende;

  BottomLoader({@required this.finishLoad, @required this.numeroAziende});

  @override
  Widget build(BuildContext context) {
    if (finishLoad == false) {
      return Container(
        alignment: Alignment.center,
        child: Center(
          child: SizedBox(
            width: 33,
            height: 33,
            child: Theme(
              data: Theme.of(context).copyWith(accentColor: Colors.teal),
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text('Caricati $numeroAziende clienti'),
          ),
        ),
      );
    }
  }
}
