import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:ficha_bda/pages/components/corpo_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonEditItem extends StatefulWidget {
  const ButtonEditItem({
    super.key,
    required this.parteFicha,
    required this.indexItem,
  });

  final int indexItem;
  final PartesFicha parteFicha;

  @override
  State<ButtonEditItem> createState() => _ButtonEditItemState();
}

class _ButtonEditItemState extends State<ButtonEditItem> {
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
    return IconButton(
      onPressed: () => editDialog(context),
      icon: Icon(Icons.edit),
    );
  }

  Future<String?> editDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return Consumer<FichaBdaController>(builder: (BuildContext context, FichaBdaController value, Widget? child,) {
          Widget dialog;

          try {
            List<PartesFicha> list = [PartesFicha.arquetipo, PartesFicha.kitpersonagem, PartesFicha.inventario];
            if(list.contains(widget.parteFicha)) {
              controlNome.text   = value.getItemS(widget.indexItem, widget.parteFicha).nome;
              dialog = CorpoItemSimplesDialog(controlNome: controlNome);
            } else {
              controlPontos.text = value.getItemC(widget.indexItem, widget.parteFicha).pontos.toString();
              controlNome.text   = value.getItemC(widget.indexItem, widget.parteFicha).nome;
              dialog = CorpoItemCompostoDialog(controlPontos: controlPontos, controlNome: controlNome);
            }
          } catch(e) {
            return SizedBox.shrink();
          }

          return AlertDialog(
            title: Text("Editando item:"),
            content: dialog,
            actions: [
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  value.removeItem(widget.indexItem, widget.parteFicha);
                  Navigator.pop(context);
                },
                child: Text("Excluir"),
              ),
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style,
                onPressed: () {
                  value.attItem(pontos: controlPontos.text, nome: controlNome.text, index: widget.indexItem, parteFicha: widget.parteFicha);
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
