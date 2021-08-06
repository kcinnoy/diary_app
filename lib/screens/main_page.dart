import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Diary',
              style: TextStyle(
                fontSize: 39,
                color: Colors.blueGrey[100],
              ),
            ),
            Text(
              'Book',
              style: TextStyle(
                fontSize: 39,
                color: Colors.green,
              ),
            )
          ],
        ),
        backgroundColor: Colors.grey.shade100,
        toolbarHeight: 70,
        elevation: 4,
      ),
    );
  }
}
