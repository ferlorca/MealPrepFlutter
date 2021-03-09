import 'package:flutter/material.dart';
import 'package:mealprepapp/models/providers/user_data.dart';
import 'package:mealprepapp/screens/error_screen.dart';
import 'package:mealprepapp/screens/home_screen.dart';
import 'package:mealprepapp/screens/initial_screen.dart';
import 'package:mealprepapp/screens/login_screen.dart';
import 'package:mealprepapp/screens/logout_screen.dart';
import 'package:provider/provider.dart';

import 'models/providers/auth_data.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(MealPrepApp());
}

class MealPrepApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthData()),
        ChangeNotifierProvider(create: (_) => UserData()),
      ], //kProviders(context),
      child: MaterialApp(
        title: 'Meal Prep App',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.blueGrey.shade200,
          appBarTheme: AppBarTheme.of(context).copyWith(
            color: Colors.blueGrey.shade900,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          canvasColor: Colors.blueGrey[700],
        ),
        initialRoute: InitialScreen.route,
        routes: {
          InitialScreen.route: (context) => InitialScreen(),
          HomeScreen.route: (context) => HomeScreen(),
          LoginScreen.route: (context) => LoginScreen(),
          LogoutScreen.route: (context) => LogoutScreen(),
          ErrorScreen.route: (context) => ErrorScreen(),
        },
      ),
    );
  }
}
