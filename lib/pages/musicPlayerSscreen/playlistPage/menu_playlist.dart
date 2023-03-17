import 'package:flutter/material.dart';
import 'package:music_player1/functions/databaseFunctions/favourites_db.dart';
import 'package:music_player1/functions/databaseFunctions/playlist_db.dart';
import 'package:music_player1/models/models.dart';

class MenuIconPlaylistClass
    with FavouriteFunctionClass, PlaylistFunctionsClass {
  menuButton({context, title, id, image, artist, path, index}) {

    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 233, 233, 233),
      context: context,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 14.0, bottom: 14, right: 20, left: 20),
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.black, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: Builder(
                  builder: (context) {
                    var isFav = isInFav(id);
                    if (isFav == true) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff121526)),
                        child: const Text(
                          'REMOVE FROM FAVOURITE',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          deleteFavourite(id, context, title);
                          Navigator.pop(context);
                        },
                      );
                    } else {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff121526)),
                        child: const Text(
                          'ADD TO FAVOURITE',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onPressed: () {
                          var listFavourites = FavouritesModel(
                              imageId: image,
                              songTitle: title,
                              songArtist: artist,
                              songuri: path,
                              id: id);
                          addFavourites(listFavourites, context);
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 8),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff121526)),
                  onPressed: () {
                    removeFromPlaylist(id, context);
                    Navigator.pop(context);
                    // playlistSong.reload();
                  },
                  child: const Text(
                    'REMOVE FROM PLAYLIST',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 18.0, right: 18, bottom: 10, top: 10),
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 119, 109, 234)),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'cancel',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
