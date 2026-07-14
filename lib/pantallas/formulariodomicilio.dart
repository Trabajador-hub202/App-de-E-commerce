import 'package:flutter/material.dart';
import 'package:la_casa_del_leon/modelo/cartilla.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FormularioDomicilio extends StatefulWidget {
  const FormularioDomicilio({super.key});

  @override
  State<FormularioDomicilio> createState() => _FormularioDomicilioState();
}

class _FormularioDomicilioState extends State<FormularioDomicilio> {
  final _formKey = GlobalKey<FormState>();

  final _nombreController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _direccionController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _telefonoController.dispose();
    _direccionController.dispose();
    super.dispose();
  }

  void _enviarWhatsApp() async {
    if (_formKey.currentState!.validate()) {
      final carrito = Provider.of<Cartilla>(context, listen: false);

      //pedido
      String listaProductos = '';
      for (var producto in carrito.cartillas) {
        listaProductos += '- ${producto[0]} (\$${producto[2]})\n';
      }

      String celularNegocio = '503--------';

      String mensaje =
          '¡Hola La Casa del León! 🦁\n'
          'Deseo realizar el siguiente pedido:\n\n'
          '*Productos pedidos:*\n'
          '$listaProductos\n'
          '*Total a pagar:* \$${carrito.sumatoria()}\n\n'
          '*Datos de entrega:*\n'
          '• *A nombre de:* ${_nombreController.text}\n'
          '• *Teléfono de contacto:* ${_telefonoController.text}\n'
          '• *Dirección:* ${_direccionController.text}';

      // Esquema óptimo optimizado para aplicaciones móviles
      final Uri whatsappUri = Uri.parse(
        "whatsapp://send?phone=$celularNegocio&text=${Uri.encodeComponent(mensaje)}",
      );

      try {
        // Ejecución nativa del movil
        await launchUrl(
          whatsappUri,
          mode: LaunchMode.externalNonBrowserApplication,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'No se pudo abrir WhatsApp. Puede ser que no este instalada.',
              ),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos de Envío'),
        backgroundColor: const Color.fromARGB(255, 59, 48, 18),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _enviarWhatsApp,
        backgroundColor: const Color.fromARGB(255, 114, 219, 65),
        icon: const Icon(Icons.send, color: Colors.white),
        label: const Text(
          'Confirmar envío',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _telefonoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Número de teléfono',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.call),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingrese su número de teléfono';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _direccionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Dirección de entrega',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingrese su dirección exacta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
