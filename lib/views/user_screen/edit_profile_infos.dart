import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';
import 'package:flutter_food/views/user_screen/user_store.dart';
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
        title: const Text('Edit'),
      ),
      body: RefreshIndicator(
        onRefresh: load,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                    height: 150,
                    width: 120,
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
                TextButton(
                    onPressed: () {
                      store!.getImageFromGalery();
                    },
                    child: const Text('Change Profile Photo')),
                Text(
                  store!.userModel.name ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 45,
                      child: TextField(
                        controller: stateText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: store!.userModel.state ?? 'State',
                          hintStyle:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    SizedBox(
                      width: 180,
                      height: 45,
                      child: TextField(
                        controller: cityText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: store!.userModel.city ?? 'City',
                          hintStyle:
                              const TextStyle(fontSize: 18, color: Colors.grey),
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
                      width: 180,
                      height: 45,
                      child: TextField(
                        controller: neighborhoodText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText:
                              store!.userModel.neighborhood ?? 'Neighborhood',
                          hintStyle:
                              const TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    SizedBox(
                      width: 180,
                      height: 45,
                      child: TextField(
                        controller: streetText,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: store!.userModel.street ?? 'Street',
                          hintStyle:
                              const TextStyle(fontSize: 18, color: Colors.grey),
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
                        width: 180,
                        height: 45,
                        child: TextField(
                          style: const TextStyle(fontSize: 18),
                          controller: cepText,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'CEP',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
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
                        width: 180,
                        height: 45,
                        child: TextField(
                          controller: phoneText,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Phone',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey),
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
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    const Color.fromRGBO(51, 65, 85, 1))),
                            child: const Text(
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
