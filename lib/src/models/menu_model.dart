import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:food_ordering_application/src/models/category_model.dart';
import 'package:food_ordering_application/src/models/item_model.dart';
import 'package:food_ordering_application/src/models/modifiergroup_model.dart';

class Menu {
  String id;
  String title;
  Map<String, TimeRange> menuAvailability;
  List<String> menuCategoryIDs;

  Menu({
    required this.id,
    required this.title,
    required this.menuAvailability,
    required this.menuCategoryIDs,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['ID'],
      title: json['Title']['en'],
      menuAvailability: (json['MenuAvailability'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, TimeRange.fromJson(value))),
      menuCategoryIDs: List<String>.from(json['MenuCategoryIDs']),
    );
  }
}

class TimeRange {
  String startTime;
  String endTime;

  TimeRange({
    required this.startTime,
    required this.endTime,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      startTime: json['StartTime'],
      endTime: json['EndTime'],
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

    Future<List<ModifierGroup>> loadModifierGroups() async {
    final Map<String, dynamic> jsonData = await _loadJson();
    return (jsonData['Result']['ModifierGroups'] as List)
        .map((modifierGroupsJson) => ModifierGroup.fromJson(modifierGroupsJson))
        .toList();
  }

}
