import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/pianos_provider.dart';
import 'package:exemploexamebd/models/piano.dart';

class ListadoPianos extends StatelessWidget {
  const ListadoPianos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Lista de Pianos')),
        body: ObtenerLista(),
        floatingActionButton: FloatingActionButton(
          //Falta añadir ruta para abrir ventana add
          onPressed: () {},
          child: Icon(Icons.add),
        ));
  }
}

class ObtenerLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PianoProvider provider = Provider.of<PianoProvider>(context, listen: true);

    return FutureBuilder(
        future: provider.getPianos(),
        builder: (_, AsyncSnapshot datos) {
          if (datos.hasError) {
            //mensaxe en caso de erro
            return const Center(
              child: Text('Houbo un erro'),
            );
          }
          if (!datos.hasData) {
            //mentras carga
            return const Center(child: CircularProgressIndicator());
          }
          //en este punto "está correcto" entón podemos crear a lista e enviala aos métodos que crean o widget
          List<Piano> lista = datos.data;
          return ListaPianos(pianos: lista);
        });
  }
}

Widget ListaPianos({required List<Piano> pianos}) {
  return ListView.builder(
    itemCount: pianos.length,
    itemBuilder: (context, index) => ElementoLista(piano: pianos[index]),
  );
}

Widget ElementoLista({required Piano piano}) {
  return ListTile(
    title: Text('${piano.modelo}'),
    subtitle: Text('${piano.prezo}'),
  );
}
