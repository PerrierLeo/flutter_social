import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cupertino_delete_widget.dart';
import 'cupertino_signal_widget.dart';
import 'identification_section.dart';

class FeedSection extends StatefulWidget {
  const FeedSection({Key? key}) : super(key: key);

  @override
  State<FeedSection> createState() => _FeedSectionState();
}

class _FeedSectionState extends State<FeedSection> {
  final Stream<QuerySnapshot> _FeedStream =
      FirebaseFirestore.instance.collection('Posts').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _FeedStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> post =
                document.data()! as Map<String, dynamic>;
            return InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 350.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(post['image_url']),
                      fit: BoxFit.cover),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (currentUser?.uid != post['id'])
                            const CupertinoSignalWidget(
                              colorBack: Colors.transparent,
                            ),
                          if (currentUser?.uid == post['id'])
                            CupertinoDeleteWidget(
                                colorBack: Colors.black.withOpacity(0.2))
                        ],
                      ),
                      const SizedBox(height: 220),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          IdentificationSection(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
