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
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        title: const Text(
          'Login',
          textScaler: TextScaler.linear(1.2),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                controller: textEmailController,
                style: const TextStyle(fontSize: 18, color: Colors.white),
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white),
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
                style: const TextStyle(fontSize: 18, color: Colors.white),
                obscureText: store!.passwordVisibility,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    hintStyle:
                        const TextStyle(fontSize: 18, color: Colors.white),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            store!.passwordVisibility =
                                !store!.passwordVisibility;
                          });
                        },
                        icon: store!.passwordVisibility == false
                            ? const Icon(Icons.visibility, color: Colors.white)
                            : const Icon(Icons.visibility_off, color: Colors.white))),
                onSubmitted: (value) => login(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white)),
                onPressed: () => login(),
                child: const Text(
                  textScaler: TextScaler.linear(1.2),
                  'Login',
                  style: TextStyle(color: Colors.black),
                )),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white)),
                onPressed: () {
                  context.go('/registPage');
                },
                child: const Text(
                  textScaler: TextScaler.linear(1.2),
                  'Registration page',
                  style: TextStyle(color: Colors.black),
                ))
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
