// tasks_screens.dart
// Used to display ans manage the list of
// retrospective ideas

// imports
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens.dart';
import 'package:retrospective_reminder/widgets/app_widgets.dart';
import 'package:retrospective_reminder/models/inprovement_idea.dart';
import 'package:retrospective_reminder/utility/data_manager.dart';

// This is the main screen of the application
// It is displayed once the saved data has been loaded
class TasksScreen extends StatefulWidget {
  TasksScreen({Key? key, required this.dataManager}) : super(key: key);

  // DataManager provides access to the saved data
  DataManager dataManager;

  // List containing the improvement ideas, to be displayed
  List<ImprovementIdea> ideas = [];

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String kaizenText = "Kaizen Items";

  // used to alternate row colours
  Color getRowColor(int index) {
    Color color = Colors.tealAccent.shade400;
    if (index % 2 == 0) {
      color = Colors.tealAccent;
    }
    return color;
  }

  @override
  void initState() {
    // Get the store data - the ideas
    widget.ideas = widget.dataManager.getData();
    super.initState();
  }

  @override
  void dispose() {
    // Save the ideas
    widget.dataManager.storeData(widget.ideas);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade700,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        foregroundColor: Colors.teal.shade900,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) => AddTaskScreen(
              addOnClick: (newIdea) {
                widget.ideas.add(ImprovementIdea(ideaText: newIdea));
                widget.dataManager.storeData(widget.ideas);
                // close the ModalBottomSheet
                Navigator.pop(context);

                setState(() {
                  // is this needed
                });
              },
            ),
          );
        },
      ),
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 40,
            left: 20,
            right: 20,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Retrospective',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merriweather(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Improvement Ideas',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merriweatherSans(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      //close this app
                      dispose();
                    },
                    child: CircleAvatar(
                      child: Icon(
                        Icons.check,
                        size: 30,
                        color: Colors.teal.shade900,
                      ),
                      backgroundColor: Colors.tealAccent,
                      radius: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                kaizenText,
                // '${widget.ideas.length} Kaizen Items',
                textAlign: TextAlign.center,
                style: GoogleFonts.markoOne(
                    fontSize: 18,
                    color: Colors.teal.shade900,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.teal.shade500, Colors.teal.shade900],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          child: buildListView(),
        ))
      ]),
    );
  }

  ListView buildListView() {
    // setState(() {
    //   ideaCount = widget.ideas.length;
    // });

    return ListView.builder(
      itemCount: widget.ideas.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: getRowColor(index),
          child: TaskTile(
            itemText: widget.ideas[index].ideaText,
            index: index,
            completed: () {
              widget.ideas[index].toggleDone();
              widget.dataManager.storeData(widget.ideas);
            },
          ),
        );
      },
    );
  }
}
