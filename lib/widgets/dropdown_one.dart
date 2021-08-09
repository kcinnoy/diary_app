import 'package:flutter/material.dart';

class DropdownOne extends StatefulWidget {
  final String? text;

  const DropdownOne({Key? key, required this.text}) : super(key: key);

  @override
  _DropdownOneState createState() => _DropdownOneState();
}

//class function

class _DropdownOneState extends State<DropdownOne> {
  GlobalKey? ddKeyOne;
  double? height, width, xPosition, yPosition;
  bool isDropdownOpen = false;

  @override
  void initState() {
    ddKeyOne = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox =
        ddKeyOne!.currentContext!.findRenderObject()! as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print(height);
    print(width);
    print(xPosition);
    print(yPosition);
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition,
        width: width,
        top: yPosition! + height!,
        height: 2 * height!,
        child: Container(
          color: Colors.greenAccent,
          height: 200,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: ddKeyOne,
      onTap: () {
        setState(() {
          findDropdownData();
          OverlayEntry? floatingDropdown = _createFloatingDropdown();
          Overlay.of(context)!.insert(floatingDropdown);

          isDropdownOpen = !isDropdownOpen;
        });
      },
      child: SizedBox(
        width: 150,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.red[600],
          child: Row(
            children: [
              Text(
                widget.text!,
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
