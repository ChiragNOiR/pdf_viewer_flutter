import 'package:flutter/material.dart';
import 'package:pdf_viewer/data/styles/styles.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController? searchTextController;
  final String? Function(String?)? validator;

  const SearchBar({
    Key? key,
    this.searchTextController,
    this.validator,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
        child: TextFormField(
          controller: widget.searchTextController,
          validator: widget.validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            hintText: 'Search',
            hintStyle: AppStyle.hint,
            contentPadding: const EdgeInsets.only(left: 15),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
