import 'package:flutter/material.dart';
import 'package:flutter_food/views/food_screen/food_page.dart';
import 'package:flutter_food/views/home_screen/home.dart';
import 'package:flutter_food/views/edit_food_screen/edit_food_page.dart';
import 'package:flutter_food/views/home_screen/home_page.dart';
import 'package:flutter_food/views/login_screen/login_page.dart';
import 'package:flutter_food/views/post_food_screen/post_food_page.dart';
import 'package:flutter_food/views/registration_screen/registration_page.dart';
import 'package:flutter_food/views/user_screen/edit_profile_infos.dart';
import 'package:flutter_food/views/user_screen/user_page.dart';
import 'package:flutter_food/widgets/router/router_guarder.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: navigatorKey,
  routes: [
    ShellRoute(
      routes: [
        ShellRoute(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder: (context, state) {
                return MaterialPage(
                    child: HomePage.create(),
                    fullscreenDialog: true,
                    maintainState: true);
              },
            ),
            GoRoute(
              path: '/userPage',
              pageBuilder: (context, state) => MaterialPage(
                  child: UserPage.create(),
                  fullscreenDialog: true,
                  maintainState: true),
            ),
          ],
          builder: (context, state, child,) => const HomeScreen(),
        ),
        GoRoute(
          path: '/foodPage',
          pageBuilder: (context, state) => MaterialPage(
              child: FoodPage.create(), fullscreenDialog: true),
        ),
        GoRoute(
          path: '/editProfilePage',
          pageBuilder: (context, state) => MaterialPage(
              child: EditProfileInfos.create(), fullscreenDialog: true),
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
      ],
      builder: (context, state, child) {
        return RouterGuarder.create(child);
      },
    ),
  ],
);
