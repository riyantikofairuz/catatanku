import 'package:flutter/material.dart';

import '../models/note.dart';
import '../theme/app_theme.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Priority badge styling
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.black.withValues(alpha: 0.04),
          highlightColor: Colors.black.withValues(alpha: 0.02),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: note.color,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.05),
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
                // Top Header: Icon, Title, and Priority Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Squircle Icon Badge
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
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
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Title
                    Expanded(
                      child: Text(
                        note.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textDark,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Priority Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: priorityBg,
                        borderRadius: BorderRadius.circular(8),
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
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: priorityColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Content snippet
                Text(
                  note.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: AppTheme.textDark.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 14),

                // Bottom Meta: Category tag and Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.label_outline_rounded,
                            size: 13,
                            color: AppTheme.textMedium.withValues(alpha: 0.8),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            note.category,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textMedium,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Timestamp
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          size: 13,
                          color: AppTheme.textGrey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          note.date,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
