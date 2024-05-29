import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:exemploexamebd/models/piano.dart';

class BdProvider {
  static final BdProvider bd = BdProvider._();

  BdProvider._(); // así evitamos que se pueda instanciar la clase

  final String _bdname = 'pianos.bd';
  static Database? _database;
  int _Version = 1;

/*
  Necesitamos:
  Método engadir piano
  Método quitar piano
  Método actualizar piano
  Método obter pianos
  e dous Future
  1 - obter a bd
  2 - iniciar a bd se non está creada
   */
  Future<Database> get database async {
    if (_database != null) {
      //Se a base de datos existe, vaina devolver
      return _database!;
    } else {
      //Se non existe, entra polo else, e chama ao método init para crear a base de datos, táboas, etc...
      _database = await initBD();
      return _database!;
    }
  }

  Future<Database> initBD() async {
    return await openDatabase(
      join(await getDatabasesPath(), _bdname),
      //openDatabase abre a ruta física cara a base de datos con nome enviado no segundo parámetro
      //recordar que estas adoitan atoparse en /data/data/nomeProxecto/databases, para comprobar durante o exame
      version: _Version,
      //con oncreate definimos a táboa que imos crear dentro da bd que iniciamos no paso anterior
      //especificamos campos, tipo de datos, etc... (tipos de datos de SQlite)
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE "piano"(
        "id" INTEGER,
        "modelo" TEXT NOT NULL,
        "ano_compra" NUMERIC NOT NULL,
        "novo" NUMERIC NOT NULL,
        "prezo" NUMERIC NOT NULL,
        PRIMARY KEY("id")        
        );        
        ''');
      },
    );
  }

  //Pechar a conexión de db
  Future<void> closeDB() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
    }
  }

/*
  Tódolos métodos que siguen deben ser future, porque chaman á base de datos para obter/enviar información
  De non ser así, o programa casca (Raúl, vai por ti)
   */

  Future<List<Piano>> getPianos() async {
    //chamamos á base de datos
    final db = await database;
    //obtemos os datos da base de datos
    //ordenamos por modelo porque é o que especifica o enunciado do exame
    final resultado = await db.query('piano', orderBy: 'piano.modelo');
    //por último, devolver a lista de pianos
    return resultado.map((e) => Piano.fromMap(e)).toList();
  }

  Future<int> addPiano(Piano piano) async {
    final db = await database;
    return await db.insert('piano', piano.toMap());
  }

  Future<int> updatePiano(Piano piano) async {
    final db = await database;
    return await db.update('piano', piano.toMap(),
        where: 'id=?', whereArgs: ['${piano.id}']);
  }

  Future<int> deletePiano(Piano piano) async {
    final db = await database;
    return await db.delete('piano', where: 'id=?', whereArgs: ['${piano.id}']);
  }
}
