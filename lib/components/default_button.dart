import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    this.text,
    this.press,
  });
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fixedSize: const Size(250, 50),
          primary: Colors.white,
          backgroundColor: const Color.fromRGBO(113, 48, 148, 1),
        ),
        onPressed: press as void Function(),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: (22),
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
