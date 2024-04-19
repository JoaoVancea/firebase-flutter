class StudyModel{
  String topic;
  bool isDone;

  StudyModel({
    required this.topic,
    required this.isDone
  });

  @override
  String toString() {
    // TODO: implement toString
    return (topic);
  }
}