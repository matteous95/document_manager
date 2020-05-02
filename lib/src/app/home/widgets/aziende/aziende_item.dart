import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:document_manager/src/app/home/models/models.dart';

class AziendaItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Azienda azienda;

  AziendaItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.azienda,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__azienda_item_${azienda.id}'),
      onDismissed: onDismissed,
      direction: DismissDirection.endToStart,
      background: Container(
          padding: EdgeInsets.only(right: 20.0, top: 10.0),
          color: Colors.red,
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              // Replace with a Row for horizontal icon + text
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text('Elimina',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white))
              ],
            ),
          )),
      child: ListTile(
        trailing: Icon(Icons.keyboard_arrow_right),
        leading: Icon(
          Icons.business,
          color: Theme.of(context).primaryColor,
        ),
        onTap: onTap,
        title: Hero(
          tag: '${azienda.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: azienda.ragioneSociale != null
                ? Text(
                    azienda.ragioneSociale,
                    style: Theme.of(context).textTheme.headline6,
                  )
                : Text('Undefined'),
          ),
        ),
        subtitle: azienda.email != null && azienda.email.isNotEmpty
            ? Text(
                azienda.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
      ),
    );
  }
}
