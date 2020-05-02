import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:document_manager/src/app/home/widgets/widgets.dart';
import 'package:document_manager/src/app/home/bloc/bloc.dart';
import 'package:document_manager/src/app/home/models/models.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isInSearchMode = false;

  cancelSearch() {
    setState(() {
      isInSearchMode = false;
    });
  }

  startSearch() {
    setState(() {
      isInSearchMode = true;
      BlocProvider.of<TabBloc>(context).add(UpdateTab(AppTab.aziende));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          drawer: isInSearchMode ? null : NavDrawer(),
          appBar: AppBar(
            title: isInSearchMode
                ? SearchBar(
                    aziendeBloc: BlocProvider.of<AziendeBloc>(context),
                    onCancelSearch: cancelSearch,
                  )
                : Text('Menu'),
            actions: [
              isInSearchMode
                  ? Container()
                  : SearchButton(
                      onStartSearch: startSearch,
                    )
              //FilterButton(visible: activeTab == AppTab.todos),
              //ExtraActionsButton(visible: activeTab == AppTab.todos),
              //LogoutButton(),
            ],
          ),
          body: getScreenTab(activeTab),
          /*floatingActionButton: activeTab != AppTab.aziende
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    activeTab == AppTab.aziende
                        ? Navigator.pushNamed(context, '/addAzienda')
                        : Navigator.pushNamed(context, '/addAzienda');
                  },
                  child: Icon(Icons.add),
                  tooltip: 'Add Aziende',
                ),*/
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(UpdateTab(tab)),
          ),
        );
      },
    );
  }

  Widget getScreenTab(AppTab activeTab) {
    switch (activeTab) {
      case AppTab.aziende:
        return Aziende();
        break;
      case AppTab.info:
        return Stats();
        break;
      default:
        return Text('Indefinito');
    }
  }
}
