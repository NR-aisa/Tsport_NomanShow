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
  final Color? textColor;
  final Color? mutedTextColor;
  final Color? borderColor;
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
    this.textColor,
    this.mutedTextColor,
    this.borderColor,
    required this.icon,
    this.imageAsset,
    required this.ctaLabel,
    this.onTap,
    this.stats = const [],
  });
}

/// GPU-Accelerated KITA & Dr. Arefin Canonical Sticky-Stack Deck.
///
/// Features:
/// 1. Zero synchronous layout recalculation ($O(1)$ math using cached document position).
/// 2. Hardware layer isolation via [RepaintBoundary] on every card layer.
/// 3. Smooth native GPU compositing during scroll without canvas repaints.
/// 4. 4 sequential states matching the reference UI (unscrolled -> mid-scroll glide -> fanned deck -> exit).
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
  double? _cachedSectionDocTop;
  int _activeTabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureSectionTop());
  }

  void _measureSectionTop() {
    if (!mounted) return;
    final renderBox = _deckContainerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final currentScroll = widget.scrollController?.hasClients == true
          ? widget.scrollController!.offset
          : 0.0;
      final globalDy = renderBox.localToGlobal(Offset.zero).dy;
      _cachedSectionDocTop = globalDy + currentScroll;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Re-measure when window/container constraints change
        WidgetsBinding.instance.addPostFrameCallback((_) => _measureSectionTop());

        final isDesktop = constraints.maxWidth >= 768;
        final double cardHeight = isDesktop ? 450.0 : 540.0;
        const double travelPerStep = 320.0; // Dr. Arefin canonical travel distance
        final double totalTravel = (widget.cards.length - 1) * travelPerStep;
        final double totalContainerHeight = cardHeight + totalTravel + 120.0;
        const double navbarPinY = 80.0; // Clears fixed navbar

        final animationTarget = widget.scrollController ?? ScrollController();

        return AnimatedBuilder(
          animation: animationTarget,
          builder: (context, _) {
            final double currentScroll = widget.scrollController?.hasClients == true
                ? widget.scrollController!.offset
                : 0.0;

            // Pure O(1) arithmetic: compute global Y without touching the render tree during scroll
            final double sectionDocTop = _cachedSectionDocTop ?? 1800.0;
            final double currentGlobalY = sectionDocTop - currentScroll;

            // Stacking pin parameters
            final double scrollProgress = (navbarPinY - currentGlobalY).clamp(0.0, totalTravel);

            // Container-relative pin position
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
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1060),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                        // Interactive Deck Index Tabs
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
                                        _jumpToCard(index, travelPerStep, navbarPinY);
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
                                                    ? (item.accentColor.computeLuminance() > 0.4
                                                        ? const Color(0xFF0A0D14)
                                                        : Colors.white)
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
                                                    ? (item.accentColor.computeLuminance() > 0.4
                                                        ? const Color(0xFF0A0D14)
                                                        : Colors.white)
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
                          height: cardHeight + 90.0,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: List.generate(widget.cards.length, (i) {
                              final item = widget.cards[i];
                              const double stepExposure = 24.0; // Dr. Arefin canonical CARD_OFFSET
                              final double targetPinnedTop = i * stepExposure;

                              double currentCardTop;
                              if (i == 0) {
                                currentCardTop = 0.0;
                              } else {
                                final double entryStart = (i - 1) * travelPerStep;
                                final double entryEnd = i * travelPerStep;

                                if (scrollProgress <= entryStart) {
                                  // State 1: Card is sitting below in natural sequence
                                  currentCardTop = cardHeight + 40.0;
                                } else if (scrollProgress >= entryEnd) {
                                  // State 3: Card has locked into the fanned deck stack
                                  currentCardTop = targetPinnedTop;
                                } else {
                                  // State 2: Card is smoothly gliding over the previous card
                                  final double t = (scrollProgress - entryStart) / travelPerStep;
                                  final double curveT = Curves.easeOutCubic.transform(t);
                                  currentCardTop = (1.0 - curveT) * (cardHeight + 40.0) + (curveT * targetPinnedTop);
                                }
                              }

                              return Positioned(
                                top: currentCardTop,
                                left: 0,
                                right: 0,
                                child: RepaintBoundary(
                                  // GPU Hardware Layer Isolation: avoids repainting other cards
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
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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

  void _jumpToCard(int index, double travelPerStep, double navbarPinY) {
    if (widget.scrollController == null || !widget.scrollController!.hasClients) return;
    final double sectionDocTop = _cachedSectionDocTop ?? 1800.0;
    final double targetScroll = (sectionDocTop - navbarPinY + (index * travelPerStep)).clamp(
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
    final textColor = item.textColor ?? Colors.white;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        widget.onActivate();
      },
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: item.surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? item.accentColor
                : (item.borderColor ?? textColor.withValues(alpha: 0.15)),
            width: 1.5,
          ),
          // Dr. Arefin & KITA signature negative-spread ambient drop shadow (casts realistic shadow over card beneath)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.65 : 0.45),
              blurRadius: _isHovered ? 36 : 28,
              spreadRadius: -6, // Essential negative spread
              offset: const Offset(0, 10),
            ),
            if (_isHovered)
              BoxShadow(
                color: item.accentColor.withValues(alpha: 0.25),
                blurRadius: 28,
                spreadRadius: -4,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Accent Indicator Line
              Container(
                height: 3.5,
                decoration: BoxDecoration(
                  color: item.accentColor,
                ),
              ),
              widget.isDesktop
                  ? _buildDesktopLayout(context, item)
                  : _buildMobileLayout(context, item),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, KitaCardItem item) {
    final textColor = item.textColor ?? Colors.white;
    final mutedColor = item.mutedTextColor ?? textColor.withValues(alpha: 0.72);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
                          color: item.accentColor.withValues(alpha: 0.4),
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
                        color: textColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        item.badgeText,
                        style: AppTypography.ui(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: textColor.withValues(alpha: 0.85),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Card Title
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: AppTypography.ui(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: _isHovered ? item.accentColor : textColor,
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
                    color: mutedColor,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 18),

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
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              (stat['label'] ?? '').toUpperCase(),
                              style: AppTypography.ui(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: textColor.withValues(alpha: 0.5),
                                letterSpacing: 0.6,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
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
                            : textColor.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: _isHovered
                              ? item.accentColor
                              : (item.borderColor ?? textColor.withValues(alpha: 0.25)),
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
                                  ? (item.accentColor.computeLuminance() > 0.4
                                      ? const Color(0xFF090C14)
                                      : Colors.white)
                                  : textColor,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: _isHovered
                                ? (item.accentColor.computeLuminance() > 0.4
                                    ? const Color(0xFF090C14)
                                    : Colors.white)
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

          // Right Column (48%): Framed Inset Photography (Never edge-to-edge)
          Expanded(
            flex: 48,
            child: Container(
              padding: const EdgeInsets.all(6), // Dedicated outer border frame
              decoration: BoxDecoration(
                color: textColor.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: item.borderColor ?? textColor.withValues(alpha: 0.18),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.22),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
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
                          borderRadius: BorderRadius.circular(16),
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
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, KitaCardItem item) {
    final textColor = item.textColor ?? Colors.white;
    final mutedColor = item.mutedTextColor ?? textColor.withValues(alpha: 0.72);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Framed Image Header
        if (item.imageAsset != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: item.borderColor ?? textColor.withValues(alpha: 0.18),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        item.imageAsset!,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
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
              ),
            ),
          ),

        Padding(
          padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 10),
              Text(
                item.title,
                style: AppTypography.ui(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.description,
                style: AppTypography.ui(
                  fontSize: 13,
                  color: mutedColor,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 16),
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
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            (stat['label'] ?? '').toUpperCase(),
                            style: AppTypography.ui(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: textColor.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 18),
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
                          color: item.accentColor.computeLuminance() > 0.4
                              ? const Color(0xFF090C14)
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 14,
                        color: item.accentColor.computeLuminance() > 0.4
                            ? const Color(0xFF090C14)
                            : Colors.white,
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
