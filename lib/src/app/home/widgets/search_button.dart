
import 'package:flutter/material.dart';



class SearchButton extends StatelessWidget {
    final VoidCallback onStartSearch;

  const SearchButton({Key key, this.onStartSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
                onStartSearch();
            },
          );
  }
}