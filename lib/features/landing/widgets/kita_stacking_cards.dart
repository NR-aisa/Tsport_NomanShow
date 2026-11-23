import 'package:flutter/material.dart';
import '../../../core/theme/app_typography.dart';

/// Data model representing each card in the tactile KITA-style stacking deck.
class KitaCardItem {
  final String step;
  final String tag;
  final String title;
  final String description;
  final String badgeText;
  final Color accentColor;
  final Color surfaceColor;
  final IconData icon;
  final String? imageAsset;
  final String ctaLabel;
  final VoidCallback? onTap;
  final List<Map<String, String>> stats;

  const KitaCardItem({
    required this.step,
    required this.tag,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.accentColor,
    required this.surfaceColor,
    required this.icon,
    this.imageAsset,
    required this.ctaLabel,
    this.onTap,
    this.stats = const [],
  });
}

/// Interactive KITA-style Stacking Deck with tactile surfaces, negative-spread
/// shadows, progressive locked hues, and whole-card hover inversion.
class KitaStackingDeck extends StatefulWidget {
  final List<KitaCardItem> cards;

  const KitaStackingDeck({
    super.key,
    required this.cards,
  });

  @override
  State<KitaStackingDeck> createState() => _KitaStackingDeckState();
}

class _KitaStackingDeckState extends State<KitaStackingDeck> {
  int _activeCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 960;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Interactive Deck Index Tabs (Desktop & Tablet)
            if (isDesktop) ...[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F121C),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(widget.cards.length, (index) {
                      final item = widget.cards[index];
                      final isSelected = _activeCardIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _activeCardIndex = index;
                            });
                          },
                          borderRadius: BorderRadius.circular(999),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? item.accentColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(999),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: item.accentColor.withValues(alpha: 0.35),
                                        blurRadius: 14,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item.step,
                                  style: AppTypography.ui(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w900,
                                    color: isSelected
                                        ? const Color(0xFF0A0D14)
                                        : Colors.white.withValues(alpha: 0.4),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  item.tag,
                                  style: AppTypography.ui(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected
                                        ? const Color(0xFF0A0D14)
                                        : Colors.white.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 36),
            ],

            // The Stacked Cards (Each rendered with KITA elevation & margins)
            for (int i = 0; i < widget.cards.length; i++) ...[
              Padding(
                padding: EdgeInsets.only(
                  bottom: i == widget.cards.length - 1 ? 0 : 32.0,
                ),
                child: _KitaIndividualCard(
                  item: widget.cards[i],
                  index: i,
                  isDesktop: isDesktop,
                  isFeatured: _activeCardIndex == i,
                  onActivate: () {
                    if (_activeCardIndex != i) {
                      setState(() {
                        _activeCardIndex = i;
                      });
                    }
                  },
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _KitaIndividualCard extends StatefulWidget {
  final KitaCardItem item;
  final int index;
  final bool isDesktop;
  final bool isFeatured;
  final VoidCallback onActivate;

  const _KitaIndividualCard({
    required this.item,
    required this.index,
    required this.isDesktop,
    required this.isFeatured,
    required this.onActivate,
  });

  @override
  State<_KitaIndividualCard> createState() => _KitaIndividualCardState();
}

class _KitaIndividualCardState extends State<_KitaIndividualCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        widget.onActivate();
      },
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: item.surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? item.accentColor.withValues(alpha: 0.35)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          // KITA's signature negative-spread ambient drop shadow
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.65 : 0.45),
              blurRadius: _isHovered ? 40 : 32,
              spreadRadius: -8, // Essential negative spread
              offset: const Offset(0, 10),
            ),
            if (_isHovered)
              BoxShadow(
                color: item.accentColor.withValues(alpha: 0.12),
                blurRadius: 28,
                spreadRadius: -4,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: widget.isDesktop
              ? _buildDesktopLayout(context, item)
              : _buildMobileLayout(context, item),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, KitaCardItem item) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Column (52%): Text Hierarchy & Stats & Pill CTA
          Expanded(
            flex: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Tag + Step Indicator
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: item.accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: item.accentColor.withValues(alpha: 0.35),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(item.icon, size: 13, color: item.accentColor),
                          const SizedBox(width: 6),
                          Text(
                            item.tag,
                            style: AppTypography.ui(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w900,
                              color: item.accentColor,
                              letterSpacing: 0.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.badgeText,
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Colors.white.withValues(alpha: 0.8),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Card Title
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: AppTypography.ui(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                    color: _isHovered ? item.accentColor : Colors.white,
                    height: 1.25,
                    letterSpacing: -0.5,
                  ),
                  child: Text(item.title),
                ),
                const SizedBox(height: 14),

                // Card Description
                Text(
                  item.description,
                  style: AppTypography.ui(
                    fontSize: 14,
                    color: const Color(0xFFBAC0D6),
                    height: 1.65,
                  ),
                ),
                const SizedBox(height: 24),

                // Tactile Stats Row (KITA Metric Pillars)
                if (item.stats.isNotEmpty) ...[
                  Row(
                    children: item.stats.map((stat) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stat['value'] ?? '',
                              style: AppTypography.ui(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              (stat['label'] ?? '').toUpperCase(),
                              style: AppTypography.ui(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withValues(alpha: 0.45),
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 26),
                ],

                // KITA Dynamic Inversion Pill CTA
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: item.onTap,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? item.accentColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: _isHovered
                              ? item.accentColor
                              : Colors.white.withValues(alpha: 0.2),
                          width: 1.2,
                        ),
                        boxShadow: _isHovered
                            ? [
                                BoxShadow(
                                  color: item.accentColor.withValues(alpha: 0.4),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.ctaLabel,
                            style: AppTypography.ui(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: _isHovered
                                  ? const Color(0xFF090C14)
                                  : Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: _isHovered
                                ? const Color(0xFF090C14)
                                : item.accentColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 36),

          // Right Column (48%): 16:9 Sub-Pixel Clipped Photography with Micro-Zoom
          Expanded(
            flex: 48,
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (item.imageAsset != null)
                      AnimatedScale(
                        scale: _isHovered ? 1.03 : 1.0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        child: Image.asset(
                          item.imageAsset!,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              item.accentColor.withValues(alpha: 0.2),
                              item.surfaceColor,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            item.icon,
                            size: 64,
                            color: item.accentColor.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    // Inner soft contrast rim
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                          width: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, KitaCardItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Header
        if (item.imageAsset != null)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  item.imageAsset!,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      item.badgeText,
                      style: AppTypography.ui(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(item.icon, size: 14, color: item.accentColor),
                  const SizedBox(width: 6),
                  Text(
                    item.tag,
                    style: AppTypography.ui(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      color: item.accentColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: AppTypography.ui(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                item.description,
                style: AppTypography.ui(
                  fontSize: 13,
                  color: const Color(0xFFBAC0D6),
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 18),
              if (item.stats.isNotEmpty) ...[
                Row(
                  children: item.stats.map((stat) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stat['value'] ?? '',
                            style: AppTypography.ui(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            (stat['label'] ?? '').toUpperCase(),
                            style: AppTypography.ui(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
              ],
              GestureDetector(
                onTap: item.onTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: item.accentColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.ctaLabel,
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF090C14),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: Color(0xFF090C14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
