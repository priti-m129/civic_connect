class Poll {
  final String id;
  final String question;
  final List<String> options;
  final List<int> votes;

  Poll({
    required this.id,
    required this.question,
    required this.options,
    required this.votes,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      votes: List<int>.from(json['votes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'votes': votes,
    };
  }
}
