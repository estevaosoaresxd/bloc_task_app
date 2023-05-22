import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback onTapDelete;
  final VoidCallback onTapFavorite;
  final VoidCallback onTapEdit;
  final VoidCallback onTapRestore;

  const PopupMenu({
    Key? key,
    required this.onTapDelete,
    required this.task,
    required this.onTapFavorite,
    required this.onTapEdit,
    required this.onTapRestore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? (c) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: onTapEdit,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                  onTap: null,
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavorite == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_remove_outlined),
                    label: task.isFavorite == false
                        ? const Text('Add to \nBookmarks')
                        : const Text('Remove from \nBookmarks'),
                  ),
                  onTap: onTapFavorite,
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                  onTap: onTapDelete,
                )
              ]
          : (c) => [
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restore_from_trash),
                    label: const Text('Restore'),
                  ),
                  onTap: onTapRestore,
                ),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete Forever'),
                  ),
                  onTap: onTapDelete,
                )
              ],
    );
  }
}
