import 'package:document_manager/src/app/home/bloc/bloc.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final AziendeBloc aziendeBloc;
  final VoidCallback onCancelSearch;

  SearchBar({this.aziendeBloc,this.onCancelSearch});

  @override
  State<SearchBar> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();

  AziendeBloc get aziendeBloc => widget.aziendeBloc;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: TextField(
        cursorColor: Colors.white,
        controller: _textController,
        autocorrect: false,
        onChanged: (text) {
          aziendeBloc.add(AziendeSearchTextEdit(text));
          aziendeBloc.add(LoadAziende(1, null));
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          suffixIcon: GestureDetector(
            child: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onTap: _onClearTapped,
          ),
          border: InputBorder.none,
          filled: true,
          hintText: 'Cerca azienda ...',
          hintStyle:TextStyle(color: Colors.white54,fontStyle: FontStyle.italic, fontSize: 17), 
        ),
      ),
    );
  }

  void _onClearTapped() {
    _textController.text = '';
    widget.onCancelSearch();
    aziendeBloc.add(AziendeSearchTextEdit(''));
    aziendeBloc.add(LoadAziende(1, null));
  }
}