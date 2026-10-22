import 'package:flutter/material.dart';

class Note {
  final String title;
  final String content;
  final String category;
  final Color color;
  final String priority;
  final String date;
  final IconData icon;

  const Note({
    required this.title,
    required this.content,
    required this.category,
    required this.color,
    required this.priority,
    required this.date,
    required this.icon,
  });
}
