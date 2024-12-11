import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/load_dataset';
import 'dart:developer';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'dart:io';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));

  const jsonFilePath = 'assets/menu_data.json';
  final loader = JSONLoader(jsonFilePath);

  try {
    log('Current Directory: ${Directory.current.path}');
    // Load Menus
    final menus = await loader.loadMenus();
    log('Menus loaded successfully.', name: 'Main');
    for (var menu in menus) {
      log('Menu: ${menu.title}', name: 'Main');
    }

    // Load Categories
    final categories = await loader.loadCategories();
    log('Categories loaded successfully.', name: 'Main');
    for (var category in categories) {
      log('Category: ${category.title}', name: 'Main');
    }
  } catch (e) {
    log('Error: $e', level: 1000, name: 'Main');
  }
}
