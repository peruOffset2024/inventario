import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla/providers/auth_provider.dart';
import 'package:tesla/providers/imagenes_provider.dart';
import 'package:tesla/providers/insertar_ubicacion_provider.dart';
import 'package:tesla/providers/zona_stand_provider.dart';
import 'package:tesla/views/shake_transicion.dart';

class NuevaUbicacion extends StatefulWidget {
  const NuevaUbicacion(
      {super.key, required this.codigo, required this.descripcion});
  final String codigo;
  final String descripcion;

  @override
  State<NuevaUbicacion> createState() => _NuevaUbicacionState();
}

class _NuevaUbicacionState extends State<NuevaUbicacion> {
  final TextEditingController _cantidadInsertada = TextEditingController();

  final List<String> _fila = [
    'A',
    'B',
    'C',
    'D',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'PISO'
  ];
  final List<String> _columna = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    'PISO'
  ];

  // ignore: non_constant_identifier_names
  String? _ZonaSeleccionado;
  // ignore: non_constant_identifier_names
  String? _StandSeleccionado;
  // ignore: non_constant_identifier_names
  String? _FilaSeleccionado;
  // ignore: non_constant_identifier_names
  String? _ColumnaSeleccionado;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ImagenesProvider>().limpiarImagenes();
      context.read<ZonaProvider>().zonaUbicacion();
      context.read<StandProvider>().standUbicacion();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imagenes = context.watch<ImagenesProvider>();
    final zona = context.watch<ZonaProvider>().zona;
    final stand = context.watch<StandProvider>().stand;
    final usuario = context.watch<AuthProvider>().username;

    return Scaffold(
      appBar: AppBar(
        title: ShakeWidget(
          child: Text(
            'COD. SBA: ${widget.codigo}',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            children: [
              Center(
                child: Text(
                  widget.descripcion,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              _comboBox('ZONA', zona, _ZonaSeleccionado, (String? valorNuevo) {
                _ZonaSeleccionado = valorNuevo;
              }),
              const SizedBox(height: 20),
              _comboBox('STAND', stand, _StandSeleccionado,
                  (String? valorNuevo) {
                _StandSeleccionado = valorNuevo;
              }),
              const SizedBox(height: 20),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: _comboBox('COLUMNA', _columna, _ColumnaSeleccionado,
                        (String? valorNuevo) {
                      _ColumnaSeleccionado = valorNuevo;
                    }),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    fit: FlexFit.loose,
                    child: _comboBox('FILA', _fila, _FilaSeleccionado,
                        (String? valorNuevo) {
                      _FilaSeleccionado = valorNuevo;
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _cantidadInsertada,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'CANTIDAD',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.numbers_sharp)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _mostrarOpcionesDeImagenes(imagenes);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 30,
                      color: Color.fromARGB(255, 117, 117, 117),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Adjuntar Imagen')
                  ],
                ),
              ),
              const SizedBox(height: 20),
              imagenes.cargando
                  ? const CircularProgressIndicator()
                  : _mostrarImagenes(imagenes),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ShakeWidget(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 5,
                backgroundColor: Colors.orange,
                side: const BorderSide(color: Colors.white38, width: 1)),
            onPressed: () {
              context.read<InsertarUbicacionProvider>().insertaNuevaUbicacion(
                  search: widget.codigo,
                  zona: _ZonaSeleccionado!,
                  stand: _StandSeleccionado!,
                  col: _ColumnaSeleccionado!,
                  fil: _FilaSeleccionado!,
                  cantidad: _cantidadInsertada.text,
                  usuario: usuario,
                  imagenes: imagenes.imagenes);
            },
            child: SizedBox(
              height: 60,
              width: size.width * 0.8,
              child: const Center(
                  child: Text(
                'Agregar',
                style: TextStyle(fontSize: 15, color: Colors.white),
              )),
            )),
      ),
    );
  }

  void _mostrarOpcionesDeImagenes(ImagenesProvider imagenes) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Seleccionar una opción',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_library_outlined),
                    title: const Text(
                      'Galería',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      imagenes.imagenesDeGaleria();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text(
                      'Cámara',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      imagenes.tomarFoto();
                    },
                  )
                ],
              ));
        });
  }

  Widget _comboBox(String texto, List<String> items, String? valor,
      ValueChanged<String?> cambiadoSi) {
    return DropdownButtonFormField(
      value: valor,
      onChanged: cambiadoSi,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ));
      }).toList(),
      decoration: InputDecoration(
          labelText: texto,
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.blueGrey))),
    );
  }

  Widget _mostrarImagenes(ImagenesProvider imagenes) {
    return Center(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: imagenes.imagenes.map((img) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  img,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                top: 5,
                right: 0,
                left: 0,
                child: IconButton(
                    onPressed: () => imagenes.eliminarImagen(img),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
