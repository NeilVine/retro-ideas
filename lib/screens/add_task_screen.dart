// add_task_screen.dart
// Used for adding a task

// imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Used as a Modal Bottom Sheet
// for user to enter a new idea
class AddTaskScreen extends StatelessWidget {
  String ideaToAdd = "";

  final Function(String) addOnClick;

  AddTaskScreen({Key? key, required this.addOnClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Colors.tealAccent,
        onPrimary: Colors.teal.shade900,
        shadowColor: Colors.teal.shade900,
        elevation: 6,
        fixedSize: Size(80, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(color: Colors.teal.shade900, width: 2),
        ),
        textStyle: const TextStyle(fontSize: 20));

    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5.0,
            // assign the color to the border color
            color: const Color(0xff16221c),
          ),
          color: const Color(0xff16221c),
        ),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.tealAccent.shade700,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Text(
                'Kaizen Item',
                textAlign: TextAlign.center,
                style: GoogleFonts.markoOne(
                    fontSize: 18,
                    color: Colors.teal.shade900,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 5),
              Row(children: <Widget>[
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    onChanged: (String t) {
                      ideaToAdd = t;
                    },
                    onSubmitted: (String t) {
                      ideaToAdd = t;
                      addOnClick(ideaToAdd);
                    },
                    autofocus: true,
                    style: GoogleFonts.merriweatherSans(
                        fontSize: 16,
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.normal),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter improvement idea',
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.teal.shade900, width: 2.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: style,
                  onPressed: () {
                    addOnClick(ideaToAdd);
                  },
                  child: Text(
                    'Add',
                    style: GoogleFonts.merriweather(
                        fontSize: 20,
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
              ]),
            ],
          ),
        ));
  }
}
