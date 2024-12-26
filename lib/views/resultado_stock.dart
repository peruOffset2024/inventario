import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla/providers/auth_provider.dart';

import 'package:tesla/providers/stock_provider.dart';
import 'package:tesla/views/nueva_cantidad.dart';
import 'package:tesla/views/codigo_no_existe.dart';
import 'package:tesla/views/nueva_ubicacion.dart';
import 'package:tesla/views/shake_transicion.dart';

class ResultadoStock extends StatefulWidget {
  const ResultadoStock({super.key, required this.codigo});
  final String codigo;

  @override
  State<ResultadoStock> createState() => _ResultadoStockState();
}

class _ResultadoStockState extends State<ResultadoStock> {
  int indice = 0;
  String disponible = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockProvider>().obtenerStock(widget.codigo);
      context.read<StockProvider>().obtenerUbicacion(widget.codigo);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final dataUbi = context.watch<StockProvider>().itemUbic;
    final dataSistema = context.watch<StockProvider>().itemStock;
    final usuario = context.watch<AuthProvider>().username;


    // Calcula las sumas del stock del sistema y stock físico
    final double sumaStockSistema =
        dataSistema.fold(0.0, (sum, item) => sum + double.parse(item.stock));
    final double sumaStockFisico =
        dataUbi.fold(0.0, (sum, item) => sum + double.parse(item.cantidad));

    final double diferencias = sumaStockFisico - sumaStockSistema;
    double scale = 1.0; // Escala inicial de la imagen
    const double zoomInFactor =
        1.5; // Factor de zoom cuando se hace doble toque
    bool isZooming = false; // Estado para saber si estamos haciendo zoom

    void onDoubleTap() {
      setState(() {
        isZooming = !isZooming; // Cambiar el estado de zoom
        scale = (scale == 1.0)
            ? zoomInFactor
            : 1.0; // Toggle entre zoom in y zoom out
      });
    }

    Future<void> alertMensaje(BuildContext context, int ids, String nombre) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            '¿ESTÁS SEGURO QUE DESEAS BORRAR?',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                context.read<StockProvider>().eliminarDataPorId(ids, nombre);
               
