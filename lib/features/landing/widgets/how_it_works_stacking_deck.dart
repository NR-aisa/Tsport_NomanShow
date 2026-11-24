import 'package:flutter/material.dart';
import '../../../core/theme/app_typography.dart';

/// Data model representing each rich step in the "How JOMNITTAKU Works" flow.
class HowItWorksStepItem {
  final String step;
  final String tag;
  final String title;
  final String desc;
  final IconData icon;
  final Color accentColor;
  final Color surfaceColor;
  final String imageAsset;
  final String ctaLabel;
  final VoidCallback? onTap;
  final List<Map<String, String>> stats;
  final String? hudBadgeText;
  final IconData? hudBadgeIcon;

  const HowItWorksStepItem({
    required this.step,
    required this.tag,
    required this.title,
    required this.desc,
    required this.icon,
    required this.accentColor,
    required this.surfaceColor,
    required this.imageAsset,
    required this.ctaLabel,
    this.onTap,
    this.stats = const [],
    this.hudBadgeText,
    this.hudBadgeIcon,
  });
}

/// GPU-Accelerated Scroll-Driven 2-Column Stacking Card Deck for the 4-Step Funnel.
///
/// Features:
/// 1. Rich 2-column KITA & Apple style layout (Copy, Metrics, CTA on left; 16:10 photography on right).
/// 2. Pure $O(1)$ arithmetic using pre-measured document scroll coordinates (zero layout recalculations).
/// 3. Hardware layer isolation via [RepaintBoundary] on each step card layer.
/// 4. Sequential glide-and-lock kinematics with negative-spread ambient drop-shadows.
class HowItWorksStackingDeck extends StatefulWidget {
  final ScrollController? scrollController;
  final List<HowItWorksStepItem> steps;

  const HowItWorksStackingDeck({
    super.key,
    this.scrollController,
    required this.steps,
  });

  @override
  State<HowItWorksStackingDeck> createState() => _HowItWorksStackingDeckState();
}

