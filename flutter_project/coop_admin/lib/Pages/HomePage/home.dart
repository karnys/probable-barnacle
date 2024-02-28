import 'package:coop_admin/Service/storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Storage storage = Storage();
  String uid = 'oHgjBDvQ1Sek6GUkpZchFS3pc7F3'; // UID you want to use

  Future<List<Widget>> fetchFileMetadata(List<String> imageUrls) async {
    List<Widget> listWidgets = [];

    for (int i = 0; i < imageUrls.length; i++) {
      String imageUrl = imageUrls[i];
      try {
        firebase_storage.FullMetadata? metadata =
            await storage.getMetadata(uid, imageUrl);
        if (metadata != null) {
          DateTime? creationTime = metadata.timeCreated;
          if (creationTime != null) {
            String formattedDateTime =
                '${creationTime.day}/${creationTime.month}/${creationTime.year} ${creationTime.hour < 10 ? '0${creationTime.hour}' : creationTime.hour}:${creationTime.minute < 10 ? '0${creationTime.minute}' : creationTime.minute}:${creationTime.second < 10 ? '0${creationTime.second}' : creationTime.second}';
            listWidgets.add(ListTile(
              title: Text(
                formattedDateTime,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ));
          } else {
            listWidgets.add(ListTile(
              title: Text('File creation time not available'),
            ));
          }
        } else {
          listWidgets.add(ListTile(
            title: Text('Metadata not available or error occurred.'),
          ));
        }
      } catch (e) {
        listWidgets.add(ListTile(
          title: Text('Error fetching file metadata: $e'),
        ));
      }
    }

    return listWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(image: AssetImage('assets/images/it-technocom.png')),
        ),
        leadingWidth: 200,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          )
        ],
      ),
      body: FutureBuilder<List<String>>(
        future: storage.listAllFiles(uid),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return FutureBuilder<List<Widget>>(
              future: fetchFileMetadata(snapshot.data!),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Widget>> metadataSnapshot) {
                if (metadataSnapshot.connectionState == ConnectionState.done) {
                  return ListView(
                    children: metadataSnapshot.data!,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
