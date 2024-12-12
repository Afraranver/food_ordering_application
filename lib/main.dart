import 'package:flutter/material.dart';
import 'package:food_ordering_application/src/util/appdata.dart';
import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(MyApp(settingsController: settingsController));

  // Load data once when the app starts
  await AppData().loadData();
  
}
