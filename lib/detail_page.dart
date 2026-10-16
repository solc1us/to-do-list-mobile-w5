import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> todo;

  const DetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final isDone = todo['done'] as bool;
    final description = todo['description'] as String;
    final date = todo['date'] as DateTime;
    final dateText = MaterialLocalizations.of(context).formatMediumDate(date);

    return Scaffold(
      appBar: AppBar(title: const Text('Task Details')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            Text(
              todo['title'] as String,
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 30,
                color: Color(0xFF313631),
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, size: 18),
                const SizedBox(width: 10),
                Text(dateText),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  isDone ? Icons.check_circle_outline : Icons.schedule,
                  size: 18,
                ),
                const SizedBox(width: 10),
                Text(isDone ? 'Done' : 'To do'),
              ],
            ),
            const Divider(height: 44),
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description.isEmpty ? 'No description.' : description,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF777D75),
                height: 1.6,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: isDone
                    ? null
                    : () => Navigator.pop(context, true),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFFAFB8AD)),
                ),
                child: Text(isDone ? 'Completed' : 'Mark as Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
