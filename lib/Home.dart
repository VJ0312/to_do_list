import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

int rVal, gVal, bVal;

double oVal;

//initializing global variables
class Item {
  String title;
  String body;
  String newTitle;
  String newBody;

  int r;
  int g;
  int b;

  double o;

  bool titleChanged = false;
  bool bodyChanged = false;
  bool checked = false;

  Item(this.title, this.body, this.r, this.g, this.b, this.o);
  //creating class "Item" and initializing properties
}

class Home extends StatefulWidget {
  @override
  home createState() => home();
  // creating instance of class Home
}

//ignore: camel_case_types
class home extends State<Home> {
  var titleC = TextEditingController();
  var bodyC = TextEditingController();

  List<Item> listItem = [];

  void initState() {
    super.initState();
    listItem.add(Item("Meeting", "Meeting at 1:30", 226, 169, 235, 1));
    // adding sample to-do item
  }

  void printDate() {
    var currDate = DateTime.now();
    String day = currDate.day.toString();
    String month = currDate.month.toString();
    int year = currDate.year;
    // getting current date
  }

  void handleDismissed(var direction, index) {
    setState(() {});
    if (direction == DismissDirection.startToEnd) {
      if (listItem.contains(listItem.removeAt(index))) {
        setState(() {
          listItem.remove(listItem.removeAt(index));
        });
      }
      setState(() {});
    }
    // when swipe, delete item
  }

  Widget createNewDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.blueGrey,
            child: Column(children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  "Create new event",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              TextField(
                  decoration: InputDecoration(hintText: "Enter title"),
                  textAlign: TextAlign.center,
                  controller: titleC),
              // get title
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(hintText: "Enter body"),
                textAlign: TextAlign.center,
                controller: bodyC,
                // get body
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Note Color", style: TextStyle(fontSize: 20)),
              ),
              // get color
              Padding(
                padding: EdgeInsets.only(left: 40),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          color(255, 115, 198, 1),
                          SizedBox(height: 20, width: 10),
                          color(224, 136, 126, 1),
                          SizedBox(height: 20, width: 10),
                          color(184, 247, 168, 1),
                          SizedBox(height: 20, width: 10),
                          color(187, 230, 129, 1),
                          SizedBox(height: 20, width: 10),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          color(247, 213, 109, 1),
                          SizedBox(height: 20, width: 10),
                          color(168, 247, 211, 1),
                          SizedBox(height: 20, width: 10),
                          color(128, 183, 194, 1),
                          SizedBox(height: 20, width: 10),
                          color(120, 173, 207, 1),
                          SizedBox(height: 20, width: 10),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          color(115, 115, 145, 1),
                          SizedBox(height: 20, width: 10),
                          color(226, 169, 235, 1),
                          SizedBox(height: 20, width: 10),
                          color(255, 179, 235, 1),
                          SizedBox(height: 20, width: 10),
                          color(252, 255, 179, 1),
                          SizedBox(height: 20, width: 10),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                        child: FlatButton(
                            color: Colors.blue,
                            child: Text("Save"),
                            onPressed: () {
                              setState(() {
                                listItem.add(Item(
                                    titleC.text,
                                    bodyC.text,
                                    rVal ?? 226,
                                    gVal ?? 169,
                                    bVal ?? 235,
                                    oVal ?? 1));
                              });
                              Navigator.pop(context);
                            }),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          );
        });
  }

  Widget color(int r, int g, int b, double op) {
    return IconButton(
      icon: Icon(MdiIcons.square, size: 50),
      color: Color.fromRGBO(r, g, b, op),
      onPressed: () => setState(() {
        rVal = r;
        gVal = g;
        bVal = b;
        oVal = op;
      }),
    );
  }

  Widget build(BuildContext context) {
    var currDate = DateTime.now();
    String day = currDate.day.toString();
    String month = currDate.month.toString();
    int year = currDate.year;

    return Scaffold(
        backgroundColor: Colors.blueGrey,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            MdiIcons.notePlus,
          ),
          onPressed: () {
            setState(() {
              createNewDialog();
              // when "+" icon is pressed, create new item
            });
          },
        ),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Text("$day/$month/$year",
                      // print date at top of screen
                      style: TextStyle(
                        fontSize: 60,
                        color: Colors.white,
                      )),
                )),
            Container(
              alignment: Alignment.center,
              child: listItem.length == 0
                  ? Text("No Tasks",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        // if there are no to-do's, print "no items"
                      ))
                  : null,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
              child: ListView.builder(
                  itemCount: listItem.length,
                  itemBuilder: (context, index) {
                    var item = listItem[index];
                    return Dismissible(
                        key: ObjectKey(item),
                        child: itemCard(
                            listItem[index].titleChanged
                                ? listItem[index].newTitle
                                : item.title,
                            listItem[index].bodyChanged
                                ? listItem[index].newBody
                                : item.body,
                            index,
                            listItem[index].r,
                            listItem[index].g,
                            listItem[index].b,
                            listItem[index].o),
                        onDismissed: (direction) {
                          handleDismissed(direction, index);
                          // passing in variables to Widget itemCard
                        });
                  }),
            ),
          ],
        ));
  }

  Widget itemCard(String title, body, int index, int R, G, B, double O) {
    var itemTitleController = TextEditingController();
    var itemBodyController = TextEditingController();

    itemTitleController.text = title;
    itemBodyController.text = body;

    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Color.fromRGBO(169, 229, 235, 20),
        // 169, 229, 235
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 100,
            color: Color.fromRGBO(R, G, B, O),
            child: checkBox(index, itemTitleController, itemBodyController)));
  }

  Widget checkBox(var index, itemTitleController, itemBodyController) {
    return CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: listItem[index].checked,
        onChanged: (value) {
          setState(() {
            listItem[index].checked = value;
          });
        },
        title: TextField(
          controller: itemTitleController,
          style: TextStyle(
            fontSize: 25,
            decoration:
                listItem[index].checked ? TextDecoration.lineThrough : null,
            decorationThickness: 4,
          ),
          onSubmitted: (value) {
            setState(() {
              listItem[index].titleChanged = true;
              listItem[index].newTitle = value;
            });
          },
          decoration: InputDecoration(
              hintText: "Sample title", border: InputBorder.none),
        ),
        subtitle: TextField(
          controller: itemBodyController,
          style: TextStyle(
            fontSize: 15,
            decoration:
                listItem[index].checked ? TextDecoration.lineThrough : null,
            decorationThickness: 4,
          ),
          onSubmitted: (value) {
            setState(() {
              listItem[index].bodyChanged = true;
              listItem[index].newBody = value;
            });
          },
          decoration: InputDecoration(
              hintText: "Tap to edit. Swipe to delete",
              border: InputBorder.none),
        ));
  }
}
