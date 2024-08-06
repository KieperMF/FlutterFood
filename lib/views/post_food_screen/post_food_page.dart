import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_food/services/food_service.dart';
import 'package:flutter_food/views/post_food_screen/post_food_store.dart';
import 'package:go_router/go_router.dart';
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
  TextEditingController nameTextEditing = TextEditingController();
  TextEditingController descriptionTextEditing = TextEditingController();
  TextEditingController priceTextEditing = TextEditingController();
  TextEditingController avaliationTextEditing = TextEditingController();
  TextEditingController categoryTextEditing = TextEditingController();
  TextEditingController idTextEditing = TextEditingController();
  String dropDownValue = 'Hamburger';

  @override
  void initState() {
    store = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Food',textScaler: TextScaler.linear(1), style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white,)),
      ),
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              store!.food.foodImage == null
                  ? const SizedBox(
                      width: 200,
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                        size: 100,
                      ))
                  : SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.network(
                        fit: BoxFit.cover,
                        '${store!.food.foodImage}',
                        errorBuilder: (context, error, stackTrace) {
                          return Image.file(File('${store!.food.foodImage}'));
                        },
                      )),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 170,
                child: ElevatedButton(
                    onPressed: () async {
                      final respImage = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      store!.getFoodImage(respImage!.path);
                    },
                    child: const Text('Select image', textScaler: TextScaler.linear(1),style: TextStyle(color: Colors.black, fontSize: 20),)),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  style:const TextStyle(color: Colors.white),
                    controller: nameTextEditing,
                    decoration: const InputDecoration(hintText: 'Food Name', hintStyle: TextStyle(color: Colors.white))),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  style:const TextStyle(color: Colors.white),
                    controller: priceTextEditing,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(hintText: 'Price',hintStyle: TextStyle(color: Colors.white))),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 250,
                child: TextField(
                  style:const TextStyle(color: Colors.white),
                    controller: descriptionTextEditing,
                    decoration: const InputDecoration(hintText: 'Description',hintStyle: TextStyle(color: Colors.white))),
              ),
              const SizedBox(
                height: 15,
              ),
              DropdownButton<String>(
                  value: dropDownValue,
                  style: const TextStyle(color: Colors.white),dropdownColor: Colors.black,
                  items: store!.categories
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  }),
              const SizedBox(
                height: 15,
              ),
              IconButton(
                  onPressed: () async {
                    post();
                    if (store!.postVerif) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sucess on Add Food')));
                    }
                  },
                  icon: const Icon(Icons.add_box_rounded, color: Colors.white,)),
            ],
          ),
        ),
      ),
    );
  }

  post() {
    store!.food.name = nameTextEditing.text;
    store!.food.description = descriptionTextEditing.text;
    store!.food.category = dropDownValue;
    store!.food.price = double.parse(priceTextEditing.text);
    store!.postFood();
  }
}
