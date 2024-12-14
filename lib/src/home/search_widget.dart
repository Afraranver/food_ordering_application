import 'dart:developer';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  bool _isSearchVisible = false; // To control visibility of the search field
  final TextEditingController _searchController =
      TextEditingController(); // Controller for the TextField

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the search field when tapping outside
        if (_isSearchVisible) {
          setState(() {
            _isSearchVisible = false;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search Example'),
          actions: [
            // Search Icon
            GestureDetector(
              onTap: () {
                setState(() {
                  _isSearchVisible =
                      !_isSearchVisible; // Toggle the search field visibility
                });
              },
              child: const Icon(
                Icons.search,
                size: 24,
                color: Colors.black,
              ),
            ),
            // Show input field when _isSearchVisible is true
            if (_isSearchVisible)
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _searchController,
                    autofocus: true, // Focus the text field immediately
                    decoration: InputDecoration(
                      hintText: "Search...",
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear(); // Clear the text field
                        },
                      ),
                    ),
                    onSubmitted: (query) {
                      // Perform search or handle the input
                      log("Searching for: $query");
                    },
                  ),
                ),
              ),
          ],
        ),
        body: const Center(child: Text('Tap the search icon to search')),
      ),
    );
  }
}
