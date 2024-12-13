import 'package:food_ordering_application/src/models/category_model.dart';
import 'package:food_ordering_application/src/models/item_model.dart';
import 'package:food_ordering_application/src/models/menu_model.dart';
import 'package:food_ordering_application/src/models/modifiergroup_model.dart';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';

class AppData {
  static final AppData _instance = AppData._internal();
  factory AppData() => _instance;

  AppData._internal();

  String selectedMenu = 'MEAL DEALS';
  List<Menu> menus = [];
  List<Category> categories = [];
  List<Item> items = [];
  List<ModifierGroup> modifierGroups = [];
  String today = "";
  TimeRange? todayTimeRange;
  List<Category> displayedCategories = [];
  String selectedCategory = "";
  List<Item> filteredItems = [];
  bool _isLoaded = false;

  Future<void> loadData() async {
    if (_isLoaded) return;

    final loader = JSONLoader('assets/menu_data.json');

    menus = await loader.loadMenus();
    categories = await loader.loadCategories();
    items = await loader.loadItems();
    modifierGroups = await loader.loadModifierGroups();
    _isLoaded = true;

    // Get today's day (e.g., 'Monday', 'Tuesday', etc.)
    today = DateFormat('EEEE').format(DateTime.now());

    if (menus.isNotEmpty) {
      selectedMenu = menus.first.title;

      // Get the time range for today's day from the menu's availability
      for (var menuItem in menus) {
        // Access the menuAvailability for today
        todayTimeRange = menuItem.menuAvailability[today];

        // You can now use todayTimeRange for displaying time range for today's menu item
        if (todayTimeRange != null) {
          log('Menu: ${menuItem.title}');
          log('Available today: ${todayTimeRange?.startTime} - ${todayTimeRange?.endTime}');
        }
      }

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
