import 'dart:io';

class ClIDialog {
  static void welcomeMenu() {
    print('1. Add Person');
    print('2. Add Vehicle');
    print('3. Add Parking lot');
    print('4. add Parking session');
    print('5. Exit');
    print('Enter your choice: ');
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
      // Add Person logic
      personMenu();
        break;
      case 2:
      // Add Vehicle logic
      vehicleMenu();
        break;
      case 3:
      // Add Parking lot logic
        break;
      case 4:
      // Add Parking session logic
        break;
      case 5:
        exit(0);
        break;
      default:
        print('Invalid choice');
        break;
    }// switch


    }// welcomeMenu
  static void personMenu() {
    print('1. Add Person');
    print('2. List Person');
    print('3. Edit Person');
    print('4. Delete Person');
    print('5. Back to root menu');
    print('Enter your choice: ');
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
      // Add Perso
        break;
      case 2:
      // List Person logic
        break;
      case 3:
      // Back logic
        break;
      default:
    case 4:
    // Back logic
    break;
    default:
    case 5:
    // Back logic
    break;
    default:
        print('Invalid choice');
        break;
    }// switch
  }// personMenu
  static void vehicleMenu() {
    print('1. Add Vehicle');
    print('2. List Vehicle');
    print('3. Back');
    print('Enter your choice: ');
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
      // Add Vehicle logic
        break;
      case 2:
      // List Vehicle logic
        break;
      case 3:
      // Back logic
        break;
      default:
        print('Invalid choice');
        break;
    }// switch
  }// vehicleMenu
  }
