import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:tesla/providers/tabla_apuntes_provider.dart';


class PizarraApuntes extends StatefulWidget {
  const PizarraApuntes({super.key});


  @override
  State<PizarraApuntes> createState() => _PizarraApuntesState();
}

class _PizarraApuntesState extends State<PizarraApuntes> {
  bool isEraserMode = false;

  @override
  Widget build(BuildContext context) {
    final signatureProvider = Provider.of<SignatureProvider>(context);
    final size = MediaQuery.of(context).size;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tablero Digital",style: TextStyle(
            fontSize: 18,
          ),),
        centerTitle: true
        ,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Selector de color y grosor
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Color: "),
                IconButton(
                  icon: Icon(Icons.color_lens, color: signatureProvider.controller.penColor),
                  onPressed: () async {
                    Color? pickedColor = await showDialog(
                      context: context,
                      builder: (_) => ColorPickerDialog(initialColor: signatureProvider.controller.penColor),
                    );
                    if (pickedColor != null) {
                      signatureProvider.updatePenColor(pickedColor);
                    }
                  },
                ),
                const SizedBox(width: 20),
                const Text("Grosor: "),
                DropdownButton<double>(
                  value: signatureProvider.controller.penStrokeWidth,
                  items: [1, 3, 5, 7, 10].map((e) {
                    return DropdownMenuItem(
                      value: e.toDouble(),
                      child: Text(e.toString()),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    if (newValue != null) {
                      signatureProvider.updatePenStrokeWidth(newValue);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Área de firma
            Signature(
              controller: signatureProvider.controller,
              height: size.height * 0.69,
              width: double.infinity,
              backgroundColor: Colors.grey[200]!,
            ),
            const SizedBox(height: 20),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        signatureProvider.clearSignature();
      }, child: SizedBox(
                  height: 70,
                  width: size.width * 0.29, 
                  child: const Icon(Icons.cleaning_services_rounded),
                ),),
    );
  }
}



class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;

  const ColorPickerDialog({super.key, required this.initialColor});

  @override
  Widget build(BuildContext context) {
    Color selectedColor = initialColor;

    return AlertDialog(
      title: const Text("Seleccionar Color"),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: initialColor,
          onColorChanged: (color) {
            selectedColor = color;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(selectedColor),
          child: const Text("Aceptar"),
        ),
      ],
    );
  }
}

