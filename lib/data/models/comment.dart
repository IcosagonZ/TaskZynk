class CommentData
{
  int id;
  int? parentID;

  String comment;

  DateTime dateTime;

  CommentData(this.id, this.parentID, this.comment, this.dateTime);
}
