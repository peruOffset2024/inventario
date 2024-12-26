import 'package:flutter/material.dart';

class NuevaCantidad extends StatefulWidget {
  const NuevaCantidad({
    super.key,
    required this.zona,
    required this.stand,
    required this.columna,
    required this.fila,
    required this.cantidad,
    required this.imagen,
  });

  final String zona;
  final String stand;
  final String columna;
  final String fila;
  final String cantidad;
  final List<String?> imagen;

  @override
  State<NuevaCantidad> createState() => _NuevaCantidadState();
}

class _NuevaCantidadState extends State<NuevaCantidad> {
  final TextEditingController _agregarController = TextEditingController();
  double _scale = 1.0; // Escala inicial de la imagen
  final double _zoomInFactor = 1.5; // Factor de zoom cuando se hace doble toque
  bool _isZooming = false; // Estado para saber si estamos haciendo zoom

  void _onDoubleTap() {
    setState(() {
      _isZooming = !_isZooming; // Cambiar el estado de zoom
      _scale = (_scale == 1.0) ? _zoomInFactor : 1.0; // Toggle entre zoom in y zoom out
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Mostrar un PageView si hay imágenes
              if (widget.imagen.isNotEmpty)
                SizedBox(
                  height: size.height * 0.6,
                  width: size.width ,
                  child: PageView.builder(
                    itemCount: widget.imagen.length,
                    onPageChanged: _isZooming
                        ? null // Deshabilitar el cambio de página mientras se hace zoom
                        : (index) {}, // Habilitar el cambio de página
                    itemBuilder: (context, index) {
                      final imageUrl = widget.imagen[index];
                      if (imageUrl == null || imageUrl.isEmpty) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.red,
                          ),
                        );
                      } else {
                        return GestureDetector(
                          onDoubleTap: _onDoubleTap,
                          child: InteractiveViewer(
                            panEnabled: !_isZooming, // Deshabilitar pan cuando se está haciendo zoom
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Image.network(
                              imageUrl,
                              height: size.height * 0.5,
                              width: size.width * 0.99,
                              fit: BoxFit.contain,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return const SizedBox(
                                  height: 100,
                                  width: 100,
                                  child:  Image(
                                    
                                    height: 50,
                                    width: 50,
                                    image:
                                        AssetImage('assets/animation/mont.gif'),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 100,
                                  color: Colors.red,
                                );
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    "No hay imágenes disponibles",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
             
                
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              height: 70,
                              width: size.width * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Zona:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(widget.zona),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              height: 70,
                              width: size.width * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Columna:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(widget.columna),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Center(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              height: 70,
                              width: size.width * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Stand:",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(widget.stand),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10, top: 10),
                              height: 70,
                              width: size.width * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Fila: ${widget.fila}",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(widget.fila),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              //const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            height: 70,
                            width: size.width * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Cantidad:",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  widget.cantidad,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Column(children: [
                      InkWell(
                        onTap: () {
                          _alertaAgregar();
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: Colors.orange,
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 10, top: 10),
                            height: 70,
                            width: size.width * 0.32,
                            child: const Icon(
                              Icons.edit_note,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _alertaAgregar() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          final isLandscape =
              MediaQuery.of(context).orientation == Orientation.landscape;
          final size = MediaQuery.of(context).size;
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: isLandscape ? size.height * 0.6 : size.height * 0.28,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Actualizar cantidad",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Por favor verificar la nueva cantidad a ingresar",
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _agregarController,
                        decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1),
                            ),
                            labelText: 'Cantidad',
                            prefixIcon: Icon(Icons.edit_outlined)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {},
                            child: SizedBox(
                                width: size.width * 0.8,
                                height: 50,
                                child: const Center(
                                    child: Text(
                                  'Ingresar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )))),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
    _agregarController.clear();
  }
}
