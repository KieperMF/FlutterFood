import 'package:flutter/material.dart';
import 'package:flutter_food/services/auth_service.dart';
import 'package:flutter_food/views/post_food_screen/post_food_page.dart';
import 'package:flutter_food/views/user_screen/user_store.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => UserStore(service: AuthService()),
      child: const UserPage(),
    );
  }

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserStore? store;

  @override
  void initState() {
    store = context.read();
    store!.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                store!.logout();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: Stack(
          children: [
            Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text("${store!.user!.displayName}"))
              ],
            ),
            if (store!.user!.uid == 'yotJvtOaigbaK0AYG5bHyVuKUvG2') ...[
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostFoodPage.create()));
                      },
                      icon: const Icon(Icons.edit)),
                ),
              )
            ]
          ],
        ),
      )),
    );
  }
}
