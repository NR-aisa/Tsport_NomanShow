import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../challenge/screens/seek_player_screen.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';

class TableSelectionScreen extends StatefulWidget {
  final VoidCallback? onTableConfirmed;

  const TableSelectionScreen({super.key, this.onTableConfirmed});

  @override
  State<TableSelectionScreen> createState() => _TableSelectionScreenState();
}

class _TableSelectionScreenState extends State<TableSelectionScreen> {
  String _selectedTable = 'T4';
  int _filterIndex = 0; // 0 = All, 1 = Free, 2 = Live

  @override
  Widget build(BuildContext context) {
    final isDark = AppThemeController.isDark;

    return Scaffold(
      backgroundColor: AppColors.obsidianBase,
      body: Container(
        color: AppColors.obsidianBase,
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // ==========================================
              // TOP BAR (Back, Title, Free Counter)
              // ==========================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.obsidianCard,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.border,
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark ? Colors.black.withValues(alpha: 0.3) : Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Text(
                      'Tables',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF10B981).withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '6 FREE',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF10B981),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ==========================================
              // SCROLLABLE CONTENT
              // ==========================================
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    children: [
                      // Venue Map Filter Card (Athletic Glass)
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.obsidianCard,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: AppColors.border,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isDark ? Colors.black.withValues(alpha: 0.35) : Colors.black.withValues(alpha: 0.06),
                              blurRadius: 14,
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
                                Text(
                                  'Venue map',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Row(
                                  children: [
                                    _buildMapFilter('All', _filterIndex == 0, () => setState(() => _filterIndex = 0), isDark),
                                    const SizedBox(width: 6),
                                    _buildMapFilter('Free', _filterIndex == 1, () => setState(() => _filterIndex = 1), isDark),
                                    const SizedBox(width: 6),
                                    _buildMapFilter('Live', _filterIndex == 2, () => setState(() => _filterIndex = 2), isDark),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildMiniIttfTable(tableName: 'T1', hasPlayer: true),
                                _buildMiniIttfTable(tableName: 'T2', hasPlayer: true),
                                _buildMiniIttfTable(tableName: 'T3', hasPlayer: false),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: Text(
                                '3 Damansara · 6 free of 10 tables',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Active Table T4 Spotlight Card (Athletic Glass)
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.obsidianCard,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isDark ? const Color(0xFF38BDF8).withValues(alpha: 0.35) : const Color(0xFF0284C7).withValues(alpha: 0.3),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2563EB).withValues(alpha: isDark ? 0.20 : 0.08),
                              blurRadius: 18,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      _selectedTable,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF10B981).withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.5)),
                                      ),
                                      child: Text(
                                        '• LIVE MATCH',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w900,
                                          color: const Color(0xFF10B981),
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () => AppNavigator.toDisplay(context),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Scoreboard →',
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildSpotlightPill('Table', '$_selectedTable Court', const Color(0xFF2563EB), isDark),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildSpotlightPill('Status', '11 - 9 Game Pt', const Color(0xFF10B981), isDark),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildSpotlightPill('Players', 'Aiman + Jason', isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7), isDark),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(Icons.lightbulb_rounded, size: 16, color: Color(0xFFF59E0B)),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          'IoT Sensor: ACTIVE',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.plusJakartaSans(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w800,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: widget.onTableConfirmed ?? () => AppNavigator.toChallengeBoard(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF10B981),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Text(
                                      'Check in →',
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Section Title: Table Matrix
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'SELECT AN ARENA TABLE',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
                                color: AppColors.textSecondary,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Tap to switch',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Table Cards Grid (T1 to T6)
                      Row(
                        children: [
                          Expanded(child: _buildGridTableCard('T1', isFree: true, isDark: isDark)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T2', isFree: false, timeLabel: 'IN GAME · 18m', isDark: isDark)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T3', isFree: true, isDark: isDark)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildGridTableCard('T4', isFree: false, timeLabel: 'MATCH · LIVE', isDark: isDark)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T5', isFree: true, isDark: isDark)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T6', isFree: true, isDark: isDark)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Dual Actions
                      TactileButton.volt(
                        text: 'Check in to $_selectedTable →',
                        onPressed: widget.onTableConfirmed ?? () => AppNavigator.toChallengeBoard(context),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => AppNavigator.pushScreen(context, const SeekPlayerScreen()),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.obsidianCard,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: isDark ? const Color(0xFF38BDF8).withValues(alpha: 0.4) : const Color(0xFF0284C7).withValues(alpha: 0.3),
                              width: 1.2,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.radar_rounded, size: 18, color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7)),
                                const SizedBox(width: 8),
                                Text(
                                  'Seek for player nearby',
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No opponent? Free players nearby get a ping. Friendly game = no XP.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),

              // Bottom Dock (Table tab active)
              const JomnittakuNavBar(activeIndex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridTableCard(String name, {required bool isFree, String? timeLabel, required bool isDark}) {
    final isSelected = _selectedTable == name;
    final courtColor = isFree ? const Color(0xFF1D4ED8) : (isDark ? const Color(0xFF1E293B) : const Color(0xFF64748B));
    final borderColor = isSelected
        ? (isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7))
        : (isFree ? const Color(0xFF10B981).withValues(alpha: 0.4) : AppColors.border);

    return GestureDetector(
      onTap: () => setState(() => _selectedTable = name),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? const Color(0xFF1E3A8A).withValues(alpha: 0.3) : const Color(0xFFE0F2FE))
              : AppColors.obsidianCard,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFF38BDF8).withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            else
              BoxShadow(
                color: isDark ? Colors.black.withValues(alpha: 0.25) : Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          children: [
            // Mini ITTF Table Visual
            Container(
              width: 48,
              height: 28,
              decoration: BoxDecoration(
                color: courtColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: isSelected ? const Color(0xFF60A5FA) : Colors.white.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 1, color: Colors.white.withValues(alpha: 0.6)),
                  if (!isFree)
                    Positioned(
                      left: 8,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  if (!isFree)
                    Positioned(
                      right: 8,
                      child: Container(
                        width: 5,
                        height: 5,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              isFree ? '• FREE' : (timeLabel ?? 'IN GAME'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: isFree ? const Color(0xFF10B981) : const Color(0xFFEF4444),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSpotlightPill(String label, String value, Color accentColor, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F1A2E) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 9,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w900,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapFilter(String label, bool isSelected, VoidCallback onTap, bool isDark) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF10B981) : (isDark ? const Color(0xFF0F1A2E) : const Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFF10B981) : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 9,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  static Widget _buildMiniIttfTable({required String tableName, required bool hasPlayer}) {
    return Container(
      width: 68,
      height: 40,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: hasPlayer
              ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
              : [const Color(0xFF1D4ED8), const Color(0xFF172554)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasPlayer ? const Color(0xFFEF4444).withValues(alpha: 0.6) : const Color(0xFF60A5FA).withValues(alpha: 0.6),
          width: 1.2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 1.2, color: Colors.white.withValues(alpha: 0.6)),
          if (hasPlayer)
            Positioned(
              left: 10,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle),
              ),
            ),
          if (hasPlayer)
            Positioned(
              right: 10,
              child: Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
            ),
          Positioned(
            top: 2,
            child: Text(
              tableName,
              style: GoogleFonts.plusJakartaSans(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
