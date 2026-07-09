import 'package:flutter/material.dart';

class Productos extends StatelessWidget {
  final String nombre;
  final String descripcion;
  final String precio;
  final String imagen;
  final void Function()? onPressed;

  const Productos({
    super.key,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.imagen,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 25, bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 127, 235, 56)),
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(imagen, height: 60, width: 75, fit: BoxFit.cover),
            SizedBox(height: 5),
            Text(
              nombre,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              descripcion,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 5),
            MaterialButton(
              onPressed: onPressed,
              color: Color.fromRGBO(143, 212, 31, 1),
              child: Text(
                'Agregar por \$$precio',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
