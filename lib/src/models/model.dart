import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:food_ordering_application/src/models/item_model.dart';

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

class Category {
  String id;
  String menuCategoryID;
  String menuID;
  String storeID;
  String title;
  String? subTitle;
  List<MenuEntity> menuEntities;
  DateTime createdDate;
  DateTime modifiedDate;
  String createdBy;
  String modifiedBy;

  Category({
    required this.id,
    required this.menuCategoryID,
    required this.menuID,
    required this.storeID,
    required this.title,
    this.subTitle,
    required this.menuEntities,
    required this.createdDate,
    required this.modifiedDate,
    required this.createdBy,
    required this.modifiedBy,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['ID'],
      menuCategoryID: json['MenuCategoryID'],
      menuID: json['MenuID'],
      storeID: json['StoreID'],
      title: json['Title']['en'],
      subTitle: json['SubTitle']['en'],
      menuEntities: (json['MenuEntities'] as List<dynamic>)
          .map((entity) => MenuEntity.fromJson(entity))
          .toList(),
      createdDate: DateTime.parse(json['CreatedDate']),
      modifiedDate: DateTime.parse(json['ModifiedDate']),
      createdBy: json['CreatedBy'],
      modifiedBy: json['ModifiedBy'],
    );
  }
}

class MenuEntity {
  String id;
  String type;

  MenuEntity({
    required this.id,
    required this.type,
  });

  factory MenuEntity.fromJson(Map<String, dynamic> json) {
    return MenuEntity(
      id: json['ID'],
      type: json['Type'],
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

  List<Item> getItemsForSelectedCategory(String selectedCategory) {
  // Assuming categories and items are available as part of AppData or similar structure
  List<Item> items = [];
  
  // for (var category in AppData().displayedCategories) {
  //   if (category.title == selectedCategory) {
  //     // Extract the items from MenuEntities for this category
  //     for (var menuEntity in category.menuEntities) {
  //       // Assuming we have a method to get items based on MenuEntity ID
  //       Item item = getMenuItemByID(menuEntity.id);
  //       items.add(item);
  //           }
  //   }
  // }

  return items;
}

// Item getMenuItemByID(String menuItemID) {
//   // Fetch menu item by ID from a pre-defined list of items or a database
//   // For now, returning a dummy item.
//   return Item(
//     ID: menuItemID,
//     title: 'Example Item',
//     description: 'Description for $menuItemID',
//     imageUrl: 'http://example.com/image.jpg',
//     price: 19.99,
//   );
// }
}
