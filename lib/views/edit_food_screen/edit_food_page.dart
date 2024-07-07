import 'package:flutter/material.dart';
import 'package:flutter_food/services/food_service.dart';
import 'package:flutter_food/views/edit_food_screen/edit_food_store.dart';
import 'package:provider/provider.dart';

class EditFoodPage extends StatefulWidget {
  const EditFoodPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => EditFoodStore(service: FoodService()),
      child: const EditFoodPage(),
    );
  }

  @override
  State<EditFoodPage> createState() => _EditFoodPageState();
}

class _EditFoodPageState extends State<EditFoodPage> {
  EditFoodStore? store;

  @override
  void initState() {
    store = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = context.read();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Food'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            ListView.builder(
              itemCount: store!.foods.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    
                  ],
                );
            })
          ],),
        ),
      ),
    );
  }
}
