import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MessageStyle extends StatelessWidget {
  final FlutterTts tts = FlutterTts();
  final _text;
  final int s;

  MessageStyle(this._text, this.s);

  @override
  Widget build(BuildContext context) {
    Future _speak() async {
      await tts.speak(_text);
    }

    return SingleChildScrollView(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
              child: (s == 0)
                  ? Padding(
                      padding: EdgeInsets.only(right: 70),
                      child: Container(
                        // margin: const EdgeInsets.symmetric(vertical: 6),
                        margin:
                            const EdgeInsets.only(top: 6, left: 10, right: 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          // color: Color.fromRGBO(190, 177, 199, 4),
                          color: Color.fromRGBO(140, 140, 153, 4),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(2),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            _text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            textWidthBasis: TextWidthBasis.longestLine,
                            maxLines: 5,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 150),
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 6, left: 10, right: 15),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 22),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(190, 177, 199, 4),
                          //color: Color.fromRGBO(140, 140, 153, 4),
                          // Theme
                          //     .of(context)
                          //     .splashColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(2),
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            _text,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 6,
                          ),
                          onTap: () => _speak(),
                        ),
                      ),
                    )),
        ],
      ),
    );
  }
}
