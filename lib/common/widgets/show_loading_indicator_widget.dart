import 'package:flutter/material.dart';

class ShowLoadingIndicatorWidget extends StatelessWidget {
  const ShowLoadingIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
