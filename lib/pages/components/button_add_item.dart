import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:ficha_bda/pages/components/corpo_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonAddItem extends StatefulWidget {
  const ButtonAddItem({super.key, required this.parteFicha});

  final PartesFicha parteFicha;

  @override
  State<ButtonAddItem> createState() => _ButtonAddItemState();
}

class _ButtonAddItemState extends State<ButtonAddItem> {
  late TextEditingController controlNome;
  late TextEditingController controlPontos;

  @override
  void initState() {
    super.initState();
    controlNome = TextEditingController();
    controlPontos = TextEditingController();
  }

  @override
  void dispose() {
    controlNome.dispose();
    controlPontos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () => addDialog(context),
      icon: Icon(Icons.add),
    );
  }

  Future<String?> addDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return Consumer<FichaBdaController>(builder: (BuildContext context, FichaBdaController value, Widget? child) {
          controlPontos.text = "";
          controlNome.text = "";

          Widget dialog;
          List<PartesFicha> list = [PartesFicha.arquetipo, PartesFicha.kitpersonagem, PartesFicha.inventario];
          
          if(list.contains(widget.parteFicha)) {
            dialog = CorpoItemSimplesDialog(controlNome: controlNome);
          } else {
            dialog = CorpoItemCompostoDialog(controlPontos: controlPontos, controlNome: controlNome);
          }
          
          return AlertDialog(
            title: Text("Criando habilidade:"),
            content: dialog,
            actions: [
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  value.addItem(pontos: controlPontos.text, nome: controlNome.text, parteFicha: widget.parteFicha);
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
