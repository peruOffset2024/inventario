import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tesla/providers/auth_provider.dart';
import 'package:tesla/views/navegacion_index.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _insertName = TextEditingController();
  final TextEditingController _insertPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  void dispose() {
    _insertName.dispose();
    _insertPassword.dispose();
    super.dispose();
  }
  void _mostrarContrasenia() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 249, 168, 37), Color.fromARGB(255, 236, 239, 241)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter
          )
           ),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: const TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: 'D',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                offset: Offset(3.0, 3.0), color: Colors.white)
                          ])),
                  TextSpan(
                      text: "'",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                offset: Offset(3.0, 3.0), color: Colors.black)
                          ])),
                  TextSpan(
                      text: 'L',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                offset: Offset(3.0, 3.0), color: Colors.black)
                          ])),
                  TextSpan(
                      text: 'O',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                offset: Offset(3.0, 3.0), color: Colors.black)
                          ])),
                  TextSpan(
                      text: 'G',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                offset: Offset(3.0, 3.0), color: Colors.black)
                          ]))
                ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                        text: const TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: 'V',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    offset: Offset(1.0, 1.0),
                                    color: Colors.white)
                              ])),
                      TextSpan(
                          text: '2.0',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                    offset: Offset(1.0, 1.0),
                                    color: Colors.white)
                              ])),
                    ])),
                    const Text('                      ')
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorErrorColor: Colors.black,
                        cursorColor: Colors.black,
                        controller: _insertName,
                        keyboardType: TextInputType.number,
                        maxLength: 15,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                        ],
                        decoration: InputDecoration(
                          hintText: 'Usuario',
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1)),
                          fillColor: Colors.grey[200],
                          filled: true,
                          // contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                        ),
                      ),
                      TextFormField(
                        cursorColor: Colors.black,
                        controller: _insertPassword,
                        obscureText: _obscureText,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Monospace'),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: _mostrarContrasenia,
                              icon: const Icon(
                                Icons.remove_red_eye_sharp,
                                color: Colors.black,
                              )),
                          
                          hintText: 'Contraseña',
                          hintStyle: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1)),
                          fillColor: Colors.grey[200],
                          filled: true,
                          //contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: size.width * 0.5,
                  height: 60,
                  child: Consumer<AuthProvider>(
                    builder: (context, athenticad, child) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 10,
                              backgroundColor: Colors.black,
                              side: const BorderSide(
                                  color: Color.fromARGB(255, 249, 168, 37),
                                  width: 4)),
                          onPressed: athenticad.isAuthenticated
                              ? () {
                                print('error: -1>>> ${athenticad.isAuthenticated}');
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NavegacionIndex()));
                                }
                              : () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    try {
                                      print('error: -2>>> ${athenticad.isAuthenticated}');
                                      await athenticad.login(_insertName.text,
                                          _insertPassword.text);
                                      if (athenticad.isAuthenticated) {
                                        print('error: -3>>> ${athenticad.isAuthenticated}');
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const NavegacionIndex()));
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Datos invalidos')));
                                      }
                                    } catch (err) {
                                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Falló la autenticación: $err')));
                                    }
                                  }
                                },
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(color: Colors.white),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
