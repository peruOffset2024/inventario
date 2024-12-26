import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla/providers/auth_provider.dart';
import 'package:tesla/views/diferencias.dart';
import 'package:tesla/views/iniciar_sesion.dart';
import 'package:tesla/views/qr.dart';
import 'package:tesla/views/tabla_apuntes.dart';


class NavegacionIndex extends StatefulWidget {
  const NavegacionIndex({super.key});

  @override
  State<NavegacionIndex> createState() => _NavegacionIndexState();
}

class _NavegacionIndexState extends State<NavegacionIndex> {
  int ind = 0;
  List<Widget> rutas = [
    const ItemConDiferencias(),
    const ConsultayQr(),
    const PizarraApuntes(),
    const Text('Apuntes')
  ];

  Future<void> _mostrarAlerta() async {
    bool? salir = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmación'),
            content: const Text("¿Deseas salir de la sesión?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text('Salir'))
            ],
          );
        });
    if (salir == true) {
      context.read<AuthProvider>().logout();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
          (Route<dynamic> route) => false);
    }
  }

  void _pagSeleccionado(int index){
    if(index == 3){
      _mostrarAlerta();
    } else {
      setState(() {
        ind = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: rutas[ind],
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.only(bottom: 2),
        child: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.blue),
          selectedLabelStyle: TextStyle(color: Colors.blue),
            elevation: 50,
            onTap: _pagSeleccionado,
            currentIndex: ind,
            unselectedItemColor: Colors.amber,
            selectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                  label: 'Items',
                  icon: Icon(Icons.edit_document,
                      color: ind == 0 ? Colors.amber : Colors.black, size: 33)),
              BottomNavigationBarItem(
                  label: 'Qr',
                  icon: Icon(Icons.qr_code_2_outlined,
                      color: ind == 1 ? Colors.amber : Colors.black, size: 33,)),
              BottomNavigationBarItem(
                  label: 'Pizarra',
                  icon: Icon(Icons.app_registration_outlined,
                      color: ind == 2 ? Colors.amber : Colors.black, size: 33)),
              BottomNavigationBarItem(
                  label: 'Salir',
                  icon: Icon(Icons.exit_to_app,
                      color: ind == 3 ? Colors.amber : Colors.black, size: 33))
            ]),
      ),
    );
  }
}
