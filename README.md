# Truncgil Finance Mobile App

A comprehensive mobile application for tracking real-time currency exchange rates, gold prices, and cryptocurrency values using the Truncgil Finance API.

![Truncgil Finance](assets/images/logo-dark.svg)

## About Truncgil Finance

Truncgil Finance is a powerful financial data provider that offers real-time access to various financial markets data including:
- Currency exchange rates
- Gold prices
- Cryptocurrency values

This mobile application serves as a user-friendly interface to access and monitor these financial data points in real-time.

## Features

- 📈 Real-time currency exchange rates
- 💰 Live gold prices
- 🪙 Cryptocurrency tracking
- 🔍 Advanced search functionality
- 📱 Modern Material Design UI
- 🌓 Dark/Light theme support
- 📊 Interactive charts and graphs
- 🔔 Price alerts and notifications
- ⭐️ Favorite currencies list
- 🔄 Auto-refresh functionality

## Technical Requirements

### Development Environment

- Flutter SDK (version 3.0.0 or higher)
- Dart SDK (version 2.17.0 or higher)
- Android Studio / VS Code with Flutter plugins
- Git

### System Requirements

- **Operating System**: 
  - macOS (for iOS development)
  - Windows/Linux/macOS (for Android development)
- **For iOS Development**:
  - Xcode 13 or higher
  - CocoaPods
  - iOS Simulator or physical device
- **For Android Development**:
  - Android Studio
  - Android SDK
  - Android Emulator or physical device

## Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/truncgil/truncgil-finance-flutter.git
   cd truncgil-finance-flutter
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **iOS Setup** (for macOS users)
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run the Application**
   ```bash
   flutter run
   ```

## Project Structure

```
truncgil-finance-flutter/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   └── home_screen.dart
│   ├── widgets/
│   │   ├── currency_card.dart
│   │   ├── crypto_card.dart
│   │   └── search_bar.dart
│   ├── models/
│   │   └── currency_model.dart
│   └── providers/
│       └── finance_provider.dart
├── assets/
│   └── images/
│       ├── logo-dark.svg
│       └── logo-light.svg
└── test/
    └── widget_test.dart
```

## API Integration

The application uses the Truncgil Finance API to fetch real-time financial data:

- Base URL: `https://finance.truncgil.com`
- Documentation: `https://finance.truncgil.com/docs`
- Today's Data Endpoint: `https://finance.truncgil.com/api/today.json`

## Configuration

1. **API Configuration**
   - The API endpoints are configured in the `lib/providers/finance_provider.dart` file
   - No API key is required for basic usage

2. **Theme Configuration**
   - Theme settings can be modified in `lib/main.dart`
   - Supports both light and dark themes

## Building for Production

### Android
```bash
flutter build apk --release
```
The APK file will be available at `build/app/outputs/flutter-apk/app-release.apk`

### iOS
```bash
flutter build ios --release
```
Then open the Xcode project and archive the application.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Support

For support, please contact:
- Email: support@truncgil.com
- Website: https://truncgil.com

## Acknowledgments

- Truncgil Finance API Team
- Flutter Development Team
- All contributors who participate in this project

---

Made with ❤️ by Truncgil Technology