class _HowItWorksStackingDeckState extends State<HowItWorksStackingDeck> {
  final GlobalKey _sectionKey = GlobalKey();
  double? _cachedSectionDocTop;
  int _activeStepIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measureDocTop());
  }

  void _measureDocTop() {
    if (!mounted) return;
    final renderBox = _sectionKey.currentContext?.findRenderObject() as RenderBox?;
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
        WidgetsBinding.instance.addPostFrameCallback((_) => _measureDocTop());

        final isDesktop = constraints.maxWidth >= 820;
        final double cardHeight = isDesktop ? 440.0 : 540.0;
        const double travelPerStep = 320.0; // Canonical travel distance
        const double stepExposure = 28.0; // Canonical CARD_OFFSET for fanned tabs
        final double totalTravel = (widget.steps.length - 1) * travelPerStep;
        final double stackViewportHeight = cardHeight + ((widget.steps.length - 1) * stepExposure) + 40.0;
        final double totalContainerHeight = stackViewportHeight + totalTravel + 80.0;
        const double navbarPinY = 90.0; // Clears fixed navbar

        final animationTarget = widget.scrollController ?? ScrollController();

        return AnimatedBuilder(
          animation: animationTarget,
          builder: (context, _) {
            final double currentScroll = widget.scrollController?.hasClients == true
                ? widget.scrollController!.offset
                : 0.0;

            final double sectionDocTop = _cachedSectionDocTop ?? 1400.0;
            final double currentGlobalY = sectionDocTop - currentScroll;
            final double scrollProgress = (navbarPinY - currentGlobalY).clamp(0.0, totalTravel);

            double pinnedTopOffset;
            if (currentGlobalY > navbarPinY) {
              pinnedTopOffset = 0.0;
            } else if (currentGlobalY <= navbarPinY && currentGlobalY >= navbarPinY - totalTravel) {
              pinnedTopOffset = navbarPinY - currentGlobalY;
            } else {
              pinnedTopOffset = totalTravel;
            }

            final computedActive = (scrollProgress / travelPerStep).round().clamp(0, widget.steps.length - 1);
            if (computedActive != _activeStepIndex) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && _activeStepIndex != computedActive) {
                  setState(() => _activeStepIndex = computedActive);
                }
              });
            }

            return SizedBox(
              key: _sectionKey,
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
                        constraints: const BoxConstraints(maxWidth: 1160),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Quick Step Nav Pills
                              Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF0D1017),
                                      borderRadius: BorderRadius.circular(999),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.08),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: List.generate(widget.steps.length, (index) {
                                        final item = widget.steps[index];
                                        final isSelected = _activeStepIndex == index;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4),
                                          child: InkWell(
                                            onTap: () {
                                              _jumpToStep(index, travelPerStep, navbarPinY);
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
                                                          blurRadius: 12,
                                                          offset: const Offset(0, 3),
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
                                                          ? const Color(0xFF080B12)
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
                                                          ? const Color(0xFF080B12)
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
                              const SizedBox(height: 26),

                              // The Stacking Cards Viewport
                              SizedBox(
                                height: stackViewportHeight,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: List.generate(widget.steps.length, (i) {
                                    final item = widget.steps[i];
                                    final double targetPinnedTop = i * stepExposure;

                                    double currentCardTop;
                                    if (i == 0) {
                                      currentCardTop = 0.0;
                                    } else {
                                      final double entryStart = (i - 1) * travelPerStep;
                                      final double entryEnd = i * travelPerStep;

                                      if (scrollProgress <= entryStart) {
                                        currentCardTop = cardHeight + 40.0;
                                      } else if (scrollProgress >= entryEnd) {
                                        currentCardTop = targetPinnedTop;
                                      } else {
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
                                        child: _RichHowItWorksCard(
                                          item: item,
                                          index: i,
                                          isDesktop: isDesktop,
                                          isActive: _activeStepIndex == i,
                                          onTap: () => _jumpToStep(i, travelPerStep, navbarPinY),
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

  void _jumpToStep(int index, double travelPerStep, double navbarPinY) {
    if (widget.scrollController == null || !widget.scrollController!.hasClients) return;
    final double sectionDocTop = _cachedSectionDocTop ?? 1400.0;
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

class _RichHowItWorksCard extends StatefulWidget {
  final HowItWorksStepItem item;
  final int index;
  final bool isDesktop;
  final bool isActive;
  final VoidCallback onTap;

  const _RichHowItWorksCard({
    required this.item,
    required this.index,
    required this.isDesktop,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_RichHowItWorksCard> createState() => _RichHowItWorksCardState();
}

class _RichHowItWorksCardState extends State<_RichHowItWorksCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: item.surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? item.accentColor.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.10),
            width: 1.2,
          ),
          boxShadow: [
            // Deep ambient negative-spread drop-shadow casting onto underlying cards
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.70 : 0.55),
              blurRadius: _isHovered ? 38 : 30,
              spreadRadius: -6,
              offset: const Offset(0, 10),
            ),
            if (_isHovered)
              BoxShadow(
                color: item.accentColor.withValues(alpha: 0.18),
                blurRadius: 26,
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

  Widget _buildDesktopLayout(BuildContext context, HowItWorksStepItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 34),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Column (52%): Step Badge, Title, Description, Metrics, CTA
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'STEP ${item.step}',
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

                // Step Title
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

                // Narrative Copy
                Text(
                  item.desc,
                  style: AppTypography.ui(
                    fontSize: 13.5,
                    color: const Color(0xFFBAC0D6),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 20),

                // 3 Tactile Metric Pillars (KITA Style)
                if (item.stats.isNotEmpty) ...[
                  Row(
                    children: item.stats.map((stat) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              stat['value'] ?? '',
                              style: AppTypography.ui(
                                fontSize: 15,
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

                // Dynamic Inversion CTA Pill
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: item.onTap,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                      decoration: BoxDecoration(
                        color: _isHovered ? item.accentColor : Colors.white.withValues(alpha: 0.06),
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
                              color: _isHovered ? const Color(0xFF090C14) : Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: _isHovered ? const Color(0xFF090C14) : item.accentColor,
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

          // Right Column (48%): Rich Inset Photography with HUD Badge Overlay
          Expanded(
            flex: 48,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedScale(
                      scale: _isHovered ? 1.03 : 1.0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                      child: Image.asset(
                        item.imageAsset,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // High-Tech Telemetry Overlay Badge
                    if (item.hudBadgeText != null)
                      Positioned(
                        bottom: 14,
                        right: 14,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.82),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: item.accentColor.withValues(alpha: 0.45),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (item.hudBadgeIcon != null) ...[
                                Icon(item.hudBadgeIcon, size: 12, color: item.accentColor),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                item.hudBadgeText!,
                                style: AppTypography.ui(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Delicate hairline rim
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.14),
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

  Widget _buildMobileLayout(BuildContext context, HowItWorksStepItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Header
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                item.imageAsset,
                fit: BoxFit.cover,
              ),
              if (item.hudBadgeText != null)
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: item.accentColor.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      item.hudBadgeText!,
                      style: AppTypography.ui(
                        fontSize: 9,
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
                  const Spacer(),
                  Text(
                    'STEP ${item.step}',
                    style: AppTypography.ui(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.4),
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
                item.desc,
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
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
