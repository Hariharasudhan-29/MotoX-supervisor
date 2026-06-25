import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.deepBlack,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const EliteAutoCareApp());
}

class EliteAutoCareApp extends StatelessWidget {
  const EliteAutoCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'motoX',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.luxuryTheme,
      home: const LoginScreen(),
    );
  }
}
