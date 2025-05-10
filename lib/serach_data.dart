// widgets/search_bar.dart
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final bool isSearching;
  final TextEditingController controller;
  final VoidCallback onToggle;

  const SearchBarWidget({
    super.key,
    required this.isSearching,
    required this.controller,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child:
              isSearching
                  ? TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                  )
                  : const Text('API Grid'),
        ),
        IconButton(onPressed: onToggle, icon: const Icon(Icons.search)),
      ],
    );
  }
}
