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

/// Interactive KITA-style Stacking Deck:
/// Cards smoothly overlap and cover one another as the user scrolls,
/// leaving the top tab exposed with ambient negative-spread shadows.
class KitaStackingDeck extends StatefulWidget {
  final ScrollController? scrollController;
  final List<KitaCardItem> cards;

  const KitaStackingDeck({
    super.key,
    this.scrollController,
    required this.cards,
  });

  @override
  State<KitaStackingDeck> createState() => _KitaStackingDeckState();
}

class _KitaStackingDeckState extends State<KitaStackingDeck> {
  final GlobalKey _deckContainerKey = GlobalKey();
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 768;
        final double cardHeight = isDesktop ? 450.0 : 540.0;
        const double travelPerStep = 280.0;
        final double totalTravel = (widget.cards.length - 1) * travelPerStep;
        final double totalContainerHeight = cardHeight + totalTravel + 100.0;

        final animationTarget = widget.scrollController ?? ScrollController();

        return AnimatedBuilder(
          animation: animationTarget,
          builder: (context, _) {
            // Measure the vertical position of this section relative to the viewport
            double currentGlobalY = 1000.0;
            final renderBox = _deckContainerKey.currentContext?.findRenderObject() as RenderBox?;
            if (renderBox != null && renderBox.hasSize) {
              currentGlobalY = renderBox.localToGlobal(Offset.zero).dy;
            }

            // Stacking pin parameters
            const double navbarPinY = 75.0; // Clears fixed navbar
            final double scrollProgress = (navbarPinY - currentGlobalY).clamp(0.0, totalTravel);

            // Container-relative pin position for the active stacked viewport
            double pinnedTopOffset;
            if (currentGlobalY > navbarPinY) {
              pinnedTopOffset = 0.0;
            } else if (currentGlobalY <= navbarPinY && currentGlobalY >= navbarPinY - totalTravel) {
              pinnedTopOffset = navbarPinY - currentGlobalY;
            } else {
              pinnedTopOffset = totalTravel;
            }

            // Compute active card index
            final computedActive = (scrollProgress / travelPerStep).round().clamp(0, widget.cards.length - 1);
            if (computedActive != _activeTabIndex) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && _activeTabIndex != computedActive) {
                  setState(() => _activeTabIndex = computedActive);
                }
              });
            }

            return SizedBox(
              key: _deckContainerKey,
              height: totalContainerHeight,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: pinnedTopOffset,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Interactive Deck Index Tabs (Clicking scrolls directly to that card)
                        Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
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
                                  final isSelected = _activeTabIndex == index;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: InkWell(
                                      onTap: () {
                                        _jumpToCard(index, travelPerStep, currentGlobalY, navbarPinY);
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
                        ),
                        const SizedBox(height: 28),

                        // The Overlapping Stacking Cards Viewport
                        SizedBox(
                          height: cardHeight + 80.0,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: List.generate(widget.cards.length, (i) {
                              final item = widget.cards[i];
                              const double stepExposure = 26.0; // Top tab exposed from card beneath
                              final double targetPinnedTop = i * stepExposure;

                              double currentCardTop;
                              if (i == 0) {
                                currentCardTop = 0.0;
                              } else {
                                final double entryStart = (i - 1) * travelPerStep;
                                final double entryEnd = i * travelPerStep;

                                if (scrollProgress <= entryStart) {
                                  // Card is waiting below the view
                                  currentCardTop = cardHeight + 40.0;
                                } else if (scrollProgress >= entryEnd) {
                                  // Card is fully arrived and locked at its stacked position
                                  currentCardTop = targetPinnedTop;
                                } else {
                                  // Card is actively sliding up and overlapping the previous card
                                  final double t = (scrollProgress - entryStart) / travelPerStep;
                                  final double curveT = Curves.easeOutCubic.transform(t);
                                  currentCardTop = (1.0 - curveT) * (cardHeight + 40.0) + (curveT * targetPinnedTop);
                                }
                              }

                              return Positioned(
                                top: currentCardTop,
                                left: 0,
                                right: 0,
                                child: _KitaIndividualCard(
                                  item: item,
                                  index: i,
                                  isDesktop: isDesktop,
                                  isFeatured: _activeTabIndex == i,
                                  onActivate: () {
                                    if (_activeTabIndex != i) {
                                      setState(() => _activeTabIndex = i);
                                    }
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _jumpToCard(int index, double travelPerStep, double currentGlobalY, double navbarPinY) {
    if (widget.scrollController == null || !widget.scrollController!.hasClients) return;
    final double currentScroll = widget.scrollController!.offset;
    final double currentProgress = navbarPinY - currentGlobalY;
    final double targetProgress = index * travelPerStep;
    final double delta = targetProgress - currentProgress;
    final double targetScroll = (currentScroll + delta).clamp(
      0.0,
      widget.scrollController!.position.maxScrollExtent,
    );

    widget.scrollController!.animateTo(
      targetScroll,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeInOutCubic,
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
          // KITA's signature negative-spread ambient drop shadow (casts realistic shadow over card beneath)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.75 : 0.55),
              blurRadius: _isHovered ? 40 : 32,
              spreadRadius: -8, // Essential negative spread
              offset: const Offset(0, 10),
            ),
            if (_isHovered)
              BoxShadow(
                color: item.accentColor.withValues(alpha: 0.15),
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
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 34),
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
                const SizedBox(height: 18),

                // Card Title
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: AppTypography.ui(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: _isHovered ? item.accentColor : Colors.white,
                    height: 1.25,
                    letterSpacing: -0.5,
                  ),
                  child: Text(item.title),
                ),
                const SizedBox(height: 12),

                // Card Description
                Text(
                  item.description,
                  style: AppTypography.ui(
                    fontSize: 13.5,
                    color: const Color(0xFFBAC0D6),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),

                // Tactile Stats Row (KITA Metric Pillars)
                if (item.stats.isNotEmpty) ...[
                  Row(
                    children: item.stats.map((stat) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stat['value'] ?? '',
                              style: AppTypography.ui(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              (stat['label'] ?? '').toUpperCase(),
                              style: AppTypography.ui(
                                fontSize: 9.5,
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
                  const SizedBox(height: 22),
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
                        vertical: 11,
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
                              fontSize: 12.5,
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

          const SizedBox(width: 32),

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
