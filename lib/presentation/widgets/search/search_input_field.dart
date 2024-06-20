import 'dart:async';

import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';

class SearchInputField extends StatefulWidget {
  final Function(String? query) onSearch;

  const SearchInputField(this.onSearch, {super.key});

  @override
  _SearchInputFieldState createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  final _controller = TextEditingController();
  Timer? _debounceTimer;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(Duration(milliseconds: 250), () {
      widget.onSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: _controller,
      onChanged: (value){
        _onSearchChanged(value);
      },
      onSubmitted: (value) {
        _onSearchChanged(value);
      },
      style: TextStyle(
        color: context.textPrimary,
        fontSize: 14,
      ),
      decoration: InputDecoration.collapsed(
        hintText: Strings.searchHintCategoryAndProducts,
        hintStyle: TextStyle(
          color: context.textSecondary,
          fontSize: 12,
        ),
      ),
      keyboardType: TextInputType.text,
    );
  }
}
