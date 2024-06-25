import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wolt/services/local_storage_service.dart';
import 'package:wolt/viewmodels/base_viewmodel.dart';
import 'package:wolt/views/venue_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final localStorageService = LocalStorageService();
  await localStorageService.initializeStorage();
  runApp(
    ChangeNotifierProvider(
        create: (_) => BaseViewmodel(), child: const MyApp()),
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
