import 'package:flutter/material.dart';

class PlayerTitle extends StatelessWidget {
 var text1, text2;
 PlayerTitle(this.text1, this.text2);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: Text(text1, style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),textAlign: TextAlign.center,)
        ),
        Expanded(
            child: Text(text2, style: TextStyle(fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),textAlign: TextAlign.center)
        )
      ],
    );
  }
}
