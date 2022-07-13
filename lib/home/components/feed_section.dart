import 'package:flutter/material.dart';
import 'package:kosmos_app/home/components/cupertino_delete_widget.dart';
import 'package:kosmos_app/home/components/identification_section.dart';
import 'package:kosmos_app/home/first_post_page.dart';
import 'package:kosmos_app/home/second_post_page.dart';

import 'cupertino_signal_widget.dart';

class FeedSection extends StatelessWidget {
  const FeedSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FirstPostPage(),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 350.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://www.biot.fr/wp-content/uploads/2018/09/desert-02-360x260.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      CupertinoSignalWidget(
                        colorBack: Colors.transparent,
                      ),
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
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondPostPage(),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 350.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://patrimmoveo.files.wordpress.com/2021/07/pexels-photo-4245826.jpeg'),
                  fit: BoxFit.cover),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      CupertinoDeleteWidget(
                        colorBack: Colors.transparent,
                      )
                    ],
                  ),
                  const SizedBox(height: 220),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      IdentificationSection(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
