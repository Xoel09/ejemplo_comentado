
import 'package:exemploexamebd/providers/pianos_provider.dart';
import 'package:flutter/material.dart';
import 'package:exemploexamebd/models/piano.dart';
import 'package:provider/provider.dart';
class FormularioAltaPiano extends StatefulWidget {
  const FormularioAltaPiano({Key? key}) : super(key: key);

  @override
  _FormularioAltaPianoState createState() => _FormularioAltaPianoState();
}

class _FormularioAltaPianoState extends State<FormularioAltaPiano> {
  final _formKey = GlobalKey<FormState>(); // Para validar un formulario
  bool? checkbox = false;
  final Piano piano = Piano.vacio();

  @override
  Widget build(BuildContext context) {
    // Como non hai que modificar un piano, non fai falta recibilo como argmuments, basta con xerar un Piano.vacio()
    //final piano = ModalRoute.of(context)!.settings.arguments as Piano;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Alta piano'),
        ),
        body: Column(
          children: [
            Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Expanded(
                  child: ListView(
                    children: [
                      _crearModelo(piano),
                      _crearAno(piano),
                      _crearNuevo(piano),
                      _crearPrecio(piano),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _crearBoton(piano),
                      ),
                    ],
                  ),
                ))
          ],
        ));
  }

  Widget _crearModelo(Piano piano) {
    return TextFormField(
      initialValue: piano.modelo,
      validator: (value) {
        if (value == null) return "O modelo é obrigatorio";
        if (value.length > 25) {
          return "O modelo non pode ter máis de 25 caracteres";
        }
        return null;
      },
      maxLength: 25,
      decoration: const InputDecoration(
        hintText: 'Modelo',
      ),
      onChanged: (value) => setState(() {
        piano.modelo = value;
      }),
    );
  }

  Widget _crearAno(Piano piano) {
    return TextFormField(
      initialValue: piano.ano_compra == null ? "" : piano.ano_compra.toString(),
      keyboardType: TextInputType.number,
      maxLength: 4,
      validator: (value) => value?.length != 4 ? 'Engada o ano (xxxx)' : null,
      decoration: const InputDecoration(
        hintText: 'Ano compra',
      ),
      onChanged: (value) {
        setState(() {
          piano.ano_compra = int.tryParse(value);
        });
      },
    );
  }

  Widget _crearNuevo(Piano piano) {
    return CheckboxListTile(
      value: checkbox,
      title: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: Text("Piano nuevo?"),
      ),
      onChanged: (value) {
        setState(() {
          checkbox = value ?? false;
          piano.novo = checkbox;
        });
      },
    );
  }

  Widget _crearPrecio(Piano piano) {
    return TextFormField(
      initialValue: piano.prezo == null ? "" : piano.prezo.toString(),
      validator: (value) {
        double? val = double.tryParse(value!);
        if (val == null) return 'O prezo é obrigatorio';
      },
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: const InputDecoration(
        hintText: 'Precio',
      ),
      onChanged: (value) => setState(() {
        piano.prezo = double.tryParse(value);
      }),
    );
  }

  Widget _crearBoton(Piano piano) {
    return ElevatedButton(
        onPressed: () async {
          //Validamos os campos co formKey
          if (_formKey.currentState!.validate()) {
            /*Hai que chamar ao provider desta forma, con listen a false etc...
            De chamar ao ProviderPiano directamente, engade o piano á base de datos,
            pero non redibuxa a lista da pantalla principal*/

            PianoProvider provider =
            Provider.of<PianoProvider>(context, listen: false);

            await provider
                .addPiano(piano)
                .then((value) => Navigator.of(context).pop());
          }
        },
        child: const Text('Alta Piano'));
  }
}
