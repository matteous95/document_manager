import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:document_manager/src/app/home/models/models.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            getIconaTab(tab),
          ),
          title: Text(
            getTextTab(tab),
          ),
        );
      }).toList(),
    );
  }

  IconData getIconaTab(AppTab tab) {
    switch (tab) {
      case AppTab.aziende:
        return Icons.business;
        break;
      case AppTab.info:
        return Icons.show_chart;
        break;
      default:
        return Icons.list;
    }
  }

    String getTextTab(AppTab tab) {
    switch (tab) {
      case AppTab.aziende:
        return 'Aziende';
        break;
      case AppTab.info:
        return 'Info';
        break;
      default:
        return 'Todos';
    }
  }
}
