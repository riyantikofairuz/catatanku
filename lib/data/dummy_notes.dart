import 'package:flutter/material.dart';

import '../models/note.dart';

const List<Note> dummyNotes = [
  Note(
    title: 'Ide Aplikasi',
    content: 'Membuat aplikasi catatan sederhana untuk menyimpan ide dan kegiatan sehari-hari. Catatan dapat dikelompokkan berdasarkan kategori, diberi warna agar mudah dikenali, serta memiliki tingkat prioritas supaya tugas yang paling penting dapat dikerjakan terlebih dahulu.',
    category: 'Penting',
    color: Color(0xFFFFF4D6),
    priority: 'Tinggi',
    date: '19 Oktober 2026 ·  09.30',
    icon: Icons.lightbulb,
  ),

  Note(
    title: 'Rencana Mingguan',
    content: 'Menyiapkan agenda untuk minggu depan, mulai dari menyelesaikan laporan, mengikuti rapat tim, hingga meluangkan waktu untuk mengevaluasi pekerjaan yang sudah selesai. Setiap kegiatan perlu diberi target waktu agar jadwal lebih teratur dan tidak ada tugas yang terlewat.',
    category: 'Kerja',
    color: Color(0xFFDDF6EE),
    priority: 'Sedang',
    date: '18 Oktober 2026  ·  14.00',
    icon: Icons.calendar_month,
  ),

  Note(
    title: 'Catatan Kuliah',
    content: 'Merangkum materi kuliah hari ini, terutama pembahasan konsep dasar, contoh penerapan, dan istilah penting yang dijelaskan oleh dosen. Materi ini perlu dipelajari kembali sebelum mengerjakan tugas dan digunakan sebagai bahan persiapan ujian.',
    category: 'Pribadi',
    color: Color(0xFFE6E4FA),
    priority: 'Sedang',
    date: '17 Oktober 2026  ·  11.15',
    icon: Icons.menu_book,
  ),

  Note(
    title: 'Hal yang Perlu Dibeli',
    content: 'Membuat daftar kebutuhan yang harus dibeli, seperti alat tulis, perlengkapan rumah, dan kebutuhan harian lainnya. Prioritaskan barang yang sudah habis atau paling mendesak, lalu periksa kembali daftar sebelum berbelanja agar tidak ada kebutuhan penting yang tertinggal.',
    category: 'Pribadi',
    color: Color(0xFFFFE3E8),
    priority: 'Tinggi',
    date: '16 Oktober 2026  ·  10.00',
    icon: Icons.shopping_cart,
  ),

  Note(
    title: 'Jurnal Harian',
    content: 'Mencatat aktivitas yang dilakukan sepanjang hari, hal-hal yang berjalan dengan baik, serta pencapaian kecil yang berhasil diraih. Tuliskan juga kendala dan rencana perbaikan agar kegiatan esok hari dapat dilakukan dengan lebih terarah.',
    category: 'Pribadi',
    color: Color(0xFFE0EEFF),
    priority: 'Rendah',
    date: '15 Oktober 2026  ·  08.00',
    icon: Icons.favorite,
  ),
];
