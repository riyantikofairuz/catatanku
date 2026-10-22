import 'package:flutter/material.dart';

import '../models/note.dart';

const List<Note> dummyNotes = [
  Note(
    title: 'Ide Aplikasi',
    content: 'Ide untuk membuat aplikasi catatan sederhana dengan fitur kategori, warna, dan prioritas.',
    category: 'Penting',
    color: Color(0xFFFFF4D6),
    priority: 'Tinggi',
    date: '19 Oktober 2026',
    icon: Icons.lightbulb,
  ),

  Note(
    title: 'Rencana Mingguan',
    content: 'Rencana untuk minggu depan.',
    category: 'Kerja',
    color: Color(0xFFDDF6EE),
    priority: 'Sedang',
    date: '18 Oktober 2026',
    icon: Icons.calendar_month,
  ),

  Note(
    title: 'Catatan Kuliah',
    content: 'Catatan dari kuliah hari ini.',
    category: 'Pribadi',
    color: Color(0xFFE6E4FA),
    priority: 'Sedang',
    date: '17 Oktober 2026',
    icon: Icons.menu_book,
  ),

  Note(
    title: 'Hal yang Perlu Dibeli',
    content: 'Daftar hal yang perlu dibeli.',
    category: 'Pribadi',
    color: Color(0xFFFFE3E8),
    priority: 'Tinggi',
    date: '16 Oktober 2026',
    icon: Icons.shopping_cart,
  ),

  Note(
    title: 'Jurnal Harian',
    content: 'Catatan harian tentang aktivitas dan pencapaian.',
    category: 'Pribadi',
    color: Color(0xFFE0EEFF),
    priority: 'Rendah',
    date: '15 Oktober 2026',
    icon: Icons.favorite,
  ),
];
