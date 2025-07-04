import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:ficha_bda/fichas/ficha_bda.dart';
import 'package:ficha_bda/pages/components/button_add_item.dart';
import 'package:ficha_bda/pages/components/button_edit_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerItem extends StatefulWidget {
  const ContainerItem({
    super.key,
    required this.parteFicha,
    required this.itens,
  });

  final PartesFicha parteFicha;
  final List<ItemSimples> itens;

  @override
  State<ContainerItem> createState() => _ContainerItemState();
}

class _ContainerItemState extends State<ContainerItem> {
  @override
  Widget build(BuildContext context) {
    List<String> listItens = List<String>.generate(
      widget.itens.length,
      (int index) => widget.itens[index].toString(),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Consumer<FichaBdaController>(
        builder: (
          BuildContext context,
          FichaBdaController value,
          Widget? child,
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      value.nomeParteContainer(widget.parteFicha),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Visibility(
                    visible: value.isEditavel,
                    child: ButtonAddItem(parteFicha: widget.parteFicha),
                  ),
                ],
              ),
              Divider(color: Theme.of(context).colorScheme.secondary),
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
                        visible: value.isEditavel,
                        child: ButtonEditItem(
                          parteFicha: widget.parteFicha,
                          indexItem: index,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
