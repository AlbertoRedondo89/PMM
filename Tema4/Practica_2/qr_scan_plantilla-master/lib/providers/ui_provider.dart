import 'package:flutter/material.dart';

/// Proveedor para manejar la opción de menú seleccionada
/// en la barra de navegación inferior. Permite cambiar el índice
/// y notifica a los listeners para actualizar la UI.

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int index) {
    this._selectedMenuOpt = index;
    notifyListeners();
  }
}
