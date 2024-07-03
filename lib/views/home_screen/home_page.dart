import 'package:flutter/material.dart';
import 'package:flutter_food/services/auth_service.dart';
import 'package:flutter_food/views/home_screen/home_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Widget create(){
    return ChangeNotifierProvider(create: (_) => HomeStore(service: AuthService()), 
    child: const HomePage(),);
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore? store;

  @override
  void initState() {
    store = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),
      automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}