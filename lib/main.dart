import 'package:flutter/material.dart';
import 'add_page.dart';
import 'detail_page.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tasks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F7F4),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9BBD9F),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F7F4),
          foregroundColor: Color(0xFF313631),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _todos = [
    {
      'title': 'Create Tutorial Videos',
      'description': 'Prepare and record the tutorial videos.',
      'date': DateTime.now(),
      'done': false,
    },
    {
      'title': 'Web Preview + UX/UI',
      'description': 'Review the website layout and user interface.',
      'date': DateTime.now(),
      'done': false,
    },
    {
      'title': 'Planning Roadmap',
      'description': 'Plan the next project milestones.',
      'date': DateTime.now(),
      'done': false,
    },
    {
      'title': 'Airtable Todo List',
      'description': 'Organize tasks in Airtable.',
      'date': DateTime.now(),
      'done': true,
    },
  ];

  Future<void> _addTodo() async {
    final newTodo = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(builder: (context) => const AddPage()),
    );

    if (!mounted) return;
    if (newTodo != null) {
      setState(() {
        _todos.add(newTodo);
      });
    }
  }

  Future<void> _openDetail(int index) async {
    final markedDone = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(todo: _todos[index]),
      ),
    );

    if (!mounted) return;
    if (markedDone == true) {
      setState(() {
        _todos[index]['done'] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final doneCount = _todos.where((todo) => todo['done'] == true).length;
    final progress = _todos.isEmpty ? 0.0 : doneCount / _todos.length;
    final remainingCount = _todos.length - doneCount;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(26),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'My Tasks',
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 32,
                          color: Color(0xFF313631),
                        ),
                      ),
                      Icon(Icons.access_time, size: 34),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 16,
                      color: const Color(0xFF9BBD9F),
                      backgroundColor: const Color(0xFFE3ECE2),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '$remainingCount tasks remaining · ${(progress * 100).round()}% completed',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF777D75),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(18),
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  final isDone = todo['done'] as bool;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      title: Text(
                        todo['title'] as String,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          todo['description'] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF969B94),
                          ),
                        ),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: isDone
                              ? const Color(0xFFE7E7E5)
                              : const Color(0xFFB6D2B7),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isDone ? 'Done' : 'To do',
                          style: const TextStyle(fontSize: 11),
                        ),
                      ),
                      onTap: () => _openDetail(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          height: 68,
          color: Colors.white,
          child: Center(
            child: Material(
              color: const Color(0xFF9BBD9F),
              borderRadius: BorderRadius.circular(30),
              child: IconButton(
                onPressed: _addTodo,
                icon: const Icon(Icons.add),
                color: Colors.white,
                tooltip: 'Add task',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
