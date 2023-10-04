import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class adaptiveFlatButton extends StatefulWidget {


  Function onClick;
  String buttonName;

  adaptiveFlatButton({
    required this.buttonName,
    required this.onClick,
    });

  @override
  State<adaptiveFlatButton> createState() => _adaptiveFlatButtonState();
}

class _adaptiveFlatButtonState extends State<adaptiveFlatButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Platform.isIOS ?
      CupertinoButton(
        child:  Text(widget.buttonName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),),
        onPressed: widget.onClick(),
      ) :TextButton(
          child: Text(widget.buttonName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
          onPressed: widget.onClick(),
      ),
    );
  }
}

