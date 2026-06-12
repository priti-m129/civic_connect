import 'package:flutter/material.dart';
import 'poll.dart';

class PollWidget extends StatefulWidget {
  final Poll poll;
  final void Function(int selectedOption) onVote;

  PollWidget({required this.poll, required this.onVote});

  @override
  _PollWidgetState createState() => _PollWidgetState();
}

class _PollWidgetState extends State<PollWidget> {
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.poll.question, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...List.generate(widget.poll.options.length, (index) {
          return RadioListTile<int>(
            title: Text(widget.poll.options[index]),
            value: index,
            groupValue: _selectedOption,
            onChanged: (value) {
              setState(() {
                _selectedOption = value;
              });
            },
          );
        }),
        ElevatedButton(
          onPressed: _selectedOption == null
              ? null
              : () {
            widget.onVote(_selectedOption!);
          },
          child: Text('Vote'),
        ),
      ],
    );
  }
}
