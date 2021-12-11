// improvement_idea.dart

// Holds
// 1. ideaText: the text describing an improvement idea
// 2. isDone: a flag to indicate is the item has been completed
class ImprovementIdea {
  final String ideaText;
  bool isDone;

  ImprovementIdea({required this.ideaText, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }
}
