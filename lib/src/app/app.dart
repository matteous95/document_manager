import 'package:document_manager/src/app/login/repo/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:document_manager/src/app/authentication/bloc/bloc.dart';
import 'package:document_manager/src/app/login/views/views.dart';
import 'package:document_manager/src/app/home/bloc/bloc.dart';
import 'package:document_manager/src/app/home/repo/repository.dart';
import 'package:document_manager/src/app/home/views/views.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) {
            return AuthenticationBloc(
              userRepository: UserRepository(),
            )..add(AppStarted());
          },
        ),
        BlocProvider<AziendeBloc>(
          create: (context) {
            return AziendeBloc(
              aziendeRepository: FirebaseAziendeRepository(),
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            )..add(LoadAziende(1,null));
          },
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          // Define the default brightness and colors.
          //brightness: Brightness.dark,
          primaryColor: Color.fromRGBO(96, 65, 176, 1),
          accentColor: Colors.cyan[600],
        ),
        title: 'Document Manager',
        routes: {
          '/': (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state is Authenticated) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider<TabBloc>(
                        create: (context) => TabBloc(),
                      ),
                      BlocProvider<StatsBloc>(
                        create: (context) => StatsBloc(
                          aziendeBloc: BlocProvider.of<AziendeBloc>(context),
                        ),
                      ),
                    ],
                    child: HomeScreen(),
                  );
                }
                if (state is Unauthenticated) {
                  return LoginScreen(
                    userRepository: UserRepository(),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            );
          },
          /* '/addAzienda': (context) {
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
          },*/
        },
      ),
    );
  }
}
