import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonEditAtr extends StatefulWidget {
  const ButtonEditAtr({super.key, required this.atributo, required this.alvo, required this.child});

  final Atributos atributo;
  final int alvo;
  final Widget child;

  @override
  State<ButtonEditAtr> createState() => _ButtonEditAtrState();
}

class _ButtonEditAtrState extends State<ButtonEditAtr> {
  late TextEditingController controlAtr;

  @override
  void initState() {
    super.initState();
    controlAtr = TextEditingController();
  }

  @override
  void dispose() {
    controlAtr.dispose();
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
          controlAtr.text = value.getAtributo(alvo: widget.alvo, atr: widget.atributo).toString();
          
          String txt = "";
          switch(widget.atributo) {
            case Atributos.poder: txt = "PA ";
            case Atributos.habilidade: txt = "PM ";
            case Atributos.resistencia: txt = "PV ";
          }
          switch(widget.alvo) {
            case 0: txt = "Atributo";
            case 1: txt += "atuais";
            case 2: txt += "máximos";
          }

          return AlertDialog(
            title: Text("$txt:"),
            content: CorpoAtrDialog(controlAtr: controlAtr),
            actions: [
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  value.setAtributo(alvo: widget.alvo, valor: controlAtr.text, atr: widget.atributo);
                  Navigator.pop(context);
                },
                child: Text("Salvar"),
              ),
            ],
          );
        },);
      },
    );
  }
}

class CorpoAtrDialog extends StatelessWidget {
  const CorpoAtrDialog({
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