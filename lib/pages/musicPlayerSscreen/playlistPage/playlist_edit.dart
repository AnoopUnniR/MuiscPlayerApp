import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/playlist_db.dart';
import 'package:music_player1/models/models.dart';

class EditplayListName with PlaylistFunctionsClass {
  int? id;
  PlayListModel? data;
  final updateController = TextEditingController();
  editingPlaylist(id, data, context, index) {
    updateController.text = data.playlistName;
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit playlist name'),
        content: SizedBox(
          height: 50,
          child: Center(
            child: TextFormField(
              controller: updateController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (updateController.text.isEmpty ||
                    updateController.text.trim().isEmpty) {
                  return 'name required';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                  labelText: 'Playlist name',
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder()),
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (updateController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a name')));
              } else {
                String editedName = updateController.text.trim();
                var value =
                    PlayListModel(playlistName: editedName, playListId: id);
                updatePlaylist(value, index);
                updateController.clear();
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8177ea),
            ),
            child: const Text('save'),
          ),
          ElevatedButton(
            onPressed: () {
              updateController.clear();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff8177ea),
            ),
            child: const Text(
              'cancel',
            ),
          ),
        ],
      ),
    );
  }
}
