import 'package:flutter/material.dart';
import 'package:la_casa_del_leon/modelo/cartilla.dart';
import 'package:la_casa_del_leon/pantallas/formulariodomicilio.dart';
import 'package:provider/provider.dart';

class Pedido extends StatelessWidget {
  const Pedido({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormularioDomicilio(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 6, 80, 28),
        child: const Icon(Icons.motorcycle, color: Colors.white),
      ),

      appBar: AppBar(title: const Text('Usted ha agregado a su orden...')),
      body: Consumer<Cartilla>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount:
                      value.cartillas.length, //construye todas las cartillas
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 176, 204, 177),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            value.cartillas[index][3],
                            height: 20,
                            width: 20,
                          ), //imagen
                          title: Text(
                            '${value.cartillas[index][0]} \$${value.cartillas[index][2]}',
                          ), //nombre y precio
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => Provider.of<Cartilla>(
                              context,
                              listen: false,
                            ).eliminar(index),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: 500,
                color: const Color.fromARGB(255, 189, 255, 114),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Total a pagar',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      '\$${value.sumatoria()}',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 6, 87, 26),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 75),
            ],
          );
        },
      ),
    );
  }
}
