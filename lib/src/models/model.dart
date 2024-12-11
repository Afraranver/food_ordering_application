import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';

// Model classes (Add your Menu, Category, and related models here)

class Menu {
  String id;
  String title;

  Menu({
    required this.id,
    required this.title,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['ID'],
      title: json['Title']['en'],
    );
  }
}

class Category {
  String id;
  String title;

  Category({
    required this.id,
    required this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['ID'],
      title: json['Title']['en'],
    );
  }
}

class Item {
  String id;
  String title;

  Item({
    required this.id,
    required this.title,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['ID'],
      title: json['Title']['en'],
    );
  }
}

class ModifierGroups {
  String id;
  String title;

  ModifierGroups({
    required this.id,
    required this.title,
  });

  factory ModifierGroups.fromJson(Map<String, dynamic> json) {
    return ModifierGroups(
      id: json['ID'],
      title: json['Title']['en'],
    );
  }
}


class JSONLoader {
  final String filePath;

  JSONLoader(this.filePath);

  Future<Map<String, dynamic>> _loadJson() async {
    try {
      final jsonString = await _readFile();
      return json.decode(jsonString);
    } catch (e) {
      log('Error loading JSON: $e', level: 1000, name: 'JSONLoader');
      throw Exception('Failed to load JSON.');
    }
  }

  Future<String> _readFile() async {
    log('Reading asset file: $filePath', name: 'JSONLoader');
    try {
      return await rootBundle.loadString(filePath);
    } catch (e) {
      log('Error reading asset file: $filePath. Exception: $e',
          level: 1000, name: 'JSONLoader');
      throw Exception('Asset file not found: $filePath');
    }
  }

  Future<List<Menu>> loadMenus() async {
    final Map<String, dynamic> jsonData = await _loadJson();
    return (jsonData['Result']['Menu'] as List)
        .map((menuJson) => Menu.fromJson(menuJson))
        .toList();
  }

  Future<List<Category>> loadCategories() async {
    final Map<String, dynamic> jsonData = await _loadJson();
    return (jsonData['Result']['Categories'] as List)
        .map((categoryJson) => Category.fromJson(categoryJson))
        .toList();
  }

  Future<List<Item>> loadItems() async {
    final Map<String, dynamic> jsonData = await _loadJson();
    return (jsonData['Result']['Items'] as List)
        .map((itemJson) => Item.fromJson(itemJson))
        .toList();
  }

    Future<List<ModifierGroups>> loadModifierGroups() async {
    final Map<String, dynamic> jsonData = await _loadJson();
    return (jsonData['Result']['ModifierGroups'] as List)
        .map((modifierGroupsJson) => ModifierGroups.fromJson(modifierGroupsJson))
        .toList();
  }
}
