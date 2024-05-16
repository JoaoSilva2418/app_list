import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChecklistScreen(),
    );
  }
}

class ChecklistScreen extends StatefulWidget {
  @override
  _ChecklistScreenState createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  List<String> toDoList = [];
  List<String> doingList = [];
  List<String> doneList = [];
  List<String> archivedList = [];

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App To Do List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Digite uma atividade |',
              ),
              onSubmitted: (value) {
                setState(() {
                  toDoList.add(value);
                  _textEditingController.clear();
                });
              },
            ),
            SizedBox(height: 18.0),
            Text(
              'A FAZER:',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0, 
                fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child: _buildList(toDoList),
            ),
            SizedBox(height: 18.0),
            Text(
              'EM ANDAMENTO:',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0, 
                fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child: _buildList(doingList),
            ),
            SizedBox(height: 18.0),
            Text(
              'FEITO:',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0, 
                fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              child: _buildList(doneList),
            ),
            SizedBox(height: 18.0),
            TextButton(
              onPressed: () {
                _showArchivedActivities();
              },
              child: Text('ARQUIVADAS'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<String> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index]),
          onTap: () {
            _moveActivity(index, items);
          },
        );
      },
    );
  }

  void _moveActivity(int index, List<String> sourceList) {
    setState(() {
      String activity = sourceList.removeAt(index);
      if (sourceList == toDoList) {
        doingList.add(activity);
      } else if (sourceList == doingList) {
        doneList.add(activity);
      } else if (sourceList == doneList) {
        // você pode remover completamente a atividade de 'doneList'
        // ou mova-o para archivedList, dependendo do comportamento do seu aplicativo.
      }
    });
  }

  void _showArchivedActivities() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Todas as atividades arquivadas'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (archivedList.isEmpty)
                  Text('Nenhuma atividade arquivada no momento.'),
                for (var activity in archivedList)
                  ListTile(
                    title: Text(activity),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Concluir'),
            ),
          ],
        );
      },
    );
  }
}