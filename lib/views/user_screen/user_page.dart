import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';
import 'package:flutter_food/views/user_screen/user_store.dart';
import 'package:go_router/go_router.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = context.read<UserStore>();
    load();
  }

  Future<void> load() async {
    await store!.getUser();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              color: Colors.white,
              onPressed: () {
                store!.logout();
              },
              icon: const Icon(Icons.logout)),
        ],
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      ),
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      body: SafeArea(
          child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.amberAccent,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        height: 150,
                        width: 170,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            '${store!.userModel.userPic}',
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.image,
                                size: 140,
                                color: Colors.white,
                              );
                            },
                            fit: BoxFit.cover,
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          store!.userModel.name ?? '',
                          style: const TextStyle(
                              fontSize: 22, color: Colors.white),
                        )),
                    const SizedBox(
                      height: 30,
                      child: Divider(thickness: 2,endIndent: 10,indent: 10,),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text(
                            store!.userModel.state != null
                                ? 'State: ${store!.userModel.state} '
                                : 'State:',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            store!.userModel.city != null
                                ? 'City: ${store!.userModel.city}'
                                : 'City:',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                        padding: EdgeInsets.all(10),
                        child: Divider(
                          thickness: 2,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text(
                            store!.userModel.neighborhood != null
                                ? 'Neighborhood: ${store!.userModel.neighborhood}'
                                : 'Neighborhood: ',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 150,
                          child: Text(
                            store!.userModel.neighborhood != null
                                ? 'Street: ${store!.userModel.street}'
                                : 'Street:',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                        padding: EdgeInsets.all(10),
                        child: Divider(
                          thickness: 2,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text(
                            store!.userModel.email ?? 'Email',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 150,
                          child: ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Color.fromRGBO(250, 240, 21, 1))),
                              onPressed: () {
                                context.push('/editProfilePage');
                              },
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18),
                              )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (store!.user!.uid == 'bp8uHbiLzAOOQvEBm9FTy4uylFt2') ...[
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'add') {
                        context.push('/postFoodPage');
                      } else {
                        context.push('/editFoodPage');
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
                      color: Colors.white,
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
