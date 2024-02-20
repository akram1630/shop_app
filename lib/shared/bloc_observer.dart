import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    // Called when a bloc is instantiated
    print('Bloc created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Called when a bloc state changes
    print('Bloc ${bloc.runtimeType} state changed: $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // Called when an error occurs in a bloc
    print('Bloc ${bloc.runtimeType} error: $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    // Called when a bloc is closed and no longer used
    print('Bloc closed: ${bloc.runtimeType}');
  }
}
