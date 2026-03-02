import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/current_user_service.dart';


import 'firebase_options.dart';

// ================= IMPORT SCREENS =================
import 'screens/slec_home_screen.dart';
import 'screens/student_portal/student_portal_screen.dart';

// HOD ATTENDANCE
import 'screens/hod_portal/hod_mark_attendance_screen.dart';
import 'screens/hod_portal/hod_view_attendance_screen.dart';

// HOD MARKS
import 'screens/hod_portal/hod_marks_screen.dart';
import 'screens/hod_portal/hod_department_marks_screen.dart';
import 'screens/hod_portal/hod_university_results_screen.dart';


// ==================================================
// GLOBAL NAVIGATOR KEY (KEEP FROM TEAMMATE CODE)
// ==================================================
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>();

// ==================================================
// MAIN
// ==================================================
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
 );

  runApp(const MyApp());
}

// ==================================================
// AUTH GATE (AUTO LOGIN LOGIC)
// ==================================================
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
        await CurrentUserService.loadUser();
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

// ==================================================
// APP ROOT
// ==================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: rootNavigatorKey,
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

      // 🔑 ENTRY POINT
      initialRoute: '/',

      // ================= ROUTES =================
      routes: {
        '/': (context) => const AuthGate(),

        // COMMON
        '/home': (context) => const SlecHomeScreen(),

        // STUDENT
        '/student': (context) => const StudentPortalScreen(),

        // HOD ATTENDANCE
        '/hod-mark-attendance': (context) =>
            const HODMarkAttendanceScreen(),
        '/hod-view-attendance': (context) =>
            const HODViewAttendanceScreen(),

        // HOD MARKS
        '/hod-marks': (context) => const HODMarksScreen(),
        '/hod-department-marks': (context) =>
            const HODDepartmentMarksScreen(),
        '/hod-university-results': (context) =>
            const HODUniversityResultsScreen(),

      },
    );
  }
}
