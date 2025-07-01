// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:core';

/*
  Informações
  Atributos
  Perícias
  Arquétipo
  Kit de personagem
  Poderes (Vantagens e Desvantagens)
  Técnicas
  Inventário

  
  Anotações
  Imagem Personagem
*/

class FichaBDA {
  //Atributos ---------------
  String nome = "";
  ItemComposto arquetipo = ItemComposto(0, "");
  ItemComposto kitPersona = ItemComposto(0, "");
  int pontos = 0;
  int xps = 0;

  List<int> _atributos = [0, 0, 0];
  List<int> _recurAtuais = [0, 0, 0];
  List<int> _recurMaximos = [0, 0, 0];

  List<int> _recurSig = [0, 0];

  List<ItemComposto> _listPericias = [];
  List<ItemSimples> _listArquetipo = [];
  List<ItemSimples> _listKitPersona = [];
  List<ItemComposto> _listPoderSig = [];
  List<ItemComposto> _listPoderes = []; // Vantagens e/ou desvantagens
  List<ItemComposto> _listTecnicas = [];
  List<ItemSimples> _listInventario = [];


  // Construtores -----------
  FichaBDA();

  FichaBDA.full(
    this.nome,
    this.arquetipo,
    this.kitPersona,
    this.pontos,
    this.xps,
    this._atributos,
    this._recurAtuais,
    this._recurMaximos,
    this._recurSig,
    this._listPericias,
    this._listArquetipo,
    this._listKitPersona,
    this._listPoderSig,
    this._listPoderes,
    this._listTecnicas,
    this._listInventario,
  );

  factory FichaBDA.fromJson(String source) => FichaBDA.fromMap(json.decode(source) as Map<String, dynamic>);


  // Métodos ----------------
  List<int> get atributos => _atributos;
  List<int> get recurAtuais => _recurAtuais;
  List<int> get recurMaximos => _recurMaximos;
  List<int> get recurSig => _recurSig;
  
  List<ItemComposto> get listPericias => _listPericias;
  List<ItemSimples> get listArquetipo => _listArquetipo;
  List<ItemSimples> get listKitPersona => _listKitPersona;
  List<ItemComposto> get listPoderSig => _listPoderSig;
  List<ItemComposto> get listPoderes => _listPoderes;
  List<ItemComposto> get listTecnicas => _listTecnicas;
  List<ItemSimples> get listInventario => _listInventario;

  /* 
    String get nome => _nome;
    ItemComposto get arquetipo => _arquetipo;
    ItemComposto get kitPersona => _kitPersona;
    int get pontos => _pontos;
    int get xps => _xps;

    set nome(String nome) => _nome = nome;
    set arquetipo(ItemComposto arquetipo) => _arquetipo = arquetipo;
    set kitPersona(ItemComposto kitPersona) => _kitPersona = kitPersona;
    set pontos(int pontos) => _pontos = pontos;
    set xps(int xps) => _xps = xps;
  */

  void setAtributo(int valor, int atr) {
    _atributos[atr] = valor;
  }

  void setRecurAtuais(int valor, int atr) {
    _recurAtuais[atr] = valor;
  }

  void setRecurMaximos(int valor, int atr) {
    _recurMaximos[atr] = valor;
  }

  void  setSignificado(int valor, int index) {
    _recurSig[index] = valor;
  }

  void addPericia(int pts, String nome) {
    _listPericias.add(ItemComposto((pts.isNegative) ? 1 : pts, nome));
  }

  void addArquetipo(String nome) {
    _listArquetipo.add(ItemSimples(nome));
  }

  void addKitPersona(String nome) {
    _listKitPersona.add(ItemSimples(nome));
  }

  void addPoderSig(int pts, String nome) {
    _listPoderSig.add(ItemComposto(pts, nome));
  }

  void addPoder(int pts, String nome) {
    _listPoderes.add(ItemComposto(pts, nome));
  }

  void addTecnica(int pts, String nome) {
    _listTecnicas.add(ItemComposto((pts.isNegative) ? 1 : pts, nome));
  }

  void addInventario(String nome) {
    _listInventario.add(ItemSimples(nome));
  }

  void attPericia(String pontos, String nome, int index) {
    var item = _listPericias.elementAt(index);
    item.nome = nome;
    item.pontos = int.parse(pontos);
  }

  void attArquetipo(String nome, int index) {
    var item = _listArquetipo.elementAt(index);
    item.nome = nome;
  }

  void attKitPersona(String nome, int index) {
    var item = _listKitPersona.elementAt(index);
    item.nome = nome;
  }

  void attPoderSig(String pontos, String nome, int index) {
    var item = _listPoderSig.elementAt(index);
    item.nome = nome;
    item.pontos = int.parse(pontos);
  }

  void attPoder(String pontos, String nome, int index) {
    var item = _listPoderes.elementAt(index);
    item.nome = nome;
    item.pontos = int.parse(pontos);
  }

