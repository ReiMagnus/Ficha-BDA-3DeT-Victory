import 'package:ficha_bda/fichas/ficha_bda.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PartesFicha {
  // compatíveis com ItemSimples e ItemComposto
  arquetipo, 
  kitpersonagem, 
  significado, // Composto
  pericias, // Composto
  poderes, // Composto
  tecnicas, // Composto
  inventario,
}

enum Atributos { poder, habilidade, resistencia }

class FichaBdaController extends ChangeNotifier {
  FichaBDA _ficha = FichaBDA();

  bool _isEditavel = false;

  FichaBdaController() {
    _createFicha();
  }

  Future<void> _createFicha() async {
    String json = await rootBundle.loadString("lib/json/ficha_bda.json");
    _ficha = FichaBDA.fromJson(json);
    _sortAllLists();
    debugPrint("Ficha carregada com sucesso ----- ");
  }
  
  bool get isEditavel => _isEditavel;

  String get nome => _ficha.nome;
  ItemComposto get arquetipo => _ficha.arquetipo;
  ItemComposto get kitPersona => _ficha.kitPersona;
  int get pontos => _ficha.pontos;
  int get xps => _ficha.xps;
  List<ItemComposto> get listPericias => _ficha.listPericias;
  List<ItemSimples> get listArquetipo => _ficha.listArquetipo;
  List<ItemSimples> get listKitPersona => _ficha.listKitPersona;
  List<ItemComposto> get listPoderSig => _ficha.listPoderSig;
  List<ItemComposto> get listPoderes => _ficha.listPoderes;
  List<ItemComposto> get listTecnicas => _ficha.listTecnicas;
  List<ItemSimples> get listInventario => _ficha.listInventario;

  /*
  set nome(String nome) => _ficha.nome;
  set arquetipo(ItemComposto arquetipo) => ;
  set kitPersona(ItemComposto kitPersona) => _ficha.kitPersona;
  set pontos(int pontos) => _ficha.pontos;
  set xps(int xps) => _ficha.xps;
  */

  int getAtributo({required int alvo, required Atributos atr}) {
    int valor = -1;

    int index = switch (atr) {
      Atributos.poder => 0,
      Atributos.habilidade => 1,
      Atributos.resistencia => 2,
    };

    switch (alvo) {
      case 0:
        valor = _ficha.atributos[index];
      case 1:
        valor = _ficha.recurAtuais[index];
      case 2:
        valor = _ficha.recurMaximos[index];
    }
    return valor;
  }

  int getSignificado(int index) {
    return _ficha.recurSig[index];
  }

  ItemSimples getItemS(int index, PartesFicha parteFicha) {
    ItemSimples item;
    switch (parteFicha) {
      case PartesFicha.arquetipo:
        item = _ficha.listKitPersona.elementAt(index);
      case PartesFicha.kitpersonagem:
        item = _ficha.listKitPersona.elementAt(index);
      case PartesFicha.inventario:
        item = _ficha.listInventario.elementAt(index);
      default:
        throw "Pedindo um ItemSimples no lugar de um ItemComposto";
    }
    return item;
  }

  ItemComposto getItemC(int index, PartesFicha parteFicha) {
    ItemComposto item;
    switch (parteFicha) {
      case PartesFicha.pericias:
        item = _ficha.listPericias.elementAt(index);
      case PartesFicha.poderes:
        item = _ficha.listPoderes.elementAt(index);
      case PartesFicha.tecnicas:
        item = _ficha.listTecnicas.elementAt(index);
      case PartesFicha.significado:
        item = _ficha.listPoderSig.elementAt(index);
      default:
        throw "Pedindo um ItemSimples no lugar de um ItemComposto";
    }
    return item;
  }

  String nomeParteContainer(PartesFicha parte) {
    String txt;
    switch (parte) {
      case PartesFicha.arquetipo:
        txt = "Arquétipo";
      case PartesFicha.kitpersonagem:
        txt = "Kit de personagem";
      case PartesFicha.pericias:
        txt = "Perícias";
      case PartesFicha.significado:
        txt = "Significado";
      case PartesFicha.poderes:
        txt = "Poderes";
      case PartesFicha.tecnicas:
        txt = "Técnicas";
      case PartesFicha.inventario:
        txt = "Inventário";
    }
    return txt;
  }

