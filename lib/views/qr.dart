import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:tesla/providers/stock_provider.dart';
import 'package:tesla/views/resultado_stock.dart';
import 'package:tesla/views/shake_transicion.dart';

class ConsultayQr extends StatefulWidget {
  const ConsultayQr({super.key});

  @override
  State<ConsultayQr> createState() => _ConsultayQrState();
}

class _ConsultayQrState extends State<ConsultayQr> {
  final TextEditingController _inserCod = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Consultar en AMP",style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                    SizedBox(
                    height: sizeH * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ShakeWidget(
                        child: SizedBox(
                          width: sizeW * 0.47,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 5.0,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  TextFormField(
                                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                                    maxLength: 5,
                                    autocorrect: false,
                                    autofocus: false,
                                    controller: _inserCod,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Codigo sba.',
                                      labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.grey, width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: Colors.orange, width: 1)),
                                      counterText: ''
                                    ),
                                    onFieldSubmitted: (value){
                                      
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ResultadoStock(codigo: _inserCod.text,) ));
                                     
                                      
                                    },
                                  
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      ShakeWidget(
                        child: SizedBox(
                          height: 76,
                          width: 140,
                          child: FloatingActionButton(
                            onPressed: () {
                              scanCode(context);
                            },
                            backgroundColor: Colors.orange,
                            child: const Icon(Icons.qr_code_2_outlined, size: 35,),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Future<void> scanCode(BuildContext context) async {
    try {
      String scannedCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancelar',
        true,
        ScanMode.QR
      );
      if(scannedCode != '-1'){
        context.read<StockProvider>().serScannedCode(scannedCode);

        Navigator.push(context, MaterialPageRoute(builder: (context) => ResultadoStock(codigo: scannedCode,)));
      }
    } catch(e){

    }
  }

}
