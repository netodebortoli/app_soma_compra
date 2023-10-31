import 'package:flutter/material.dart';

enum MenuGrupo { editar, excluir }

class MenuAcoes extends StatelessWidget {
  const MenuAcoes({super.key, required this.onEdit, required this.onDelete});

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuGrupo>(
        tooltip: 'Menu de ações',
        onSelected: (MenuGrupo valueSelected) {
          switch (valueSelected) {
            case MenuGrupo.editar:
              onEdit;
              break;
            case MenuGrupo.excluir:
              onDelete;
              break;
          }
        },
        itemBuilder: (BuildContext context)
    {
      return <PopupMenuItem<MenuGrupo>>[
        const PopupMenuItem(
            value: MenuGrupo.editar,
            child: ListTile(
              title: Text('Editar'),
              leading: Icon(Icons.edit, color: Colors.blueAccent,),
            )),
        const PopupMenuItem(
            value: MenuGrupo.excluir,
            child: ListTile(
              title: Text('Excluir'),
              leading: Icon(Icons.delete, color: Colors.red),
            )),
      ];
    });
  }
}
