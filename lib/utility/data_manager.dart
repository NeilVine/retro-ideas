//data_manager.dart file used to Manage data persistence

// imports
import 'package:retrospective_reminder/models/inprovement_idea.dart';
import 'package:shared_preferences/shared_preferences.dart';

// DataManager
// Read/Write data locally on device using shared_preferences
class DataManager {
  late SharedPreferences prefs;

  // Init must be called prior to any read/write
  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Return the data that was saved
  List<ImprovementIdea> getData() {
    List<ImprovementIdea> ideas = [];
    List<String> data = [];

    try {
      data = prefs.getStringList('ideas') ?? [];
    } catch (e) {
      // list not found
    }

    for (var item in data) {
      ideas.add(ImprovementIdea(ideaText: item));
    }

    return ideas;
  }

  // Store the ideas
  void storeData(List<ImprovementIdea> ideas) async {
    prefs = await SharedPreferences.getInstance();

    List<String> dataToStore = [];

    for (var idea in ideas) {
      if (!idea.isDone) {
        dataToStore.add(idea.ideaText);
      }
    }

    prefs.setStringList('ideas', dataToStore);
  }
}