  void attTecnica(String pontos, String nome, int index) {
    var item = _listTecnicas.elementAt(index);
    item.nome = nome;
    item.pontos = int.parse(pontos);
  }

  void attInventario(String nome, int index) {
    var item = _listInventario.elementAt(index);
    item.nome = nome;
  }
  
  void removePericia(int index) {
    _listPericias.removeAt(index);
  }

  void removeArquetipo(int index) {
    _listArquetipo.removeAt(index);
  }

  void removeKitPersona(int index) {
    _listKitPersona.removeAt(index);
  }

  void removePoderSig(int index) {
    _listPoderSig.removeAt(index);
  }
  
  void removePoder(int index) {
    _listPoderes.removeAt(index);
  }

  void removeTecnica(int index) {
    _listTecnicas.removeAt(index);
  }

  void removeInventario(int index) {
    _listInventario.removeAt(index);
  }

  @override
  String toString() {
    return 'FichaBDA(nome: $nome, arque: $arquetipo, pontos: $pontos, xps: $xps)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
      'arquetipo': arquetipo,
      'kitPersona': kitPersona,
      'pontos': pontos,
      'xps': xps,
      'atributos': _atributos,
      'recurAtuais': _recurAtuais,
      'recurMaximos': _recurMaximos,
      'recurSig': _recurSig,
      'listPericias': listPericias.map((x) => x.toMap()).toList(),
      'listArquetipo': listArquetipo.map((x) => x.toMap()).toList(),
      'listKitPersona': listKitPersona.map((x) => x.toMap()).toList(),
      'listPoderSig': listKitPersona.map((x) => x.toMap()).toList(),
      'listPoderes': listPoderes.map((x) => x.toMap()).toList(),
      'listTecnicas': listTecnicas.map((x) => x.toMap()).toList(),
      'listInventario': listInventario,
    };
  }

  factory FichaBDA.fromMap(Map<String, dynamic> map) {
    return FichaBDA.full(
      map['nome'] as String,
      ItemComposto.fromMap(map['arquetipo'] as Map<String,dynamic>),
      ItemComposto.fromMap(map['kitPersona'] as Map<String,dynamic>),
      map['pontos'] as int,
      map['xps'] as int,
      List<int>.from(map['atributos']),
      List<int>.from(map['recurAtuais']),
      List<int>.from(map['recurMaximos']),
      List<int>.from(map['recurSig']),
      List<ItemComposto>.from((map['listPericias']).map<ItemComposto>((x) => ItemComposto.fromMap(x as Map<String,dynamic>),),),
      List<ItemSimples>.from((map['listArquetipo']).map<ItemSimples>((x) => ItemSimples.fromMap(x as Map<String,dynamic>),),),
      List<ItemSimples>.from((map['listKitPersona']).map<ItemSimples>((x) => ItemSimples.fromMap(x as Map<String,dynamic>),),),
      List<ItemComposto>.from((map['listPoderSig']).map<ItemComposto>((x) => ItemComposto.fromMap(x as Map<String,dynamic>),),),
      List<ItemComposto>.from((map['listPoderes']).map<ItemComposto>((x) => ItemComposto.fromMap(x as Map<String,dynamic>),),),
      List<ItemComposto>.from((map['listTecnicas']).map<ItemComposto>((x) => ItemComposto.fromMap(x as Map<String,dynamic>),),),
      List<ItemSimples>.from((map['listInventario']).map<ItemSimples>((x) => ItemSimples.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());
}

class ItemSimples implements Comparable<ItemSimples> {
  String nome = "";
  
  ItemSimples(this.nome);

  @override
  String toString() => '- $nome';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nome': nome,
    };
  }

  factory ItemSimples.fromMap(Map<String, dynamic> map) {
    return ItemSimples(
      map['nome'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSimples.fromJson(String source) => ItemSimples.fromMap(json.decode(source) as Map<String, dynamic>);
  
  @override
  int compareTo(ItemSimples other) {
    return nome.compareTo(other.nome);
  }
  
}

class ItemComposto extends ItemSimples {
  int pontos = 0;

  ItemComposto(this.pontos, super.nome);

  @override
  String toString() => '${pontos.toString().padLeft(2)} pts - $nome';

  @override
  int compareTo(ItemSimples other) {
    if (other is ItemComposto) {
      return nome.compareTo(other.nome) - (pontos.compareTo(other.pontos) * 2);
    }
    return nome.compareTo(other.nome);
  }
  
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pontos': pontos,
      'nome': nome,
    };
  }

  factory ItemComposto.fromMap(Map<String, dynamic> map) {
    return ItemComposto(
      map['pontos'] as int,
      map['nome'] as String
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory ItemComposto.fromJson(String source) => ItemComposto.fromMap(json.decode(source) as Map<String, dynamic>);
}