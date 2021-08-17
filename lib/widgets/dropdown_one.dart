import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  OverlayEntry? floatingDropdown;

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
        top: yPosition! + height! + 20,
        height: 2 * height!,
        child: DropDown(
          itemHeight: height,
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
          if (isDropdownOpen) {
            floatingDropdown!.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context)!.insert(floatingDropdown!);
          }
          isDropdownOpen = !isDropdownOpen;
        });
      },
      child: SizedBox(
        width: 150,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.text!,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 5,
              ),
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

class DropDown extends StatelessWidget {
  final double? itemHeight;
  const DropDown({Key? key, this.itemHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //SizedBox(
        //  height: 5,
        // ),
        Align(
          alignment: Alignment(-0.8, 0),
          child: ClipPath(
            clipper: ArrowClipper(),
            child: Container(
              height: 20,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.red[600],
              ),
            ),
          ),
        ),
        Material(
          elevation: 20,
          shape: ArrowShape(),
          child: Container(
            //height: 1 * itemHeight!,
            constraints: BoxConstraints(maxHeight: double.infinity),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: <Widget>[
                DropDownItem.first(
                  text: "Earliest",
                  iconData: Icons.arrow_circle_up_sharp,
                  isSelected: false,
                ),
                DropDownItem.last(
                  text: "Latest",
                  iconData: Icons.arrow_circle_down_sharp,
                  isSelected: false,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class DropDownItem extends StatelessWidget {
  final String? text;
  final IconData? iconData;
  final bool? isSelected;
  final bool isFirstItem;
  final bool isLastItem;

  const DropDownItem(
      {Key? key,
      this.text,
      this.iconData,
      this.isSelected = false,
      this.isFirstItem = false,
      this.isLastItem = false})
      : super(key: key);

  factory DropDownItem.first(
      {String? text, IconData? iconData, bool? isSelected}) {
    return DropDownItem(
      text: text,
      iconData: iconData,
      isSelected: isSelected,
      isFirstItem: true,
    );
  }

  factory DropDownItem.last(
      {String? text, IconData? iconData, bool? isSelected}) {
    return DropDownItem(
      text: text,
      iconData: iconData,
      isSelected: isSelected,
      isLastItem: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected! ? Colors.red[900] : Colors.red[600],
        borderRadius: BorderRadius.vertical(
            top: isFirstItem ? Radius.circular(8) : Radius.zero,
            bottom: isLastItem ? Radius.circular(8) : Radius.zero),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
      child: Row(
        children: [
          Text(
            text!,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Spacer(),
          Icon(
            iconData,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class ArrowShape extends ShapeBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getOuterPath
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }
}
