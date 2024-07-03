import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_food/services/food_service.dart';
import 'package:flutter_food/views/post_food_screen/post_food_store.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PostFoodPage extends StatefulWidget {
  const PostFoodPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => PostFoodStore(service: FoodService()),
      child: const PostFoodPage(),
    );
  }

  @override
  State<PostFoodPage> createState() => _PostFoodPageState();
}

class _PostFoodPageState extends State<PostFoodPage> {
  PostFoodStore? store;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController avaliation = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController id = TextEditingController();

  @override
  void initState() {
    store = context.read();
    store!.getLength();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Food'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              store!.food.foodImage == null
                  ? const SizedBox(width: 200, child: Icon(Icons.image))
                  : SizedBox(
                      width: 200,
                      child: Image.network(
                        '${store!.food.foodImage}',
                        errorBuilder: (context, error, stackTrace) {
                          return Image.file(File('${store!.food.foodImage}'));
                        },
                      )),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                    onPressed: () async {
                      final respImage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      store!.getFoodImage(respImage!.path);
                    },
                    child: const Text('Select image')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
