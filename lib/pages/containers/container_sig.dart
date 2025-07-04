import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:ficha_bda/pages/components/button_add_item.dart';
import 'package:ficha_bda/pages/components/button_edit_item.dart';
import 'package:ficha_bda/pages/components/button_edit_sig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerSig extends StatelessWidget {
  const ContainerSig({super.key});

  @override
  Widget build(BuildContext context) {
    final fichaController = context.watch<FichaBdaController>();

    List<String> listItens = List<String>.generate(
      fichaController.listPoderSig.length,
      (int index) => fichaController.listPoderSig[index].toString(),
    );

    //print(listItens.toString());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Significado",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Visibility(
                visible: fichaController.isEditavel,
                child: ButtonAddItem(parteFicha: PartesFicha.significado),
              ),
            ],
          ),
          Divider(color: Theme.of(context).colorScheme.secondary),
          EditSignificado(),
          Visibility(
            visible: fichaController.listPoderSig.isNotEmpty,
            child: Divider(color: Theme.of(context).colorScheme.secondary),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(listItens.length, (int index) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                      listItens[index],
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                  Visibility(
                    visible: fichaController.isEditavel,
                    child: ButtonEditItem(
                      parteFicha: PartesFicha.significado,
                      indexItem: index,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class EditSignificado extends StatefulWidget {
  const EditSignificado({super.key});

  @override
  State<EditSignificado> createState() => _EditSignificadoState();
}

class _EditSignificadoState extends State<EditSignificado> {
  @override
  Widget build(BuildContext context) {
    final fichaController = context.watch<FichaBdaController>();
    var textStyle = Theme.of(context).textTheme;

    return Row(
      children: [
        Expanded(
          child: FittedBox(
            child: Text("Pontos de SIG.: ", style: textStyle.labelMedium),
          ),
        ),
        Row(
          children: [
            ButtonEditSig(
              index: 0,
              child: Text("${fichaController.getSignificado(0)}"),
            ),
            Text(" / ", style: textStyle.labelLarge),
            ButtonEditSig(
              index: 1,
              child: Text("${fichaController.getSignificado(1)}"),
            ),
          ],
        ),
      ],
    );
  }
}