                Navigator.of(context).pop();
              },
              child: const Text('SI'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NO'),
            ),
          ],
        );
      },
    );
  }

    return Scaffold(
      appBar: AppBar(
        title: ShakeWidget(
          child: Text(
            'COD. SBA: ${widget.codigo}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      //CodigoNoExiste
      body: Consumer<StockProvider>(
        builder: (context, cargaProv, child) {
          if (cargaProv.cargando) {
            return const Center(child: CircularProgressIndicator());
          }
          if (dataSistema.isEmpty && dataUbi.isEmpty) {
            return CodigoNoExiste(
              codigoSBA: widget.codigo,
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                Consumer<StockProvider>(
                  builder: (context, nuevProvider, child) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            nuevProvider.itemStock.isNotEmpty
                                ? nuevProvider.itemStock.first.itemdescripcion
                                : 'No existe ese codigo SBA',
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.visible,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Card(
                            color: Colors.blue[50],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'STOCK SISTEMA',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text('ALMACEN'),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text('STOCK')
                                    ],
                                  ),
                                  Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.blue, width: 1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0,
                                      ),
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            nuevProvider.itemStock.length,
                                        separatorBuilder: (_, __) =>
                                            const Divider(
                                          color: Colors.blue,
                                        ),
                                        itemBuilder: (context, index) {

                                          final indiceP =
                                              nuevProvider.itemStock[index];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 12,
                                                bottom: 10,
                                                left: 10,
                                                right: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(indiceP.name)
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(indiceP.stock),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Consumer<StockProvider>(
                  builder: (context, stockUbi, child) {
                    return SingleChildScrollView(
                      child: Card(
                        color: Colors.orange[50],
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'STOCK FISICO',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              // mostrar algo para cuanod este vacio
                              Card(
                                color: Colors.white,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.orange, width: 1),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 3.0),
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: stockUbi.itemUbic.length,
                                    separatorBuilder: (_, __) => const SizedBox(
                                      height: 10,
                                      child: Divider(
                                        color: Colors.orange,
                                      ),
                                    ),
                                    itemBuilder: (context, index) {
                                      final itemUbic = stockUbi.itemUbic[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  NuevaCantidad(
                                                zona: itemUbic.zona,
                                                stand: itemUbic.stand,
                                                columna: itemUbic.col,
                                                fila: itemUbic.fil,
                                                cantidad: itemUbic.cantidad,
                                                imagen: itemUbic.imgs
                                                        ?.cast<String>() ??
                                                    [],
                                              ),
                                              transitionDuration:
                                                  const Duration(
                                                      milliseconds: 350),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  animationSecondary,
                                                  child) {
                                                return SlideTransition(
                                                  position: Tween<Offset>(
                                                    begin:
                                                        const Offset(1.0, 0.0),
                                                    end: Offset.zero,
                                                  ).animate(animation),
                                                  child: FadeTransition(
                                                    opacity: animation,
                                                    child: child,
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              if (itemUbic.imgs!.isEmpty)
                                                const  CircleAvatar(
                                                      maxRadius: 30,
                                                      backgroundColor: Colors.white,
                                                      child: Icon(
                                                        Icons.image_outlined,
                                                        color: Colors.white,
                                                      ),)
                                                    
                                              else
                                                InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Material(
                                                              color: Colors.transparent,
                                                              child: Center(
                                                                child: Container(
                                                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                                                  height: size.height * 0.75,
                                                                  width: size.width * 0.99,
                                                                  decoration: BoxDecoration(
                                                                 
                                                                    borderRadius: BorderRadius.circular(5)
                                                                  ),
                                                                  child: SingleChildScrollView(
                                                                    child: Card(
                                                                      child: Padding(
                                                                         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            const Text('Imágenes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                                                                            const SizedBox(height: 10,),
                                                                            if (itemUbic
                                                                                .imgs!
                                                                                .isNotEmpty)
                                                                              Center(
                                                                                child: SizedBox(
                                                                                  height: size.height *
                                                                                      0.5,
                                                                                  width: size
                                                                                      .width * 0.96,
                                                                                  child: PageView
                                                                                      .builder(
                                                                                    itemCount: itemUbic
                                                                                        .imgs
                                                                                        ?.length,
                                                                                    onPageChanged: isZooming
                                                                                        ? null // Deshabilitar el cambio de página mientras se hace zoom
                                                                                        : (index) {}, // Habilitar el cambio de página
                                                                                    itemBuilder:
                                                                                        (context, index) {
                                                                                      final imageUrl =
                                                                                          itemUbic.imgs![index];
                                                                                      if (imageUrl.isEmpty) {
                                                                                        return const Center(
                                                                                          child: Icon(
                                                                                            Icons.broken_image,
                                                                                            size: 100,
                                                                                            color: Colors.red,
                                                                                          ),
                                                                                        );
                                                                                      } else {
                                                                                        return GestureDetector(
                                                                                          onDoubleTap: onDoubleTap,
                                                                                          child: InteractiveViewer(
                                                                                            panEnabled: !isZooming, // Deshabilitar pan cuando se está haciendo zoom
                                                                                            minScale: 0.5,
                                                                                            maxScale: 4.0,
                                                                                            child: Image.network(
                                                                                              imageUrl,
                                                                                              height: size.height * 0.8,
                                                                                              width: size.width * 0.99,
                                                                                              fit: BoxFit.cover,
                                                                                              loadingBuilder: (context, child, loadingProgress) {
                                                                                                if (loadingProgress == null) return child;
                                                                                                return const SizedBox(
                                                                                                  height: 100,
                                                                                                  width: 100,
                                                                                                  child: Image(
                                                                                                    height: 50,
                                                                                                    width: 50,
                                                                                                    image: AssetImage('assets/animation/mont.gif'),
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
                                                                                ),
                                                                              )
                                                                            else
                                                                              const Padding(
                                                                                padding:
                                                                                    EdgeInsets.only(top: 30),
                                                                                child:
                                                                                    Text(
                                                                                  "No hay imágenes disponibles",
                                                                                  style: TextStyle(
                                                                                      fontSize: 16,
                                                                                      fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(height: 10,),
                                                                              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text('Cerrar'))
                                                                                                                                          
                                                                              
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                    },
                                                    child: const CircleAvatar(
                                                      maxRadius: 30,
                                                      backgroundColor: Colors.orange,
                                                      child: Icon(
                                                        Icons.image_outlined,
                                                        
                                                      ),
                                                    )),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  _datosDeUbicacion(
                                                      'Zona', itemUbic.zona),
                                                  _datosDeUbicacion(
                                                      'Stand', itemUbic.stand),
                                                  _datosDeUbicacion(
                                                      'Columna', itemUbic.col),
                                                  _datosDeUbicacion(
                                                      'Fila', itemUbic.fil),
                                                  _datosDeUbicacion('Stock',
                                                      itemUbic.cantidad),
                                                  //Text(itemUbic.img)
                                                ],
                                              ),
                                              IconButton(onPressed: (){
                                              alertMensaje(context, itemUbic.id as int, usuario);
                                              }, icon: const Icon(Icons.delete_sharp, color: Colors.red,))
                                               
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      ),

      bottomNavigationBar: Container(
  decoration: const BoxDecoration(
    color: Colors.white,
   
  ),
  child: BottomNavigationBar(
    elevation: 0,
    onTap: _presionarStock,
    backgroundColor: Colors.white,
    currentIndex: indice,
    type: BottomNavigationBarType.fixed, // Para evitar que los iconos se muevan
    items: [
      BottomNavigationBarItem(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.computer_outlined,
              size: size.width > 600 ? 24 : 18,
              color: Colors.black,
            ),
            Text(
              'Sistema',
              style: TextStyle(
                fontSize: size.width > 600 ? 12 : 10,
                color: Colors.black,
              ),
            ),
            Text(
              '$sumaStockSistema',
              style: TextStyle(
                fontSize: size.width > 600 ? 12 : 10,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warehouse,
              size: size.width > 600 ? 24 : 18,
              color: Colors.black,
            ),
            Text(
              'Físico',
              style: TextStyle(
                fontSize: size.width > 600 ? 12 : 10,
                color: Colors.black,
              ),
            ),
            Text(
              '$sumaStockFisico',
              style: TextStyle(
                fontSize: size.width > 600 ? 12 : 10,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.remove_rounded,
              size: size.width > 600 ? 24 : 18,
              color: Colors.black,
            ),
            Text(
              'Diferencia',
              style: TextStyle(
                fontSize: size.width > 600 ? 12 : 10,
                color: Colors.black,
              ),
            ),
            Text(
              '$diferencias',
              style: TextStyle(
                fontSize: size.width > 600 ? 12 : 10,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        label: '',
      ),
    ],
  ),
),

      floatingActionButton: dataSistema.isEmpty
          ? const SizedBox.shrink()
          : ShakeWidget(
              child: FloatingActionButton.extended(
                
                onPressed: () {
                  final descrip = context.read<StockProvider>().itemStock;

                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          NuevaUbicacion(
                        codigo: widget.codigo,
                        descripcion: descrip.first.itemdescripcion,
                      ),
                      transitionDuration: const Duration(milliseconds: 350),
                      transitionsBuilder:
                          (context, animation, animationSecondary, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: Tween<double>(
                              begin: 0.8,
                              end: 1.0,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Agregar',
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.orange,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _presionarStock(int index) {
    setState(() {
      indice = index;
    });
  }

  Widget _datosDeUbicacion(String texto, String valor) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '$texto: ',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: valor,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
