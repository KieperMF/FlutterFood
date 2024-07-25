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

  @override
  void initState() {
    store = context.read();
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
          physics:const AlwaysScrollableScrollPhysics(),
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
                        if(loadingProgress != null){
                          return const Icon(
                          Icons.image,
                          size: 100,
                        );
                        }else{
                          return child;
                        }
                      },
                      fit: BoxFit.cover,
                    )),
                    TextButton(onPressed: (){
                      store!.getImageFromGalery();
                    }, child:const Text('Change Profile Photo')),
                Text(store!.userModel.name ?? ''),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
