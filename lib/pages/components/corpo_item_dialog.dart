
import 'package:flutter/material.dart';

class CorpoItemSimplesDialog extends StatelessWidget {
  const CorpoItemSimplesDialog({
    super.key,
    required this.controlNome,
  });

  final TextEditingController controlNome;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 32,
        children: [
          TextField(
            keyboardType: TextInputType.name,
            controller: controlNome,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nome",
            ),
          ),
        ],
      ),
    );
  }
}

class CorpoItemCompostoDialog extends StatelessWidget {
  const CorpoItemCompostoDialog({
    super.key,
    required this.controlPontos,
    required this.controlNome,
  });

  final TextEditingController controlPontos;
  final TextEditingController controlNome;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 32,
        children: [
          TextField(
            keyboardType: TextInputType.numberWithOptions(signed: true),
            controller: controlPontos,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Pontos",
            ),
          ),
          TextField(
            keyboardType: TextInputType.name,
            controller: controlNome,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Nome",
            ),
          ),
        ],
      ),
    );
  }
}

