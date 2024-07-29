import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/firebase_options.dart';
import 'package:flutter_food/views/bottom_navigation_bar.dart';
import 'package:flutter_food/views/edit_food_screen/edit_food_page.dart';
import 'package:flutter_food/views/home_screen/home_page.dart';
import 'package:flutter_food/views/login_screen/login_page.dart';
import 'package:flutter_food/views/post_food_screen/post_food_page.dart';
import 'package:flutter_food/views/registration_screen/registration_page.dart';
import 'package:flutter_food/views/user_screen/edit_profile_infos.dart';
import 'package:flutter_food/views/user_screen/user_page.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

class Stream extends StatelessWidget {
  const Stream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const GoogleNavBar();
          } else {
            return LoginPage.create();
          }
        });
  }
}

final _router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return const Stream();
      },
    ),
    GoRoute(
      path: '/editProfilePage',
      builder: (context, state) => EditProfileInfos.create(),
    ),
    GoRoute(
      path: '/editFoodPage',
      builder: (context, state) => EditFoodPage.create(),
    ),
    GoRoute(
      path: '/registPage',
      builder: (context, state) => RegistrationPage.create(),
    ),
    GoRoute(
      path: '/postFoodPage',
      builder: (context, state) => PostFoodPage.create(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage.create(),
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return const GoogleNavBar();
        },
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) {
                return HomePage.create();
              },
            ),
            GoRoute(
              path: '/userPage',
              builder: (context, state) => UserPage.create(),
            ),
          ])
        ])
  ],
);

final _rootNavigatorKey = GlobalKey<NavigatorState>();
//final _rootNavigatorKeyHome = GlobalKey<NavigatorState>();
//final _shellNavigatorKey = GlobalKey<NavigatorState>();

int selectedPage = 0;
