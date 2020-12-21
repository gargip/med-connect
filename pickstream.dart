import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Stream extends StatefulWidget {
  @override
  _StreamState createState() => _StreamState();
}

class _StreamState extends State<Stream> {
  final _saved = <String>{};
  List<String> states = [
    "Pediatrics",
    "Family Med",
    "OBGYN",
    "Emergency",
    "Surgery",
    "Dentistry",
    "Cardiology",
    "Psychiatry",
    "Neurology",
    "Physicians",
    "Surgeons",
    "Nurses",
    "Therapists",
    "Nutritionists",
    "COVID-19",
    "Research",
    "Diet",
    "Health Tech",
    "Fitness",
    "New Jobs",
    "Medical News",
    "Mental Health"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF01579B),
        title: Text('Pick Your Stream'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() => ListView.separated(
        itemCount: 50,
        itemBuilder: (context, index) {
          return _buildListTile(states[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.black,
          );
        },
      );
  Widget _buildListTile(String state) {
    final alreadySaved = _saved.contains(state);
    return ListTile(
      title: Text(
        state,
        style: TextStyle(fontFamily: 'OpenSans'),
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(state);
          } else {
            _saved.add(state);
          }
        });
      },
      trailing: Icon(
        alreadySaved ? Icons.check_box : Icons.check_box_outline_blank,
        color: alreadySaved ? Colors.green : null,
      ),
    );
  }
}
