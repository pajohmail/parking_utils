import 'dart:io';

import 'package:parking_utils/cli_dialog.dart';

/// The main entry point of the application.
void main() {
  // Create an instance of ClIDialog.
  ClIDialog cd = ClIDialog();

  // Continuously display the welcome menu.
  while (true) {
    cd.welcomeMenu();
  }
}