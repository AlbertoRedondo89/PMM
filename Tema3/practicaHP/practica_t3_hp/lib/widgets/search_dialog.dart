import 'package:flutter/material.dart';
import 'package:practica_t3_hp/providers/meals_provider.dart';
import 'package:provider/provider.dart';
/*
Widget del buscador. Pide una categoría al usuario y comprueba si hay resultados en la api. 
Si los hay, abre una detail_screen con la receta.
*/
class SearchDialog extends StatefulWidget {
  const SearchDialog({Key? key}) : super(key: key);

  @override
  State<SearchDialog> createState() => _SearchDialogState();
}

class _SearchDialogState extends State<SearchDialog> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Buscar Receta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Escribe el nombre de la receta',
            ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: CircularProgressIndicator(),
            ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _searchRecipe,
          child: const Text('Buscar'),
        ),
      ],
    );
  }

  Future<void> _searchRecipe() async {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, introduce un nombre de receta.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final mealsProvider = Provider.of<MealsProvider>(context, listen: false);
      final receta = await mealsProvider.getDatosReceta(query, false);

      if (receta != null) {
        Navigator.of(context).pop(); // Cerrar el diálogo
        Navigator.pushNamed(context, 'details', arguments: receta.getIdMeal());
      } else {
        setState(() {
          _errorMessage = 'Receta no encontrada.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al buscar la receta.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
