import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoDeleteWidget extends StatelessWidget {
  final colorBack;
  const CupertinoDeleteWidget({
    Key? key,
    this.colorBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorBack,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: const Icon(
          Icons.more_vert_sharp,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () {
          Navigator.of(context).restorablePush(_modalBuilder);
        },
      ),
    );
  }

  static Route<void> _modalBuilder(BuildContext context, Object? arguments) {
    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          message: const Text('Que souhaitez-vous faire ?'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const Text(
                'Supprimer la publication',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {},
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text(
              'Annuler',
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
