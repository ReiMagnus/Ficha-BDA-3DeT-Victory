import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:ficha_bda/pages/containers/container_atributo.dart';
import 'package:ficha_bda/pages/containers/container_info.dart';
import 'package:ficha_bda/pages/containers/container_item.dart';
import 'package:ficha_bda/pages/containers/container_sig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FichaBDAPage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  FichaBDAPage({super.key});

  @override
  State<FichaBDAPage> createState() => _FichaBDAPageState();
}

/*
    -- FICHA DE PERSONAGEM
    Informações X
    Atributos
    -Arquétipo X 
    -Kit de personagem X 
    Perícias X
    Poderes (Vantegens e/ou desvantagens) X
    Técnicas X
    Inventário X
  */
class _FichaBDAPageState extends State<FichaBDAPage> {
  @override
  Widget build(BuildContext context) {
    final fichaController = context.watch<FichaBdaController>();

    final List<Widget> partes = [
      ContainerInfo(),
      ContainerAtributo(),
      ContainerSig(),
      ContainerItem(
        parteFicha: PartesFicha.pericias,
        itens: fichaController.listPericias,
      ),
      ContainerItem(
        parteFicha: PartesFicha.arquetipo,
        itens: fichaController.listArquetipo,
      ),
      ContainerItem(
        parteFicha: PartesFicha.kitpersonagem,
        itens: fichaController.listKitPersona,
      ),
      ContainerItem(
        parteFicha: PartesFicha.poderes,
        itens: fichaController.listPoderes,
      ),
      ContainerItem(
        parteFicha: PartesFicha.tecnicas,
        itens: fichaController.listTecnicas,
      ),
      ContainerItem(
        parteFicha: PartesFicha.inventario,
        itens: fichaController.listInventario,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          "Ficha 3DeT",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton.filled(onPressed: fichaController.trocarModoEditavel, icon: Icon(Icons.edit)),
          ),
        ],
      ),
      body: ListView(padding: const EdgeInsets.all(8), children: partes),
    );
  }
}
