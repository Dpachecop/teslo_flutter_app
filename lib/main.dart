import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_flutter_app/config/constants/enviroment.dart';
import 'package:teslo_flutter_app/config/router/app_router.dart';
import 'package:teslo_flutter_app/config/theme/app_theme.dart';

void main() async {
  await Enviroment.initEnv();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('API URL: ${Enviroment.apiUrl}');
    print("hola mundo");
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
