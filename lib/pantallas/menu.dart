import 'package:flutter/material.dart';
import 'package:la_casa_del_leon/modelo/cartilla.dart';
import 'package:la_casa_del_leon/pantallas/pedido.dart';
import 'package:la_casa_del_leon/pantallas/productos.dart';
import 'package:provider/provider.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Pedido()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 5, 54, 30),
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ), // Espacio superior para que el texto no choque con la barra de estado
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Bienvenido a La Casa del León 🦁, ¿Qué desea ordenar?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 0.15),
            Consumer<Cartilla>(
              builder: (context, value, child) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.items.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //una sola columna
                    childAspectRatio:
                        0.6, // Opcional: Ajusta este número las tarjetas se ven muy estiradas o cortadas
                  ),
                  itemBuilder: (context, index) {
                    return Productos(
                      nombre: value.items[index][0],
                      descripcion: value.items[index][1],
                      precio: value.items[index][2],
                      imagen: value.items[index][3],
                      onPressed: () {
                        Provider.of<Cartilla>(
                          context,
                          listen: false,
                        ).agregar(index); //agrega al pedido
                        // confirmación rápida abajo en la pantalla al agregar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${value.items[index][0]} ha sido agregado',
                            ),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