  void _sortAllLists() {
    _ficha.listPericias.sort();
    _ficha.listArquetipo.sort();
    _ficha.listKitPersona.sort();
    _ficha.listPoderes.sort();
    _ficha.listTecnicas.sort();
    _ficha.listInventario.sort();
    notifyListeners(); // Atualizando a tela
  }

  void trocarModoEditavel() {
    _isEditavel = !_isEditavel;
    notifyListeners();
  }

  void setInfos({
    required String nome,
    required String arquetipoNome,
    required String arquetipoPts,
    required String kitPersonaNome,
    required String kitPersonaPts,
    required String pontos,
    required String xp,
  }) {
    _ficha.nome = nome;
    _ficha.arquetipo = ItemComposto((arquetipoPts != "") ? int.parse(arquetipoPts) : 0, arquetipoNome);
    _ficha.kitPersona = ItemComposto((kitPersonaPts != "") ? int.parse(kitPersonaPts) : 0, kitPersonaNome);
    _ficha.pontos = (pontos != "") ? int.parse(pontos) : 0;
    _ficha.xps = (xp != "") ? int.parse(xp) : 0;
    notifyListeners();
  }

  void setAtributo({
    required int alvo,
    required String valor,
    required Atributos atr,
  }) {
    int index = switch (atr) {
      Atributos.poder => 0,
      Atributos.habilidade => 1,
      Atributos.resistencia => 2,
    };

    valor = (valor == "") ? "0" : valor;

    if (alvo == 0 && int.parse(valor) > 999) {
      valor = "999";
    } else if (alvo != 0 && int.parse(valor) > 9999) {
      valor = "9999";
    }

    switch (alvo) {
      case 0:
        _ficha.setAtributo(int.parse(valor), index);
      case 1:
        _ficha.setRecurAtuais(int.parse(valor), index);
      case 2:
        _ficha.setRecurMaximos(int.parse(valor), index);
    }
    notifyListeners();
  }

  void setSignificado(int valor, int index) {
    _ficha.setSignificado(valor, index);
    notifyListeners();
  }

  void addItem({
    String? pontos,
    required String nome,
    required PartesFicha parteFicha,
  }) {
    switch (parteFicha) {
      case PartesFicha.arquetipo:
        _ficha.addArquetipo(nome);
      case PartesFicha.kitpersonagem:
        _ficha.addKitPersona(nome);
      case PartesFicha.pericias:
        _ficha.addPericia((pontos == "") ? 0 : int.parse(pontos!), nome);
      case PartesFicha.significado:
        _ficha.addPoderSig((pontos == "") ? 0 : int.parse(pontos!), nome);
      case PartesFicha.poderes:
        _ficha.addPoder((pontos == "") ? 0 : int.parse(pontos!), nome);
      case PartesFicha.tecnicas:
        _ficha.addTecnica((pontos == "") ? 0 : int.parse(pontos!), nome);
      case PartesFicha.inventario:
        _ficha.addInventario(nome);
    }
    _sortAllLists();
  }

  void attItem({
    String? pontos,
    required String nome,
    required int index,
    required PartesFicha parteFicha,
  }) {
    // O método atualiza mesmo fornecendo os mesmos valores, acho q n compensa mexer nisso.
    switch (parteFicha) {
      case PartesFicha.arquetipo:
        _ficha.attArquetipo(nome, index);
      case PartesFicha.kitpersonagem:
        _ficha.attKitPersona(nome, index);
      case PartesFicha.pericias:
        _ficha.attPericia(pontos!, nome, index);
      case PartesFicha.significado:
        _ficha.attPoderSig(pontos!, nome, index);
      case PartesFicha.poderes:
        _ficha.attPoder(pontos!, nome, index);
      case PartesFicha.tecnicas:
        _ficha.attTecnica(pontos!, nome, index);
      case PartesFicha.inventario:
        _ficha.attInventario(nome, index);
    }
    _sortAllLists();
  }

  void removeItem(int index, PartesFicha parteFicha) {
    switch (parteFicha) {
      case PartesFicha.arquetipo:
        _ficha.removeArquetipo(index);
      case PartesFicha.kitpersonagem:
        _ficha.removeKitPersona(index);
      case PartesFicha.pericias:
        _ficha.removePericia(index);
      case PartesFicha.significado:
        _ficha.removePoderSig(index);
      case PartesFicha.poderes:
        _ficha.removePoder(index);
      case PartesFicha.tecnicas:
        _ficha.removeTecnica(index);
      case PartesFicha.inventario:
        _ficha.removeInventario(index);
    }
    _sortAllLists();
  }
}
