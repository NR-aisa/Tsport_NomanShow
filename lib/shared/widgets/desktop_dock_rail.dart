import 'package:flutter/material.dart';

import '../../core/session/demo_avatars.dart';
import '../../core/theme/app_typography.dart';
import 'arena_widgets.dart';

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
  final bool isDark;

  const DesktopDockRail({
    super.key,
    required this.activeItem,
    required this.onItemTap,
    this.onWalkInTap,
    this.isDark = true,
  });

  static const Color luxuryCoralRose = Color(0xFFFF4655); // Tactical Crimson/Coral

  @override
  Widget build(BuildContext context) {
    final sidebarBg = isDark ? const Color(0xFF090B10) : Colors.white;
    final borderColor = isDark ? const Color(0x0EFFFFFF) : const Color(0xFFE2E8F0);
    final cardBg = isDark ? const Color(0xFF12151F) : const Color(0xFFF8FAFC);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);
    final textMuted = isDark ? const Color(0xFF7E869B) : const Color(0xFF64748B);

    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: sidebarBg,
        border: Border(
          right: BorderSide(
            color: borderColor,
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
                  color: luxuryCoralRose.withValues(alpha: 0.12),
                  border: Border.all(
                    color: luxuryCoralRose.withValues(alpha: 0.35),
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
                      color: textPrimary,
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
            id: 'landing',
            icon: Icons.public_rounded,
            label: 'Public Website',
            badge: 'LIVE',
            badgeColor: const Color(0xFF10B981),
          ),
          const SizedBox(height: 6),
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
            badgeColor: const Color(0xFFF59E0B),
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
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: borderColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.04),
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
                      '3 Damansara',
                      style: AppTypography.ui(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: luxuryCoralRose.withValues(alpha: 0.15),
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
                    color: textMuted,
                  ),
                ),
                const SizedBox(height: 12),
                SoftHoverButton(
                  onTap: onWalkInTap,
                  builder: (context, isHovered) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      curve: Curves.easeOutCubic,
                      width: double.infinity,
                      height: 34,
                      decoration: BoxDecoration(
                        color: isHovered ? const Color(0xFFE11D48) : luxuryCoralRose,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: luxuryCoralRose.withValues(alpha: isHovered ? 0.45 : 0.20),
                            blurRadius: isHovered ? 14 : 8,
                            offset: const Offset(0, 2),
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
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ==========================================
          // USER PROFILE CHIP (ALMAN RAHMAN)
          // ==========================================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: borderColor,
              ),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundImage: AssetImage(DemoAvatars.user),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981),
                          shape: BoxShape.circle,
                          border: Border.all(color: sidebarBg, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Alman Rahman',
                        style: AppTypography.ui(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Pro Member',
                        style: AppTypography.ui(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: luxuryCoralRose,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
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
    final activeBg = isDark ? const Color(0x18FF4655) : const Color(0xFFF1F5F9);
    final activeBorder = isDark ? const Color(0x40FF4655) : const Color(0xFFCBD5E1);
    final textMuted = isDark ? const Color(0xFF7E869B) : const Color(0xFF64748B);
    final textPrimary = isDark ? Colors.white : const Color(0xFF0F172A);

    return SoftHoverButton(
      onTap: () => onItemTap(id),
      builder: (context, isHovered) {
        final hoverBg = isDark ? Colors.white.withValues(alpha: 0.07) : Colors.black.withValues(alpha: 0.04);
        final hoverBorder = isDark ? Colors.white.withValues(alpha: 0.12) : Colors.black.withValues(alpha: 0.08);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOutCubic,
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isActive ? activeBg : (isHovered ? hoverBg : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isActive ? activeBorder : (isHovered ? hoverBorder : Colors.transparent),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isActive
                    ? luxuryCoralRose
                    : (isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textMuted),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.ui(
                    fontSize: 12.5,
                    fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                    color: isActive
                        ? textPrimary
                        : (isHovered ? (isDark ? Colors.white : const Color(0xFF0F172A)) : textMuted),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                  decoration: BoxDecoration(
                    color: (badgeColor ?? luxuryCoralRose).withValues(alpha: isDark ? 0.2 : 0.12),
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
        );
      },
    );
  }
}
