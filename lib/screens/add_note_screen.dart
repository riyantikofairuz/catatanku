import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String? _selectedCategory;
  int _selectedColor = 0;
  String _selectedPriority = 'Sedang';

  final List<Color> _colors = const [
    Color(0xFF4DA3FF), // biru
    Color(0xFF8EDFC8), // mint
    Color(0xFFFFD966), // kuning
    Color(0xFFFF8FB8), // pink
    Color(0xFFB49CFF), // ungu
  ];

  final List<String> _priorities = ['Rendah', 'Sedang', 'Tinggi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Judul Catatan',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(hintText: 'Masukkan judul catatan'),
            ),
            const SizedBox(height: 16),

            const Text(
              'Isi Catatan',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Tulis catatan Anda di sini...',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kategori',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              hint: const Text('Pilih kategori'),
              items: const [
                'Penting',
                'Pribadi',
                'Kerja',
              ].map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (value) {
                setState(() => _selectedCategory = value);
              },
            ),
            const SizedBox(height: 16),
            const Text('Warna', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              children: List.generate(_colors.length, (i) {
                return GestureDetector(
                  onTap: () {
                    setState(() => _selectedColor = i);
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: _colors[i],
                      shape: BoxShape.circle,
                    ),
                    child: _selectedColor == i
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            const Text(
              'Prioritas',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              children: _priorities.map((p) {
                final isActive = _selectedPriority == p;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedPriority = p);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isActive ? AppTheme.primary : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        p,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isActive ? Colors.white : AppTheme.textGrey,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
