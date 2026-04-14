import 'comment.dart';

class TaskData
{
  int id;
  int? parentID;

  String title;
  String description;
  String status;

  int priority;
  int size;

  int subtasksDone;
  int subtasksTotal;

  List<CommentData> comments;
  List<String> tags;

  DateTime? startDateTime;
  DateTime? endDateTime;

  TaskData(this.id, this.parentID, this.title, this.description, this.status, this.priority, this.size, this.subtasksDone, this.subtasksTotal, this.comments, this.tags, this.startDateTime, this.endDateTime);
}
