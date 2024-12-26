import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesla/providers/diferencias_provider.dart';
import 'package:tesla/views/resultado_stock.dart';

class ItemConDiferencias extends StatefulWidget {
  const ItemConDiferencias({super.key});

  @override
  State<ItemConDiferencias> createState() => _ItemConDiferenciasState();
}

class _ItemConDiferenciasState extends State<ItemConDiferencias> {
  final TextEditingController _buscarItem = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItemConDiferenciasProvider>().traerItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final dataItemsSba = context.watch<ItemConDiferenciasProvider>();
    final size = MediaQuery.of(context).size;
    final double sizeData = size.width > 600 ? 15 : 12;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diferencias',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 5),
                child: TextField(
                  controller: _buscarItem,
                  decoration: InputDecoration(
                      labelText: 'Ingrese SBA o Descripción',
                      labelStyle:
                          TextStyle(fontSize: 13, color: Colors.grey[600]),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () {
                            _buscarItem.clear();
                            dataItemsSba.buscarItems('');
                          },
                          icon: const Icon(Icons.cancel_outlined)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: const BorderSide(color: Colors.orange)),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10)),
                  onChanged: (cod) {
                    dataItemsSba.buscarItems(cod);
                  },
                ),
              ),
              Expanded(
                child: Consumer<ItemConDiferenciasProvider>(
                  builder: (context, itemProvider, child) {
                    if (itemProvider.item.isEmpty) {
                      return const Center(
                        child: Text(
                          'No tienes Items con diferencias',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: itemProvider.item.length,
                        itemBuilder: (context, index) {
                          final itenData = itemProvider.item[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      ResultadoStock(
                                    codigo: itenData.itemCode,
                                  ),
                                  transitionDuration:
                                      const Duration(milliseconds: 350),
                                  transitionsBuilder: (context, animation,
                                      animationSecondary, child) {
                                    return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(1.0, 0.0),
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
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "SBA: ${itenData.itemCode}",
                                            style: TextStyle(
                                                fontSize: sizeData,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                          const SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            itenData.descripcion,
                                            style: TextStyle(
                                              fontSize: sizeData,
                                              color: Colors.grey[700],
                                            ),
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Diferencia: ${itenData.diferencia}',
                                            style: TextStyle(
                                                fontSize: sizeData,
                                                color: Colors.red[400]),
                                            textAlign: TextAlign.end,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                  Icons.arrow_forward_ios))
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
