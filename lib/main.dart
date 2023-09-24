import 'package:flutter/material.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quotes/app.dart';

import 'bloc_observer.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}
