import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:ficha_bda/pages/components/button_edit_atr.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerAtributo extends StatelessWidget {
  const ContainerAtributo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Atributos", style: Theme.of(context).textTheme.titleMedium),
          Divider(color: Theme.of(context).colorScheme.secondary),
          EditAtributo(atributo: Atributos.poder),
          EditAtributo(atributo: Atributos.habilidade),
          EditAtributo(atributo: Atributos.resistencia),
        ],
      ),
    );
  }
}

class EditAtributo extends StatefulWidget {
  const EditAtributo({super.key, required this.atributo});

  final Atributos atributo;

  @override
  State<EditAtributo> createState() => _EditAtributoState();
}

class _EditAtributoState extends State<EditAtributo> {
  @override
  Widget build(BuildContext context) {
    final fichaController = context.watch<FichaBdaController>();
    var textStyle = Theme.of(context).textTheme.labelLarge;

    String atr = switch (widget.atributo) {
      Atributos.poder => "P",
      Atributos.habilidade => "H",
      Atributos.resistencia => "R",
    };
    String rec = switch (widget.atributo) {
      Atributos.poder => "PA",
      Atributos.habilidade => "PM",
      Atributos.resistencia => "PV",
    };

    return Row(
      children: [
        ButtonEditAtr(
          atributo: widget.atributo,
          alvo: 0,
          child: SizedBox(
            width: 90,
            child: Center(
              child: Text(
                "$atr ${fichaController.getAtributo(alvo: 0, atr: widget.atributo)}",
              ),
            ),
          ),
        ),

        Expanded(
          child: Row(
            children: [
              Text(" | ", style: textStyle),
              Text("$rec ", style: textStyle),
            ],
          ),
        ),

        Row(
          children: [
            ButtonEditAtr(
              atributo: widget.atributo,
              alvo: 1,
              child: Text("${fichaController.getAtributo(alvo: 1, atr: widget.atributo)}"),
            ),
            Text(" / ", style: textStyle),
            ButtonEditAtr(
              atributo: widget.atributo,
              alvo: 2,
              child: Text("${fichaController.getAtributo(alvo: 2, atr: widget.atributo)}"),
            ),
          ],
        ),
      ],
    );
  }
}
