import 'package:flutter/material.dart';

import 'package:document_manager/src/app/home/models/models.dart';

class DeleteAziendaSnackBar extends SnackBar {
  DeleteAziendaSnackBar({
    Key key,
    @required Azienda azienda,
    @required VoidCallback onUndo,
  }) : super(
          key: key,
          content: Text(
            'Cancellazione ${azienda.ragioneSociale}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Annulla',
            onPressed: onUndo,
          ),
        );
}
