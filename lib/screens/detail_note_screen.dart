import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/dummy_notes.dart';
import '../models/note.dart';
import '../theme/app_theme.dart';

class DetailNoteScreen extends StatelessWidget {
  final Note note;

  const DetailNoteScreen({super.key, required this.note});

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogCtx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Hapus Catatan?',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: Text(
            'Apakah Anda yakin ingin menghapus catatan "${note.title}"? Tindakan ini tidak dapat dibatalkan.',
            style: const TextStyle(color: AppTheme.textMedium, fontSize: 14),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogCtx),
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: AppTheme.textGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                minimumSize: const Size(100, 42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                dummyNotes.removeWhere(
                  (n) => n.title == note.title && n.date == note.date,
                );
                Navigator.pop(dialogCtx); // close dialog
                Navigator.pop(context); // return to home
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Catatan telah berhasil dihapus.'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: '${note.title}\n\n${note.content}'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Isi catatan berhasil disalin ke clipboard! 📋'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wordCount = note.content
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .length;
    final charCount = note.content.length;

    // Priority color
    Color priorityColor;
    Color priorityBg;
    if (note.priority == 'Tinggi') {
      priorityColor = AppTheme.priorityHighText;
      priorityBg = AppTheme.priorityHighBg;
    } else if (note.priority == 'Sedang') {
      priorityColor = AppTheme.priorityMediumText;
      priorityBg = AppTheme.priorityMediumBg;
    } else {
      priorityColor = AppTheme.priorityLowText;
      priorityBg = AppTheme.priorityLowBg;
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            tooltip: 'Salin Isi',
            icon: const Icon(Icons.copy_rounded, size: 20),
            onPressed: () => _copyToClipboard(context),
          ),
          IconButton(
            tooltip: 'Hapus Catatan',
            icon: const Icon(Icons.delete_outline_rounded,
                color: Colors.redAccent, size: 22),
            onPressed: () => _showDeleteDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Hero Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: note.color,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.06),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon + Badges Row
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          note.icon,
                          color: AppTheme.primary,
                          size: 26,
                        ),
                      ),
                      const Spacer(),
                      // Category Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.folder_outlined,
                              size: 14,
                              color: AppTheme.textMedium,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              note.category,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Priority Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: priorityBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: priorityColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              note.priority,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: priorityColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Title
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textDark,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Date
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppTheme.textMedium,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        note.date,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Note Content Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Isi Catatan',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textMedium,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _copyToClipboard(context),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.copy_rounded,
                              size: 13,
                              color: AppTheme.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Salin',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24, color: AppTheme.border),
                  SelectableText(
                    note.content,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.7,
                      color: AppTheme.textDark,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Stats / Info Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Kata', '$wordCount'),
                  Container(
                    width: 1,
                    height: 24,
                    color: AppTheme.border,
                  ),
                  _buildStatItem('Karakter', '$charCount'),
                  Container(
                    width: 1,
                    height: 24,
                    color: AppTheme.border,
                  ),
                  _buildStatItem('Kategori', note.category),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.textGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
