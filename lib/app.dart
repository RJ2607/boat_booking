import 'package:boat_booking/Theme/theme_data.dart';
import 'package:boat_booking/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'views/home/home_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      themeMode: ThemeMode.system,
      darkTheme: TFlexTheme.darkTheme,
      theme: TFlexTheme.lightTheme,
      home: const MyHomePage(),
    );
  }
}
