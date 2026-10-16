import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (!mounted) return;
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _saveTodo() {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title.')),
      );
      return;
    }

    Navigator.pop(context, <String, dynamic>{
      'title': title,
      'description': _descriptionController.text.trim(),
      'date': _selectedDate,
      'done': false,
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateText = MaterialLocalizations.of(context)
        .formatMediumDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const Text(
              'New Task',
              style: TextStyle(
                fontFamily: 'serif',
                fontSize: 30,
                color: Color(0xFF313631),
              ),
            ),
            const SizedBox(height: 26),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Task title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Description (optional)',
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 18),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_today_outlined),
              label: Text(dateText),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTodo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9BBD9F),
                  foregroundColor: const Color(0xFF263429),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
