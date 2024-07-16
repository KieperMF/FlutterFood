import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';
import 'package:flutter_food/views/edit_food_screen/edit_food_page.dart';
import 'package:flutter_food/views/post_food_screen/post_food_page.dart';
import 'package:flutter_food/views/user_screen/user_store.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => UserStore(service: UserService()),
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
            if (store!.user!.uid == 'bp8uHbiLzAOOQvEBm9FTy4uylFt2') ...[
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'add') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PostFoodPage.create()));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditFoodPage.create()));
                      }
                    },
                    constraints: const BoxConstraints(maxWidth: 50),
                    offset: const Offset(10, -115),
                    itemBuilder: (BuildContext bc) {
                      return const [
                        PopupMenuItem(
                          value: 'add',
                          child: Icon(Icons.add),
                        ),
                        PopupMenuItem(
                          value: 'edit',
                          child: Icon(Icons.edit_note_rounded),
                        ),
                      ];
                    },
                    child: const Icon(
                      Icons.edit_document,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      )),
    );
  }
}
