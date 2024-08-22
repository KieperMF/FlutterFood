import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';
import 'package:flutter_food/views/user_screen/user_store.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditProfileInfos extends StatefulWidget {
  const EditProfileInfos({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => UserStore(service: UserService()),
      child: const EditProfileInfos(),
    );
  }

  @override
  State<EditProfileInfos> createState() => _EditProfileInfosState();
}

class _EditProfileInfosState extends State<EditProfileInfos> {
  UserStore? store;
  TextEditingController cepText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
  TextEditingController streetText = TextEditingController();
  TextEditingController stateText = TextEditingController();
  TextEditingController neighborhoodText = TextEditingController();
  TextEditingController cityText = TextEditingController();

  @override
  void initState() {
    store = context.read<UserStore>();
    load();
    super.initState();
  }

  Future<void> load() async {
    await store!.getUser();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        title: const Text(
          'Edit',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      body: RefreshIndicator(
        onRefresh: load,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Image.network(
                      '${store!.userModel.userPic}',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.image_not_supported_rounded,
                          size: 100,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          return const Icon(
                            Icons.image,
                            size: 100,
                          );
                        } else {
                          return child;
                        }
                      },
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () {
                      store!.getImageFromGalery();
                    },
                    child: const Text(
                      'Change Profile Photo',
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(color: Colors.black),
                    )),
                Text(
                  textScaler: const TextScaler.linear(1.2),
                  store!.userModel.name ?? '',
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.maybeOf(context)!.size.width / 2.2,
                      height: 45,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: stateText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: store!.userModel.state ?? 'State',
                          hintStyle: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.maybeOf(context)!.size.width / 2.2,
                      height: 45,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: cityText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: store!.userModel.city ?? 'City',
                          hintStyle: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.maybeOf(context)!.size.width / 2.2,
                      height: 45,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: neighborhoodText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText:
                              store!.userModel.neighborhood ?? 'Neighborhood',
                          hintStyle: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.maybeOf(context)!.size.width / 2.2,
                      height: 45,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: streetText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: store!.userModel.street ?? 'Street',
                          hintStyle: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: MediaQuery.maybeOf(context)!.size.width / 2.2,
                        height: 45,
                        child: TextField(
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          controller: cepText,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'CEP',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        child: TextButton(
                          onPressed: () {
                            store!.getCep(cepText.text);
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(
                                  const Color.fromRGBO(51, 65, 85, 1))),
                          child: const Text(
                            textScaler: TextScaler.linear(1),
                            'Search by CEP',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: MediaQuery.maybeOf(context)!.size.width / 2.2,
                        height: 45,
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          controller: phoneText,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Phone',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: 140,
                        child: TextButton(
                            onPressed: () {
                              store!.updateInfos(
                                  cityText.text,
                                  stateText.text,
                                  streetText.text,
                                  neighborhoodText.text,
                                  phoneText.text);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Infos Updated', textScaler: TextScaler.linear(1.5),),
                                duration: Duration(seconds: 2),
                                dismissDirection: DismissDirection.horizontal,
                              ));
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    const Color.fromRGBO(51, 65, 85, 1))),
                            child: const Text(
                              textScaler: TextScaler.linear(1),
                              'UPDATE',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
