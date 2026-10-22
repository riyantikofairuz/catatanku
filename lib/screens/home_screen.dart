import 'package:flutter/material.dart';

import '../data/dummy_notes.dart';
import '../models/note.dart';
import '../theme/app_theme.dart';
import '../widgets/note_card.dart';
import 'add_note_screen.dart';
import 'detail_note_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _categories = ['Semua', 'Penting', 'Pribadi', 'Kerja'];
  String _selectedCategory = 'Semua';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _currentNavIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Note> get _filteredNotes {
    return dummyNotes.where((note) {
      final matchesCategory =
          _selectedCategory == 'Semua' || note.category == _selectedCategory;
      final matchesQuery = _searchQuery.isEmpty ||
          note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          note.content.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  int _getCategoryCount(String category) {
    if (category == 'Semua') return dummyNotes.length;
    return dummyNotes.where((n) => n.category == category).length;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredNotes;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Section (Header + Search + Categories)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Halo, Fairuz',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.textDark,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              SizedBox(width: 6),
                              Text('👋', style: TextStyle(fontSize: 20)),
                            ],
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Apa yang ingin kamu catat hari ini?',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textGrey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      // User Avatar with Badge
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: AppTheme.border, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.person_rounded,
                            color: AppTheme.primary,
                            size: 26,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),

                  // Search Field with clear action
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        setState(() {
                          _searchQuery = val.trim();
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari catatan, ide, tugas...',
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          size: 22,
                          color: AppTheme.textGrey,
                        ),
                        suffixIcon: _searchQuery.isNotEmpty
                            ? IconButton(
                                icon: const Icon(
                                  Icons.cancel_rounded,
                                  size: 18,
                                  color: AppTheme.textGrey,
                                ),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppTheme.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Category Selector Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: _categories.map((category) {
                        final isSelected = _selectedCategory == category;
                        final count = _getCategoryCount(category);

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppTheme.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppTheme.primary
                                        : AppTheme.border,
                                    width: 1,
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
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      category,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? Colors.white
                                            : AppTheme.textDark,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? Colors.white
                                                .withValues(alpha: 0.25)
                                            : AppTheme.background,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        '$count',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: isSelected
                                              ? Colors.white
                                              : AppTheme.textGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Note List or Empty State
            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: const BoxDecoration(
                                color: AppTheme.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.search_off_rounded,
                                size: 48,
                                color: AppTheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Tidak ada catatan',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textDark,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Coba cari dengan kata kunci lain atau pilih kategori yang berbeda.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.textGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final note = filtered[index];
                        return NoteCard(
                          note: note,
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetailNoteScreen(note: note),
                              ),
                            );
                            setState(() {});
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNoteScreen()),
          );
          setState(() {});
        },
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        icon: const Icon(Icons.add_rounded, size: 22),
        label: const Text(
          'Catatan Baru',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppTheme.border, width: 1),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentNavIndex,
          onTap: (index) {
            setState(() {
              _currentNavIndex = index;
            });
            if (index > 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    index == 1
                        ? 'Fitur Arsip Catatan akan segera hadir!'
                        : 'Fitur Pengaturan Profil akan segera hadir!',
                  ),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          elevation: 0,
          backgroundColor: Colors.white,
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: AppTheme.textGrey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              activeIcon: Icon(Icons.archive_rounded),
              label: 'Arsip',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
