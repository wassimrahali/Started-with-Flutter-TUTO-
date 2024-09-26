class Task {
  String title;
  bool status;
  String description;
  DateTime deadline;

  Task(this.title, this.status, this.description, this.deadline);

  // Convert Task object to a map for JSON encoding
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'status': status,
      'description': description,
      'deadline': deadline.toIso8601String(),
    };
  }

  // Create a Task object from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['title'],
      json['status'],
      json['description'],
      DateTime.parse(json['deadline']),
    );
  }
}
