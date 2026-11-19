import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../challenge/screens/seek_player_screen.dart';
import '../../../shared/widgets/tactile_button.dart';
import '../../../shared/widgets/arena_widgets.dart';
import '../../../shared/widgets/jomnittaku_nav_bar.dart';
import '../../../core/theme/app_typography.dart';

class TableSelectionScreen extends StatefulWidget {
  final VoidCallback? onTableConfirmed;

  const TableSelectionScreen({super.key, this.onTableConfirmed});

  @override
  State<TableSelectionScreen> createState() => _TableSelectionScreenState();
}

class _TableSelectionScreenState extends State<TableSelectionScreen> {
  String _selectedTable = 'T1';

  /// Arena DS rule: a control is only offered in the state where it makes
  /// sense. One status map drives the spotlight, the CTAs and the grid.
  static const Map<String, String> _tableStatus = {
    'T1': 'free', 'T2': 'ingame', 'T3': 'free', 'T4': 'live', 'T5': 'free',
    'T6': 'free', 'T7': 'free', 'T8': 'ingame', 'T9': 'free', 'T10': 'reserved',
  };

  String get _selectedStatus => _tableStatus[_selectedTable] ?? 'free';
  bool get _selectedIsFree => _selectedStatus == 'free';

  String _statusLabel() {
    switch (_selectedStatus) {
      case 'live': return '• LIVE MATCH';
      case 'ingame': return '• IN GAME';
      case 'reserved': return '• RESERVED';
      default: return '• FREE NOW';
    }
  }

  Color _statusColor() {
    switch (_selectedStatus) {
      case 'live':
      case 'ingame': return AppColors.electricCrimson;
      case 'reserved': return AppColors.tableReserved;
      default: return AppColors.voltLime;
    }
  }

  /// Phase 6 nit fix: the Players pill must agree with the table state —
  /// a free table has no players yet.
  String _playersLabel() {
    switch (_selectedStatus) {
      case 'live':
      case 'ingame':
        return 'Aiman + Jason';
      case 'reserved':
        return 'Booked · members';
      default:
        return 'Waiting for players';
    }
  }

  String _statusDetail() {
    switch (_selectedStatus) {
      case 'live': return '11 - 9 Game Pt';
      case 'ingame': return 'In progress';
      case 'reserved': return 'Opens 8 PM';
      default: return 'Ready to play';
    }
  }

