import 'package:flutter/material.dart';

class FormPhoto extends StatelessWidget {
  final thoughts = TextEditingController();
  final title = TextEditingController();
  final urlImage = TextEditingController();
  final Function formHandler;

  FormPhoto(this.formHandler);

  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(children: [
        TextFormField(
          controller: title,
          decoration: const InputDecoration(
            hintText: 'Ingresa un título',
          ),
        ),
        TextFormField(
          controller: thoughts,
          decoration: const InputDecoration(
            hintText: 'Describe la foto',
          ),
        ),
        TextFormField(
          controller: urlImage,
          decoration: const InputDecoration(
            hintText: 'Ingresa la URL de la imagen',
          ),
        ),
        RaisedButton(
          child: Text('Enviar'),
          onPressed: () =>
              formHandler(title.text, thoughts.text, urlImage.text),
        ),
      ]),
    );
  }
}
