import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:coop_admin/Service/storage.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('ประวัติล่าสุดของคุณ')),
      ),
      body: FutureBuilder<List<String>>(
        future: storage.listAllFiles(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                String imageURL = snapshot.data![index];
                return FutureBuilder<String>(
                  future: storage.getDownloadURL(imageURL),
                  builder: (BuildContext context,
                      AsyncSnapshot<String> downloadURLSnapshot) {
                    if (downloadURLSnapshot.connectionState ==
                            ConnectionState.done &&
                        downloadURLSnapshot.hasData) {
                      return ListTile(
                        leading: Container(
                          width: 100,
                          height: 100,
                          child: Image.network(
                            downloadURLSnapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(imageURL),
                        subtitle: FutureBuilder<FullMetadata?>(
                          future: storage.getMetadata(imageURL),
                          builder: (BuildContext context,
                              AsyncSnapshot<FullMetadata?> metadataSnapshot) {
                            if (metadataSnapshot.connectionState ==
                                    ConnectionState.done &&
                                metadataSnapshot.hasData) {
                              DateTime? creationTime =
                                  metadataSnapshot.data!.timeCreated;
                              if (creationTime != null) {
                                return Text('$creationTime');
                              } else {
                                return Text('File creation time not available');
                              }
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      );
                    } else {
                      return ListTile(
                        title: Text('Loading...'),
                      );
                    }
                  },
                );
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
