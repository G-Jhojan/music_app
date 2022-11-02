// ignore_for_file: sort_child_properties_last

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_name_app/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'SOG', votes: 936),
    Band(id: '2', name: 'Blessd', votes: 489),
    Band(id: '3', name: 'Feid', votes: 78),
    Band(id: '4', name: 'Deftones', votes: 79),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'WAR-Player',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => _bandTile(bands[index])),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add_box_rounded), onPressed: addNewBand),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('id: ${band.id}');
        //todo: llamar el borrado del server
      },
      background: Container(
          padding: const EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Delete this Artist',
              style: TextStyle(color: Colors.white),
            ),
          )),
      child: ListTile(
        title: Text(band.name!),
        leading: CircleAvatar(
          child: Text(band.name!.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = TextEditingController();

    if (!Platform.isAndroid) {
      // todo esto es para android
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('New Artist Name: '),
              content: TextField(
                controller:
                    textController, // aqui almacenamos lo que escribe en este campo
              ),
              actions: [
                MaterialButton(
                    child: const Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textController
                        .text) // damos a entender que va a recibir un argumento
            )
          ],
        );
      });
    }

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('New Artist Name'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Add'),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  void addBandToList(String name) {
    print(name);
    //agregamos otra funcion, ya que vamos a reutilizar
    if (name.length > 1) {
      // si tenemos as de un caracter, podremos agregarlo
     
           
        this.bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 5));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
