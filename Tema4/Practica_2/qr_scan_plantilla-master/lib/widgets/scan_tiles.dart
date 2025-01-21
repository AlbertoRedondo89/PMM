import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

/// Widget que muestra una lista de elementos (scans) según su tipo.
/// Cada elemento puede ser eliminado mediante un gesto de deslizamiento
/// o renombrado al pulsar un botón.

class ScanTiles extends StatelessWidget {
  final String tipus;
  final Color backgroundColor;
  const ScanTiles(
      {Key? key, required this.tipus, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return Container(
      color: backgroundColor,
      child: ListView.builder(
          itemCount: scans.length,
          itemBuilder: (_, index) => Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                  child: Align(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.delete_forever),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
                onDismissed: (DismissDirection direccio) {
                  Provider.of<ScanListProvider>(context, listen: false)
                      .esborraPerId(scans[index].id!);
                },
                child: ListTile(
                  leading: Icon(
                    this.tipus == 'http'
                        ? Icons.home_filled
                        : Icons.map_outlined,
                  ),
                  title: Text(scans[index].nombre?.isNotEmpty == true
                      ? scans[index].nombre! // Mostrar nombre si lo tiene
                      : scans[index]
                          .valor), // Mostrar valor si no hay nombre definido
                  subtitle: Text(scans[index].id.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _renameScan(context, scans[index].id!,
                              scans[index].nombre ?? scans[index].valor);
                        },
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  onTap: () {
                    launchUrl(context, scans[index]);
                  },
                ),
              )),
    );
  }

  void _renameScan(BuildContext context, int id, String currentName) {
    final TextEditingController controller =
        TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Renombrar elemento'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Nuevo nombre',
            hintText: 'Introduce el nuevo nombre',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                Provider.of<ScanListProvider>(context, listen: false)
                    .renombrarPerId(id, newName);
              }
              Navigator.of(context).pop();
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
