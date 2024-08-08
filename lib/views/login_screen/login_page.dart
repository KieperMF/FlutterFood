import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';
import 'package:flutter_food/views/login_screen/login_store.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => LoginStore(service: UserService()),
      child: const LoginPage(),
    );
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginStore? store;
  final textNameController = TextEditingController();
  final textEmailController = TextEditingController();
  final textPasswordController = TextEditingController();

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
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: textEmailController,
                style: const TextStyle(fontSize: 18),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 18),
                  hintText: 'Email',
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: textPasswordController,
                style: const TextStyle(fontSize: 18),
                obscureText: store!.passwordVisibility,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontSize: 18),
                  hintText: 'Password',
                  suffixIcon: IconButton(onPressed: (){
                    setState(() {
                      store!.passwordVisibility = !store!.passwordVisibility;
                    });
                  }, icon: store!.passwordVisibility == false ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility))
                ),
                onSubmitted: (value) => login(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(onPressed: () => login(), 
            child: const Text('Login')),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {
                  context.go('/registPage');
                },
                child: const Text('Registration page'))
          ],
        ),
      ),
    );
  }

  void login() async {
    await store!.loginVerification(
        textEmailController.text, textPasswordController.text);
    if (store!.loginVerif) {
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid Credentials'),
        duration: Duration(milliseconds: 1000),
      ));
    }
  }
}
