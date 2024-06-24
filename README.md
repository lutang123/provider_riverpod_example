# Provider and Riverpod State Management Example

This repository demonstrates two state management solutions in Flutter: `provider` and `riverpod`. The app includes a counter page, a list page and a Todo app page, each page is created with different kind of providers to showcase the differences and pros and cons.

## Table of Contents

- [About the App](#about-the-app)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [State Management Implementations](#state-management-implementations)
  - [Provider](#provider)
  - [Riverpod](#riverpod)
- [Comparison](#comparison)
- [Screenshots](#screenshots)
- [YouTube Video](#youtube-video)
- [Contributing](#contributing)
- [License](#license)

## About the App

The app consists of 3 main features:

1. **Counter Page**: Demonstrates a simple counter using `provider` and `riverpod`.
2. **List Page**: Displays a list of items, managed separately by `provider` and `riverpod`.
3. **Todos Page**: A sample App with `riverpod 2.0`:

## Getting Started

### Prerequisites

- Flutter SDK: [Flutter installation guide](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter installation

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/provider_riverpod_example.git
   cd provider_riverpod_example
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**

   ```bash
   flutter run
   ```

## State Management Implementations

### Provider

`provider` is a popular state management package for Flutter, offering a simple API for managing state.

#### Example:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterNotifier extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterScreen(),
    );
  }
}
```

### Riverpod

`riverpod` is a state management library that improves upon `provider` by offering a more robust and testable solution.

#### Example:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() {
    state++;
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterScreen(),
    );
  }
}
```

## Comparison

### Provider

- **Mutable State**: State can be directly modified, leading to potential unintended side effects.
- **Performance**: All listeners are notified of changes, even if the specific part of the state they depend on hasn’t changed.

### Riverpod

- **Immutable State**: State is immutable, promoting more predictable state management.
- **Performance**: Only the relevant listeners are notified when the state changes.

## Screensh

### Counter Page

- **Provider Tab**:
  ![Provider Counter](path/to/provider_counter_screenshot.png)
- **Riverpod Tab**:
  ![Riverpod Counter](path/to/riverpod_counter_screenshot.png)

### List Page

- **Provider Tab**:
  ![Provider List](path/to/provider_list_screenshot.png)
- **Riverpod Tab**:
  ![Riverpod List](path/to/riverpod_list_screenshot.png)

## YouTube Video

For a detailed explanation and walkthrough, check out the [YouTube video](https://youtu.be/your-video-link).

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
