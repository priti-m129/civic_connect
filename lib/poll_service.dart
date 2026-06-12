import 'poll.dart';

class PollService {
  final List<Poll> _polls = [];

  // Add a new poll
  void addPoll(Poll poll) {
    _polls.add(poll);
  }

  // Get all polls
  List<Poll> getPolls() {
    return _polls;
  }

  // Vote on poll option
  void vote(String pollId, int optionIndex) {
    Poll? poll = _polls.firstWhere((p) => p.id == pollId, orElse: () => throw Exception('Poll not found'));
    poll.votes[optionIndex] += 1;
  }
}
