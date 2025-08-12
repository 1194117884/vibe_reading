# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter project named "vibe_reading" that appears to be in the early stages of development. Based on the README.md file, this project aims to create an integrated language learning application that provides a seamless workflow from reading to memory.

## Common Development Commands

### Building and Running
- `flutter run` - Run the app on a connected device or emulator
- `flutter run -d chrome` - Run the app in a web browser
- `flutter build apk` - Build an Android APK
- `flutter build ios` - Build an iOS app
- `flutter build web` - Build a web version

### Testing
- `flutter test` - Run all tests
- `flutter test test/widget_test.dart` - Run a specific test file

### Code Quality
- `flutter analyze` - Run static analysis
- `flutter pub get` - Install dependencies
- `flutter pub upgrade` - Upgrade dependencies

## Code Architecture and Structure

### Project Structure
- `lib/main.dart` - Entry point of the application with basic counter app structure
- `test/widget_test.dart` - Basic widget tests for the counter functionality
- `pubspec.yaml` - Project dependencies and configuration
- `analysis_options.yaml` - Linting rules configuration

### Key Components
The application currently implements a basic Flutter counter app with:
1. A stateful widget (`MyHomePage`) that manages a counter state
2. A floating action button that increments the counter
3. A simple UI that displays the current counter value

### Dependencies
- Flutter SDK
- cupertino_icons: ^1.0.8
- flutter_test (dev dependency)
- flutter_lints: ^5.0.0 (dev dependency)

## Development Notes

This project is based on the standard Flutter template and currently contains only the default counter app example. The extensive README.md file suggests that this is a new project that will be developed into a comprehensive language learning application for reading and vocabulary building.

The project follows standard Flutter project structure and uses the recommended linting rules from `flutter_lints`.