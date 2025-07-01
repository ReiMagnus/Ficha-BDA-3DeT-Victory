import 'package:ficha_bda/control/ficha_bda_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonEditInfo extends StatefulWidget {
  const ButtonEditInfo({super.key});

  @override
  State<ButtonEditInfo> createState() => _ButtonEditInfoState();
}

class _ButtonEditInfoState extends State<ButtonEditInfo> {
  late final TextEditingController controllerNome;
  late final TextEditingController controllerArquText;
  late final TextEditingController controllerArquPont;
  late final TextEditingController controllerKitText;
  late final TextEditingController controllerKitPont;
  late final TextEditingController controllerPont;
  late final TextEditingController controllerXP;

  @override
  void initState() {
    super.initState();
    controllerNome = TextEditingController();
    controllerArquText = TextEditingController();
    controllerArquPont = TextEditingController();
    controllerKitText = TextEditingController();
    controllerKitPont = TextEditingController();
    controllerPont = TextEditingController();
    controllerXP   = TextEditingController();
  }

  @override
  void dispose() {
    controllerNome.dispose();
    controllerArquText.dispose();
    controllerArquPont.dispose();
    controllerKitText.dispose();
    controllerKitPont.dispose();
    controllerPont.dispose();
    controllerXP.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return IconButton.filled(
      onPressed: () => editDialog(context),
      icon: Icon(Icons.edit),
    );
  }

  Future<String?> editDialog(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder:
          (context) => Consumer<FichaBdaController>(builder: (BuildContext context, FichaBdaController value, Widget? child) {
              controllerNome.text     = (value.nome != "") ? value.nome : "" ;
              controllerArquText.text = (value.arquetipo.nome != "") ? value.arquetipo.nome : "" ;
              controllerArquPont.text = (value.arquetipo.pontos != 0) ? value.arquetipo.pontos.toString() : "0" ;
              controllerKitText.text  = (value.kitPersona.nome != "") ? value.kitPersona.nome : "" ;
              controllerKitPont.text  = (value.kitPersona.pontos != 0) ? value.kitPersona.pontos.toString() : "0" ;
              controllerPont.text     = (value.pontos != 0) ? value.pontos.toString() : "0" ;
              controllerXP.text       = (value.xps != 0) ? value.xps.toString() : "0" ;

              return AlertDialog(
                title: Text("Editando informações:"),
                content: SingleChildScrollView(
                  child: Column(
                    spacing: 8,
                    children: [
                      TextField(
                        keyboardType: TextInputType.name,
                        controller: controllerNome,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Nome",
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              controller: controllerArquText,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Arquétipo",
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: controllerArquPont,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pts",
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              keyboardType: TextInputType.name,
                              controller: controllerKitText,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Kit de personagem",
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: controllerKitPont,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pts",
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: controllerPont,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pontos",
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              controller: controllerXP,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "XP",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    style: Theme.of(context).elevatedButtonTheme.style,
                    onPressed: () {
                      value.setInfos(
                        nome: controllerNome.text, 
                        arquetipoNome: controllerArquText.text,
                        arquetipoPts: controllerArquPont.text, 
                        kitPersonaNome: controllerKitText.text,
                        kitPersonaPts: controllerKitPont.text,
                        pontos: controllerPont.text,
                        xp: controllerXP.text
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Salvar"),
                  ),
                ],
              );
            },
          ),
    );
  }
}
