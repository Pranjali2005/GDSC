import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:bmipro/main.dart';
import 'package:bmipro/splash_screen.dart';
import 'package:bmipro/login_page.dart';
import 'package:bmipro/signup_page.dart';
import 'package:bmipro/forgot_password_page.dart';
import 'package:bmipro/user_details_page.dart';
import 'package:bmipro/bmi_calculator_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('App Launch Tests', () {
    testWidgets('App starts with SplashScreen', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      expect(find.byType(SplashScreen), findsOneWidget);
    });
  });

  group('SplashScreen Tests', () {
    testWidgets('Transitions to LoginPage after delay', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SplashScreen()));
      expect(find.byType(LoginPage), findsNothing);

      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });
  });

  group('LoginPage Tests', () {
    testWidgets('Renders LoginPage UI', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('Shows validation errors', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('Navigates to SignUpPage', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.byType(SignUpPage), findsOneWidget);
    });

    testWidgets('Navigates to ForgotPasswordPage', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();

      expect(find.byType(ForgotPasswordPage), findsOneWidget);
    });
  });

  group('SignUpPage Tests', () {
    testWidgets('Renders SignUpPage UI', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignUpPage()));
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
    });

    testWidgets('Shows password mismatch error', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SignUpPage()));
      await tester.enterText(find.byType(TextFormField).at(1), 'pass123');
      await tester.enterText(find.byType(TextFormField).at(2), 'diffpass');
      await tester.tap(find.text('Sign Up'));
      await tester.pump();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });
  });

  group('ForgotPasswordPage Tests', () {
    testWidgets('Renders ForgotPasswordPage UI', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ForgotPasswordPage()));
      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.byType(TextFormField), findsOneWidget);
    });

    testWidgets('Shows validation error', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: ForgotPasswordPage()));
      await tester.tap(find.text('Send Reset Link'));
      await tester.pump();

      expect(find.text('Please enter your email'), findsOneWidget);
    });
  });

  group('UserDetailsPage Tests', () {
    testWidgets('Renders UserDetailsPage UI', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: UserDetailsPage()));
      expect(find.text('Tell us about yourself'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });
  });

  group('BMICalculatorPage Tests', () {
    testWidgets('Renders user info correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: BMICalculatorPage(
          userName: 'Test User',
          userAge: 28,
          userGender: 'Other',
        ),
      ));

      expect(find.textContaining('Test User'), findsOneWidget);
      expect(find.textContaining('28'), findsOneWidget);
    });

    testWidgets('Calculates BMI correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: BMICalculatorPage(
          userName: 'Test',
          userAge: 25,
          userGender: 'Female',
        ),
      ));

      await tester.enterText(find.byType(TextFormField).at(0), '160');
      await tester.enterText(find.byType(TextFormField).at(1), '60');
      await tester.tap(find.text('Calculate BMI'));
      await tester.pump();

      expect(find.textContaining('23'), findsOneWidget); // BMI ~23.4
    });
  });
}
