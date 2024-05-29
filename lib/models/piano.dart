class Piano {
  int? id;
  String? modelo;
  int? ano_compra;
  bool? novo;
  double? prezo;

  Piano.vacio();

  Piano(
      {required this.id,
      required this.modelo,
      required this.ano_compra,
      required this.novo,
      required this.prezo});

  /*
  fromMap() permítenos sacar a información da base de datos (devolve un mapa)
  toMap() permítenos enviar a información á base de datos (porque acepta mapas)
   */
  Map<String, dynamic> toMap() {
    var nuevo = (this.novo == true) ? 1 : 0;
    return {
      'id': this.id,
      'modelo': this.modelo,
      'ano_compra': this.ano_compra,
      'novo': nuevo,
      'prezo': this.prezo
    };
  }

  factory Piano.fromMap(Map<String, dynamic> mapa) {
    return Piano(
        id: mapa['id'],
        modelo: mapa['modelo'],
        ano_compra: mapa['ano_compra'],
        novo: mapa['novo'] == 1 ? true : false,
        prezo: mapa['prezo']);
  }
}