  void _onPrimaryTableAction(BuildContext context) {
    if (_selectedIsFree) {
      final cb = widget.onTableConfirmed;
      if (cb != null) { cb(); } else { AppNavigator.toChallengeBoard(context); }
    } else {
      // Occupied tables offer spectating, never check-in.
      AppNavigator.toDisplay(context);
    }
  }
  int _filterIndex = 0; // 0 = All, 1 = Free, 2 = Live

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      builder: (context, isDark) {
        return Scaffold(
          backgroundColor: AppColors.canvasBg,
          body: Container(
            decoration: BoxDecoration(gradient: AppColors.canvasGradient),
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
                      style: AppTypography.ui(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.3,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.voltLime.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.voltLime.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '6 FREE',
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: AppColors.voltLime,
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
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: AppColors.cardShadow,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Venue map',
                                  style: AppTypography.ui(
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
                                style: AppTypography.ui(
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
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: AppColors.cardShadow,
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
                                      style: AppTypography.ui(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: _statusColor().withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(color: _statusColor().withValues(alpha: 0.5)),
                                      ),
                                      child: Text(
                                        _statusLabel(),
                                        style: AppTypography.ui(
                                          fontSize: 9,
                                          fontWeight: FontWeight.w900,
                                          color: _statusColor(),
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
                                        style: AppTypography.ui(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w800,
                                          color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            AnimatedSwitcher(
                              duration: AppMotion.fade,
                              child: Row(
                                key: ValueKey(_selectedTable),
                                children: [
                                Expanded(
                                  child: _buildSpotlightPill('Table', '$_selectedTable Court', AppColors.ittfTableSurface, isDark),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildSpotlightPill('Status', _statusDetail(), _statusColor(), isDark),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: _buildSpotlightPill('Players', _playersLabel(), isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface, isDark),
                                ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      const Icon(Icons.lightbulb_rounded, size: 16, color: AppColors.radiantGold),
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          'IoT Sensor: ACTIVE',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTypography.ui(
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
                                  onTap: () => _onPrimaryTableAction(context),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                    decoration: BoxDecoration(
                                      color: AppColors.voltLime,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      _selectedIsFree ? 'Check in →' : 'Spectate →',
                                      style: AppTypography.ui(
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
                              style: AppTypography.ui(
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
                            style: AppTypography.ui(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Table Cards Grid (T1 to T6)
                      Row(
                        children: [
                          Expanded(child: _buildGridTableCard('T1', isFree: true, isDark: isDark).arenaEntrance(0)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T2', isFree: false, timeLabel: 'IN GAME · 18m', isDark: isDark).arenaEntrance(1)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T3', isFree: true, isDark: isDark).arenaEntrance(2)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildGridTableCard('T4', isFree: false, timeLabel: 'MATCH · LIVE', isDark: isDark).arenaEntrance(3)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T5', isFree: true, isDark: isDark).arenaEntrance(4)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T6', isFree: true, isDark: isDark).arenaEntrance(5)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildGridTableCard('T7', isFree: true, isDark: isDark).arenaEntrance(6)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T8', isFree: false, timeLabel: 'IN GAME · 07m', isDark: isDark).arenaEntrance(7)),
                          const SizedBox(width: 8),
                          Expanded(child: _buildGridTableCard('T9', isFree: true, isDark: isDark).arenaEntrance(8)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildGridTableCard('T10', isFree: false, timeLabel: '• RESERVED', labelColor: AppColors.tableReserved, isDark: isDark).arenaEntrance(9)),
                          const SizedBox(width: 8),
                          const Expanded(child: SizedBox()),
                          const SizedBox(width: 8),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Dual Actions
                      TactileButton.volt(
                        text: _selectedIsFree ? 'Check in to $_selectedTable →' : 'Spectate $_selectedTable →',
                        onPressed: () => _onPrimaryTableAction(context),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => AppNavigator.pushScreen(context, const SeekPlayerScreen()),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.obsidianCard,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: AppColors.cardShadow,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.radar_rounded, size: 18, color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface),
                                const SizedBox(width: 8),
                                Text(
                                  'Seek for player nearby',
                                  style: AppTypography.ui(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface,
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
                        style: AppTypography.ui(
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
      },
    );
  }

  Widget _buildGridTableCard(String name, {required bool isFree, String? timeLabel, Color? labelColor, required bool isDark}) {
    final isSelected = _selectedTable == name;
    final courtColor = isFree ? AppColors.ittfTableBlue : (isDark ? AppColors.paddleBlack : AppColors.slate500);
    final borderColor = isSelected
        ? (isDark ? AppColors.ittfTableBorder : AppColors.ittfTableSurface)
        : (isFree ? AppColors.voltLime.withValues(alpha: 0.4) : AppColors.border);

    return GestureDetector(
      onTap: () => setState(() => _selectedTable = name),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.ittfTableBlue.withValues(alpha: 0.3) : AppColors.lightBorder)
              : AppColors.obsidianCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2.0 : 1.0,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.ittfTableBorder.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            else
              ...AppColors.cardShadow,
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
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? AppColors.ittfTableBorder : Colors.white.withValues(alpha: 0.4),
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
                          color: AppColors.electricCrimson,
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
              style: AppTypography.ui(
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
              style: AppTypography.ui(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                color: labelColor ?? (isFree ? AppColors.voltLime : AppColors.electricCrimson),
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
        color: isDark ? AppColors.darkObsidianElevated : AppColors.lightCardSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTypography.ui(
              fontSize: 9,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.ui(
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
          color: isSelected ? AppColors.voltLime : (isDark ? AppColors.darkObsidianElevated : AppColors.lightCanvasBg),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.voltLime : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTypography.ui(
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
              ? [AppColors.paddleBlack, AppColors.slate900]
              : [AppColors.ittfTableBlue, AppColors.darkObsidianCardLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: hasPlayer ? AppColors.electricCrimson.withValues(alpha: 0.6) : AppColors.ittfTableBorder.withValues(alpha: 0.6),
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
                decoration: const BoxDecoration(color: AppColors.electricCrimson, shape: BoxShape.circle),
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
              style: AppTypography.ui(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
