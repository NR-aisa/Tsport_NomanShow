import 'package:flutter/material.dart';

import '../../core/theme/app_typography.dart';

/// Elite Luxury Sidebar Navigation for JOMNITTAKU Desktop Web.
///
/// Directly inspired by the reference luxury fintech/gaming dashboard:
/// - Brand logo at top with coral rose accent
/// - Navigation items with 18px icons, clean 13px labels, and active pill highlights
/// - Bottom venue callout card with coral rose CTA button
class DesktopDockRail extends StatelessWidget {
  final String activeItem;
  final ValueChanged<String> onItemTap;
  final VoidCallback? onWalkInTap;

  const DesktopDockRail({
    super.key,
    required this.activeItem,
    required this.onItemTap,
    this.onWalkInTap,
  });

  static const Color luxurySidebarBg = Color(0xFF1A1C26);
  static const Color luxuryActivePill = Color(0xFF2E3244);
  static const Color luxuryCoralRose = Color(0xFFFF4B72);
  static const Color luxuryMutedText = Color(0xFF8A8E9E);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        color: luxurySidebarBg,
        border: Border(
          right: BorderSide(
            color: Color(0x0FFFFFFF),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // BRAND LOGO (TOP)
          // ==========================================
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: luxuryCoralRose.withValues(alpha: 0.15),
                  border: Border.all(
                    color: luxuryCoralRose.withValues(alpha: 0.4),
                    width: 1.5,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/company_logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'JOMNITTAKU',
                    style: AppTypography.ui(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'NO MAN SHOW',
                    style: AppTypography.ui(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: luxuryCoralRose,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ==========================================
          // NAVIGATION MENU LIST
          // ==========================================
          _buildNavItem(
            id: 'command',
            icon: Icons.home_rounded,
            label: 'Home',
          ),
          const SizedBox(height: 4),
          _buildNavItem(
            id: 'radar',
            icon: Icons.table_restaurant_rounded,
            label: '10 Courts Radar',
            badge: '6',
            badgeColor: const Color(0xFF10B981),
          ),
          const SizedBox(height: 4),
          _buildNavItem(
            id: 'league',
            icon: Icons.emoji_events_rounded,
            label: 'Olympic League',
            badge: '#4',
            badgeColor: const Color(0xFFFFA533),
          ),
          const SizedBox(height: 4),
          _buildNavItem(
            id: 'passes',
            icon: Icons.credit_card_rounded,
            label: 'Arena Passes',
          ),
          const SizedBox(height: 4),
          _buildNavItem(
            id: 'iot',
            icon: Icons.sensors_rounded,
            label: 'Smart Arena Hub',
          ),
          const SizedBox(height: 4),
          _buildNavItem(
            id: 'tv',
            icon: Icons.tv_rounded,
            label: '55" TV Feed',
          ),

          const Spacer(),

          // ==========================================
          // BOTTOM VENUE PASS CALLOUT CARD
          // ==========================================
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF222533),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.06),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '3 Damansara',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: luxuryCoralRose.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '24/7',
                        style: AppTypography.ui(
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                          color: luxuryCoralRose,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Level 2 Autonomous Arena',
                  style: AppTypography.ui(
                    fontSize: 9.5,
                    color: luxuryMutedText,
                  ),
                ),
                const SizedBox(height: 12),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: onWalkInTap,
                    child: Container(
                      width: double.infinity,
                      height: 34,
                      decoration: BoxDecoration(
                        color: luxuryCoralRose,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: luxuryCoralRose.withValues(alpha: 0.35),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Walk In (RM17)',
                            style: AppTypography.ui(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            size: 13,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required String id,
    required IconData icon,
    required String label,
    String? badge,
    Color? badgeColor,
  }) {
    final isActive = activeItem == id;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onItemTap(id),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isActive ? luxuryActivePill : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isActive ? Colors.white : luxuryMutedText,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.ui(
                    fontSize: 12.5,
                    fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                    color: isActive ? Colors.white : luxuryMutedText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: (badgeColor ?? luxuryCoralRose).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge,
                    style: AppTypography.ui(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w900,
                      color: badgeColor ?? luxuryCoralRose,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
