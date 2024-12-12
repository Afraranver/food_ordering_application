import 'package:food_ordering_application/src/models/model.dart';
import 'dart:developer';
import 'dart:io';

class AppData {
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;

  AppData._internal();

  String selectedMenu = 'MEAL DEALS';
  List<Menu> menus = [];
  List<Category> categories = [];
  List<Item> items = [];
  List<ModifierGroups> modifierGroups = [];

  bool _isLoaded = false;

  Future<void> loadData() async {
    if (_isLoaded) return;

    final loader = JSONLoader('assets/menu_data.json');

    menus = await loader.loadMenus();
    categories = await loader.loadCategories();
    items = await loader.loadItems();
    modifierGroups = await loader.loadModifierGroups();
    _isLoaded = true;

    if (menus.isNotEmpty) {
      selectedMenu = menus.first.title;
    }

    try {
      log('Current Directory: ${Directory.current.path}');
      // Load Menus
      log('Menus loaded successfully.', name: 'Main');
      for (var menu in menus) {
        log('Menu: ${menu.title}', name: 'Main');
      }

      // Load Categories
      log('Categories loaded successfully.', name: 'Main');
      for (var category in categories) {
        log('Category: ${category.title}', name: 'Main');
      }

      // Load Items
      log('Items loaded successfully.', name: 'Main');
      for (var item in items) {
        log('Item: ${item.title}', name: 'Main');
      }

      // Load ModifierGroups
      log('ModifierGroups loaded successfully.', name: 'Main');
      for (var modifer in modifierGroups) {
        log('ModifierGroup: ${modifer.title}', name: 'Main');
      }

    } catch (e) {
      log('Error: $e', level: 1000, name: 'Main');
    }
  }
}
