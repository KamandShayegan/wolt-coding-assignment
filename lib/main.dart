import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt/services/local_storage_service.dart';
import 'package:wolt/services/looper.dart';
import 'package:wolt/viewmodels/base_viewmodel.dart';
import 'package:wolt/views/venue_page.dart';

void main() async {
  //manual DI
  final dio = Dio();
  final LoopingService loopingService = LoopingService();
  WidgetsFlutterBinding.ensureInitialized();
  final localStorageService = LocalStorageService();
  await localStorageService.initializeStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BaseViewmodel(dio, loopingService),
        ),
      ],
      builder: (context, widget) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wolts Flutter Assignment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade500),
        useMaterial3: true,
      ),
      home: const VenuePage(),
    );
  }
}
