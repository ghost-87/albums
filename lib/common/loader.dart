import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class SquareLoader extends StatelessWidget {
  final size;
  SquareLoader({this.size});
  @override
  Widget build(BuildContext context) {
    return GFLoader(
      type: GFLoaderType.square,
      loaderColorOne: Colors.blue,
      loaderColorTwo: Colors.blueGrey,
      loaderColorThree: Colors.red,
      size: size ?? 45,
      // ),
    );
  }
}
