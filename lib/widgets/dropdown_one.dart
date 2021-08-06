import 'package:flutter/material.dart';

class DropdownOne extends StatefulWidget {
  const DropdownOne({Key? key}) : super(key: key);

  @override
  _DropdownOneState createState() => _DropdownOneState();
}

//class function

class _DropdownOneState extends State<DropdownOne> {
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isDropdownOpen = !isDropdownOpen;
        });
      },
      child: SizedBox(
        width: 100,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.red[600],
          child: Row(
            children: [
              Text(
                'CTA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
