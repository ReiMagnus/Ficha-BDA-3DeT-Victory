import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonEditSig extends StatefulWidget {
  const ButtonEditSig({super.key, required this.index, required this.child});

  final int index;
  final Widget child;

  @override
  State<ButtonEditSig> createState() => _ButtonEditSigState();
}

class _ButtonEditSigState extends State<ButtonEditSig> {
  late TextEditingController controlSig;

  @override
  void initState() {
    super.initState();
    controlSig = TextEditingController();
  }

  @override
  void dispose() {
    controlSig.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var buttonStyle = TextButton.styleFrom(
      shape: LinearBorder(), 
      textStyle: Theme.of(context).textTheme.labelLarge,
      foregroundColor: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed
    );

    return TextButton(onPressed: () => editDialog(context), style: buttonStyle, child: widget.child);
  }

  Future<String?> editDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return Consumer<FichaBdaController>(builder: (BuildContext context, FichaBdaController value, Widget? child) {
          controlSig.text = value.getSignificado(widget.index).toString();
        
          return AlertDialog(
            title: Text("Significado:"),
            content: CorpoSigDialog(controlAtr: controlSig),
            actions: [
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  value.setSignificado(int.parse(controlSig.text), widget.index);
                  Navigator.pop(context);
                },
                child: Text("Salvar",),
              ),
            ],
          );
        },);
      },
    );
  }
}

class CorpoSigDialog extends StatelessWidget {
  const CorpoSigDialog({
    super.key,
    required this.controlAtr,
  });

  final TextEditingController controlAtr;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.numberWithOptions(),
            controller: controlAtr,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Valor",
            ),
          ),
        ],
      ),
    );
  }
}