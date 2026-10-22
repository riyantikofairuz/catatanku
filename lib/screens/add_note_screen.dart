import 'package:flutter/material.dart';

import '../data/dummy_notes.dart';
import '../models/note.dart';
import '../theme/app_theme.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String _selectedCategory = 'Penting';
  int _selectedColorIndex = 0;
  String _selectedPriority = 'Sedang';

  final List<Color> _colors = const [
    AppTheme.noteYellow,
    AppTheme.noteMint,
    AppTheme.notePurple,
    AppTheme.notePink,
    AppTheme.noteBlue,
  ];

  final List<String> _categories = ['Penting', 'Pribadi', 'Kerja'];
  final List<String> _priorities = ['Rendah', 'Sedang', 'Tinggi'];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan judul catatan terlebih dahulu'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Determine icon based on category
    IconData icon;
    switch (_selectedCategory) {
      case 'Kerja':
        icon = Icons.calendar_month_rounded;
        break;
      case 'Pribadi':
        icon = Icons.favorite_rounded;
        break;
      default:
        icon = Icons.lightbulb_rounded;
    }

    final now = DateTime.now();
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final dateStr =
        '${now.day} ${months[now.month]} ${now.year} · ${now.hour.toString().padLeft(2, '0')}.${now.minute.toString().padLeft(2, '0')}';

    final newNote = Note(
      title: title,
      content: content.isEmpty ? 'Tidak ada detail catatan.' : content,
      category: _selectedCategory,
      color: _colors[_selectedColorIndex],
      priority: _selectedPriority,
      date: dateStr,
      icon: icon,
    );

    dummyNotes.insert(0, newNote);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Catatan baru berhasil disimpan! ✨'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Tambah Catatan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: TextButton.icon(
              onPressed: _saveNote,
              icon: const Icon(Icons.check_rounded, size: 18),
              label: const Text(
                'Simpan',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primary,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview card header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _colors[_selectedColorIndex],
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.06),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.palette_outlined,
                      color: AppTheme.primary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Warna Catatan Terpilih',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Warna ini akan menjadi tampilan latar kartu catatanmu.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Form Section Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Field
                  const Text(
                    'Judul Catatan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textMedium,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Misal: Ide Project Flutter, Daftar Belanja...',
                      prefixIcon: Icon(Icons.title_rounded, size: 20),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Content Field
                  const Text(
                    'Isi Catatan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textMedium,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _contentController,
                    maxLines: 6,
                    decoration: const InputDecoration(
                      hintText: 'Tuliskan detail atau deskripsi catatan Anda di sini...',
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // Options Card (Category, Priority, Colors)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppTheme.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Dropdown
                  const Text(
                    'Kategori',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textMedium,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedCategory,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.folder_outlined, size: 20),
                    ),
                    items: _categories.map((c) {
                      return DropdownMenuItem(
                        value: c,
                        child: Text(
                          c,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedCategory = val);
                      }
                    },
                  ),
                  const SizedBox(height: 20),

                  // Color Picker
                  const Text(
                    'Pilihan Warna Kartu',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_colors.length, (i) {
                      final isSelected = _selectedColorIndex == i;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedColorIndex = i);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: _colors[i],
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.primary
                                  : Colors.black12,
                              width: isSelected ? 2.5 : 1,
                            ),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: AppTheme.primary
                                          .withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : [],
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check_rounded,
                                  color: AppTheme.primary,
                                  size: 24,
                                )
                              : null,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 22),

                  // Priority Selector
                  const Text(
                    'Tingkat Prioritas',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textMedium,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: _priorities.map((p) {
                      final isActive = _selectedPriority == p;
                      Color activeColor;
                      Color activeBg;
                      if (p == 'Tinggi') {
                        activeColor = AppTheme.priorityHighText;
                        activeBg = AppTheme.priorityHighBg;
                      } else if (p == 'Sedang') {
                        activeColor = AppTheme.priorityMediumText;
                        activeBg = AppTheme.priorityMediumBg;
                      } else {
                        activeColor = AppTheme.priorityLowText;
                        activeBg = AppTheme.priorityLowBg;
                      }

                      return Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedPriority = p);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isActive ? activeBg : AppTheme.background,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isActive
                                    ? activeColor.withValues(alpha: 0.5)
                                    : AppTheme.border,
                                width: isActive ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.flag_rounded,
                                  size: 15,
                                  color:
                                      isActive ? activeColor : AppTheme.textGrey,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  p,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isActive
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isActive
                                        ? activeColor
                                        : AppTheme.textMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bottom Save Button
            ElevatedButton(
              onPressed: _saveNote,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_rounded, size: 20),
                  SizedBox(width: 8),
                  Text('Simpan Catatan'),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
