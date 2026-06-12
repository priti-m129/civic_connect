import 'package:civic_connect/createaccount.dart';
import 'package:civic_connect/homepage.dart';
import 'package:civic_connect/myreport.dart';
import 'package:civic_connect/reportissue.dart' as report_dashboard;
import 'package:civic_connect/issuepage.dart';
import 'package:civic_connect/community.dart';
import 'package:civic_connect/member.dart';
import 'package:civic_connect/notification.dart';
import 'package:civic_connect/signin.dart';
import 'package:civic_connect/startpage.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://xurqnwawmmkxtkdbyqzs.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh1cnFud2F3bW1reHRrZGJ5cXpzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg0MzQ3MzYsImV4cCI6MjA3NDAxMDczNn0.I2xRwL9DI4lDhZ0Inmk3NCyvrlRUwN3ACrLvHBYXVhQ',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CivicConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      initialRoute: '/start',
      routes: {
        '/start': (context) => const StartPage(),
        '/create-account': (context) => const CreateAccountPage(),
        '/signin': (context) => const SignInPage(),
        '/home': (context) => const HomePage(),
        '/report-issue': (context) => const report_dashboard.ReportIssuePage(),
        '/issue-form': (context) => const ReportIssuePage(),
        '/community': (context) => const CommunityPage(),
        '/member': (context) => const MemberPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/my-reports': (context) => const MyReportsPage(),
      },
    );
  }
}
