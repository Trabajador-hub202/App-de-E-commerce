import 'package:flutter/material.dart';

class Cartilla extends ChangeNotifier {
  final List _items = [
    // nombre,   descripcion , precio, imagen
    [
      'Club Sandwich',
      'Delicioso sandwich de 4 niveles con pan tostado,tomate, cebolla, pechuga de pollo deshuesada, lechuga, salsa y mayonesa. Incluye papas fritas',
      '5.00',
      'assets/clubsandwich.png',
    ],
    [
      'Quesadillas de carne',
      '3 quesadillas con queso y carne de res con aderezo de yogurt y salsa de tomate para acompañar. Incluye té helado de limón',
      '3.00',
      'assets/quesadillas.png',
    ],
    [
      'Cheesecake',
      'Deliciosa porción de chessecake de fresa. Incluye taza de café',
      '5.00',
      'assets/cheesecake.png',
    ],
    [
      'Copa de helado',
      'Deliciosa copa de helado de vainilla y cereza',
      '1.75',
      'assets/heladovainilla.png',
    ],
    [
      'Jugo de naranja',
      'Delicioso vaso de jugo de naranja',
      '3.00',
      'assets/naranja.png',
    ],
    [
      'Té helado de limón',
      'Delicioso vaso de té helado de limón',
      '1.50',
      'assets/tehelado.png',
    ],
    [
      'Café',
      'Delicioso vaso de café del volcán Chinchontepec, agregue leche por 0.50',
      '1.50',
      'assets/cafe.png',
    ],
    [
      'Menú del día',
      'Lunes Bistec de higado encebollado, Martes Lasagna de pollo, Miércoles Camarones al ajillo, Jueves Pollo guisado, Viernes Pescado frito, incluye arroz, 2 tortillas y ensalada fresca',
      '4.00',
      'assets/menudeldia.png',
    ],
  ];
  //lista de los productos seleccionados
  final List _cartillas = [];

  //productos presentados
  List get items => _items;

  //obtener productos seleccionados
  List get cartillas => _cartillas;

  //agregar productos al pedido
  void agregar(int index) {
    _cartillas.add(items[index]);
    notifyListeners(); //escuchar los cambios
  }

  //calcular el total del pedido
  String sumatoria() {
    double total = 0;
    for (int i = 0; i < _cartillas.length; i++) {
      total += double.parse(_cartillas[i][2]);
    }
    return total.toStringAsFixed(2);
  }

  //eliminar productos del pedido
  void eliminar(int index) {
    _cartillas.removeAt(index);
    notifyListeners(); //escuchar los cambios
  }
}
