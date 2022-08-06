import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moviestream/screens/HomeScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class OnboardingScreen extends StatefulWidget {

  const  OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _register() async {
    final User user = (
        await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)
    ).user!;

    if(user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    }
  }

  void _singIn() async {
    final User user = (await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text)).user!;

    if(user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  Widget _renderSignIn() {
    return Container(
      padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          TextField(
            controller: _emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Correo',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          Container(
            height: 0.1,
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Contraseña',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: const BorderSide(width: 1.0, color: Colors.grey),
              ),
              child: const Text(
                "Iniciar Sesión",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0
                ),
              ),
              onPressed: () async {
                final email = _emailController.text;
                final password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  showDialog(context: context, builder: (_) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Vuelve a ingresar tu correo y contraseña'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () =>  Navigator.of(context, rootNavigator: true).pop('dialog'),
                      )
                    ],
                  ));

                  return;
                }

                _singIn();


              },
            ),
          ),
          const SizedBox(height: 40.0),
          MaterialButton(
            child: const Text(
              "No tienes una cuenta? Registrate",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _renderSignUp() {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          const SizedBox(height: 60),
          TextField(
            controller: _nameController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Nombre',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          Container(
            height: 0.1,
            color: Colors.black,
          ),
          TextField(
            controller: _emailController,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Correo',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          Container(
            height: 0.1,
            color: Colors.black,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            autofocus: false,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.grey,
              labelText: 'Contraseña',
              floatingLabelStyle: TextStyle(color: Colors.black),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
            ),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                side: const BorderSide(width: 1.0, color: Colors.grey),
              ),
              child: const Text(
                "Registrarse",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0
                ),
              ),
              onPressed: () async {
                final name = _nameController.text;
                final email = _emailController.text;
                final password = _passwordController.text;

                if (email.isEmpty || password.isEmpty) {
                  showDialog(context: context, builder: (_) => AlertDialog(
                    title: const Text('Error'),
                    content: const Text('Vuelve a ingresar tu correo y contraseña'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () => Navigator.of(context, rootNavigator: true).pop('dialog'),
                      )
                    ],
                  ));

                  return;
                }

                _register();
              },
            ),
          ),
          const SizedBox(height: 40.0),
          MaterialButton(
            child: const Text(
              "Ya tienes una cuenta? Iniciar sesión",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;


    _emailController.text = "";

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            _renderSignIn(),
            _renderSignUp(),
          ],
        )
    );
  }
}
