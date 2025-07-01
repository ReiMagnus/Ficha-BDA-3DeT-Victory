import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:ficha_bda/pages/components/button_edit_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContainerInfo extends StatelessWidget {
  const ContainerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final fichaController = context.watch<FichaBdaController>();
    var textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).colorScheme.onPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Informações", style: textStyle.titleMedium),
              Expanded(
                child: Text(
                  "Pts ${fichaController.pontos} | XP ${fichaController.xps}",
                  style: textStyle.labelSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              Visibility(visible: fichaController.isEditavel, child: ButtonEditInfo()),
            ],
          ),
          Divider(color: Theme.of(context).colorScheme.secondary),
          ItemInfo(label: "Nome", nome: fichaController.nome),

          ItemInfo(
            label: "Arquétipo",
            nome: fichaController.arquetipo.nome,
            pontos: fichaController.arquetipo.pontos,
          ),

          ItemInfo(
            label: "Kit de personagem",
            nome: fichaController.kitPersona.nome,
            pontos: fichaController.kitPersona.pontos,
          ),
        ],
      ),
    );
  }
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({
    super.key,
    this.pontos,
    required this.nome,
    required this.label,
  });

  final String label;
  final int? pontos;
  final String nome;

  @override
  Widget build(BuildContext context) {
    if (nome == "") {
      return Container();
    }

    var textStyle = Theme.of(context).textTheme;
    String txtPontos = (pontos != null) ? "$pontos pts" : "";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("- $label: $txtPontos", style: textStyle.labelSmall),
        Text(nome, style: textStyle.labelMedium),
        SizedBox(height: 15),
      ],
    );
  }
}
