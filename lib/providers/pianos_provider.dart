import 'package:flutter/cupertino.dart';
import 'bd_provider.dart';
import 'package:exemploexamebd/models/piano.dart';

/*
A clase PianoProvider é a que chama ao provider da base de datos,
e é a que notifica á aplicación cando cambian valores que haxa que plasmar
nas pantallas
 */
class PianoProvider with ChangeNotifier {
  /*
  Dentro da clase precisamos métodos para obter, crear, eliminar e actualizar pianos
  Todos son future porque temos que conectar coa base de datos e esperar a que se envíe a información no sentido preciso
   */
  Future<List<Piano>> getPianos() async {
    return await BdProvider.bd.getPianos();
  }

  Future<int> addPiano(Piano piano) async {
    int id = await BdProvider.bd.addPiano(piano);
    piano.id = id; //porque o piano que enviamos non ten id
    notifyListeners();
    return id;
  }

  Future<int> updatePiano(Piano piano) async {
    int num = await BdProvider.bd.updatePiano(piano);
    notifyListeners();
    return num;
  }

  Future<int> removePiano(Piano piano) async {
    int num = await BdProvider.bd.deletePiano(piano);
    notifyListeners();
    return num;
  }
}
