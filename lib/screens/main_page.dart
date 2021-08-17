import 'package:diary_app/widgets/dropdown_one.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? _dropDownText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //primary: false,
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
            ),
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: (_dropDownText == null)
                        ? Text(
                            'Select',
                            style: TextStyle(color: Colors.grey),
                          )
                        : Text(
                            _dropDownText!,
                            style: TextStyle(color: Colors.grey),
                          ),
                    items: <String>['Latest', 'Earliest']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value == 'Latest') {
                        setState(() {
                          _dropDownText = value.toString();
                        });
                      } else if (value == 'Earliest') {
                        setState(() {
                          _dropDownText = value.toString();
                        });
                      }
                    }, //onChanged
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    dropdownColor: Colors.deepOrange,
                  ),
                ),
              ),
              DropdownOne(
                text: "CTA",
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      InkWell(
                        child: CircleAvatar(
                          child: Text(
                            'James \n Smith',
                            softWrap: true,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                          radius: 30,
                          backgroundColor: Colors.red,
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/id/1005/200/300'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.view_agenda_outlined,
                              size: 19,
                              color: Colors.black,
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.grey[200],
        toolbarHeight: 70,
        elevation: 0,
      ),
      //Body Start
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.green,
              child: Column(
                children: [],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: Column(),
            ),
          )
        ],
      ),
    );
  }
}
