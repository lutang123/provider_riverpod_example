import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// * Dependency Injection (DI) is a design pattern used to implement Inversion of Control for resolving dependencies. Instead of creating dependencies directly within a class, dependencies are provided to the class, making it more modular, testable, and easier to maintain.

// Benefits of DI:

// Decoupling: Makes code more modular by decoupling the creation of dependencies from their usage.
// Testability: Simplifies testing by allowing easy replacement of real dependencies with mocks or stubs.
// Flexibility: Enhances flexibility by enabling dynamic changing of dependencies.

//* example of usingAsyncNotifier*******************************************************************************************************************
// 1. add the necessary imports

// 2. extend [AsyncNotifier]

class AuthRepository {
  Future<void> signInAnonymously() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

//One advantage of AsyncNotifier over StateNotifier is that it allows us to initialize the state asynchronously.
class AuthController extends AsyncNotifier<void> {
  // 3. override the [build] method to return a [FutureOr]
  @override
  FutureOr<void> build() {
    // 4. return a value (or do nothing if the return type is void)
  }

  Future<void> signInAnonymously() async {
    // 5. read the repository using ref
    final authRepository = ref.read(authRepositoryProvider);
    // 6. set the loading state
    state = const AsyncLoading();
    // 7. sign in and update the state (data or error)
    state = await AsyncValue.guard(authRepository.signInAnonymously);
  }
}

//ref is always accessible as a property inside Notifier or AsyncNotifier subclasses, making it easy to read other providers.
//This is unlike StateNotifier, where we need to pass ref explicitly as a constructor argument if we want to use it.

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(() {
  return AuthController();
});

//Or, using a constructor tear-off:

final authControllerProvider2 =
    AsyncNotifierProvider<AuthController, void>(AuthController.new);


//https://codewithandrea.com/articles/flutter-riverpod-async-notifier/

//* Note about autoDispose
// //Note that if you declare an AsyncNotifier and the corresponding AsyncNotifierProvider using autoDispose like this:

// class AuthController extends AsyncNotifier<void> {
//   ...
// }

// final authControllerProvider =
//     AsyncNotifierProvider.autoDispose<AuthController, void>(AuthController.new);
// * Then you'll get a runtime error:
// Error: Type argument 'AuthController' doesn't conform to the bound 'AutoDisposeAsyncNotifier<T>' of the type variable 'NotifierT' on 'AutoDisposeAsyncNotifierProviderBuilder.call'.

// The correct way of using AsyncNotifier with autoDispose is to extend the AutoDisposeAsyncNotifier class:

// *using AutoDisposeAsyncNotifier
// class AuthController extends AutoDisposeAsyncNotifier<int> {
//   ...
// }
// * using AsyncNotifierProvider.autoDispose
// final authControllerProvider =
//     AsyncNotifierProvider.autoDispose<AuthController, void>(AuthController.new);

//The .autoDispose modifier can be used to reset the provider's state when all the listeners are removed. For more info, read: The autoDispose modifier

//*AsyncNotifier with Riverpod Generator

// // 1. import this
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// // 2. declare a part file
// part 'auth_controller.g.dart';

// // 3. annotate
// @riverpod
// // 4. extend like this
// class AuthController extends _$AuthController {
//   // 5. override the [build] method to return a [FutureOr]
//   @override
//   FutureOr<void> build() {
//     // 6. return a value (or do nothing if the return type is void)
//   }

//   Future<void> signInAnonymously() async {
//     // 7. read the repository using ref
//     final authRepository = ref.read(authRepositoryProvider);
//     // 8. set the loading state
//     state = const AsyncLoading();
//     // 9. sign in and update the state (data or error)
//     state = await AsyncValue.guard(authRepository.signInAnonymously);
//   }
// }


//Example with Asynchronous Initialization
//Since AsyncNotifier supports asynchronous initialization, we can write code like this:

// @riverpod
// class SomeOtherController extends _$SomeOtherController {
//   @override
//   // note the [Future] return type and the async keyword
//   Future<String> build() async {
//     final someString = await someFutureThatReturnsAString();
//     return anotherFutureThatReturnsAString(someString);
//   }

//   // other methods here
// }

//In this case, the build method is truly asynchronous and will only return when the future completes.

//But the build method of any listener widgets needs to return synchronously and can't wait for the future to complete:

// class SomeWidget extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // returns AsyncLoading on first load,
//     // rebuilds with the new value when the initialization is complete
//     final valueAsync = ref.watch(someOtherControllerProvider);
//     return valueAsync.when(...);
//   }
// }
//To handle this, the controller will emit two states, and the widget will rebuild twice:

// once with a temporary AsyncLoading value on first load
// again with the new AsyncData value (or an AsyncError) when the initialization is complete

