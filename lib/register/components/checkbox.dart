import 'package:flutter/material.dart';

class checkBox extends StatefulWidget {
  const checkBox({Key? key}) : super(key: key);

  @override
  State<checkBox> createState() => _checkBoxState();
}

class _checkBoxState extends State<checkBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      width: 26,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(246, 246, 246, 1),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromRGBO(112, 112, 112, 1),
        ),
      ),
      child: Checkbox(
        checkColor: Colors.white,
        value: isChecked,
        side: BorderSide.none,
        onChanged: (bool? value) {
          setState(
            () {
              isChecked = value!;
            },
          );
        },
      ),
    );
  }
}
