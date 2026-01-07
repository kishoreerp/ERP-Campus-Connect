import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/slec_home_screen.dart';
import 'screens/student_portal/student_portal_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

/// ------------------------------------------------------------
/// AUTH GATE (AUTO LOGIN LOGIC)
/// ------------------------------------------------------------
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _decide();
  }

  Future<void> _decide() async {
    final prefs = await SharedPreferences.getInstance();

    final rememberMe = prefs.getBool('rememberMe') ?? false;
    final role = prefs.getString('userRole');

    debugPrint('REMEMBER ME: $rememberMe');
    debugPrint('USER ROLE: $role');

    if (!mounted) return;

    if (rememberMe && role == 'student') {
      Navigator.pushReplacementNamed(context, '/student');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}


/// ------------------------------------------------------------
/// APP ROOT
/// ------------------------------------------------------------
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SLEC Campus Connect',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.white,
        dialogBackgroundColor: Colors.white,
        canvasColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepPurple,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          brightness: Brightness.light,
        ).copyWith(surface: Colors.white),
      ),

      /// 🔑 ENTRY POINT
      initialRoute: '/',
routes: {
  '/': (context) => const AuthGate(),
  '/home': (context) => const SlecHomeScreen(),
  '/student': (context) => const StudentPortalScreen(),
},

    );
  }
}
