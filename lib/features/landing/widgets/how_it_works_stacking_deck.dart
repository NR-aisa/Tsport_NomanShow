import 'package:flutter/material.dart';
import '../../../core/theme/app_typography.dart';

/// Data model representing each step in the "How JOMNITTAKU Works" flow.
class HowItWorksStepItem {
  final String step;
  final String title;
  final String desc;
  final IconData icon;
  final Color accentColor;

  const HowItWorksStepItem({
    required this.step,
    required this.title,
    required this.desc,
    required this.icon,
    required this.accentColor,
  });
}

/// GPU-Accelerated Scroll-Driven Stacking Card Deck for the "How It Works" 4-Step Funnel.
///
/// Features:
/// 1. Pure $O(1)$ arithmetic using pre-measured document scroll coordinates.
/// 2. Hardware layer isolation via [RepaintBoundary] on each step card layer.
/// 3. Sequential glide-and-lock kinematics matching KITA & Dr. Arefin canonical physics.
/// 4. Tactile drop-shadows casting depth over preceding stacked cards.
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

        final isDesktop = constraints.maxWidth >= 768;
        final double cardHeight = isDesktop ? 175.0 : 210.0;
        const double travelPerStep = 240.0;
        const double stepExposure = 36.0;
        final double totalTravel = (widget.steps.length - 1) * travelPerStep;
        final double stackViewportHeight = cardHeight + ((widget.steps.length - 1) * stepExposure) + 40.0;
        final double totalContainerHeight = stackViewportHeight + totalTravel + 60.0;
        const double navbarPinY = 90.0; // Distance below viewport top to clear sticky navbar

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
                        constraints: const BoxConstraints(maxWidth: 880),
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
                                          padding: const EdgeInsets.symmetric(horizontal: 3),
                                          child: InkWell(
                                            onTap: () {
                                              _jumpToStep(index, travelPerStep, navbarPinY);
                                            },
                                            borderRadius: BorderRadius.circular(999),
                                            child: AnimatedContainer(
                                              duration: const Duration(milliseconds: 250),
                                              curve: Curves.easeOutCubic,
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 16,
                                                vertical: 7,
                                              ),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? item.accentColor.withValues(alpha: 0.2)
                                                    : Colors.transparent,
                                                borderRadius: BorderRadius.circular(999),
                                                border: isSelected
                                                    ? Border.all(
                                                        color: item.accentColor.withValues(alpha: 0.6),
                                                        width: 1,
                                                      )
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
                                                          ? item.accentColor
                                                          : Colors.white.withValues(alpha: 0.4),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 6),
                                                  Text(
                                                    item.title.split('(').first.trim(),
                                                    style: AppTypography.ui(
                                                      fontSize: 11.5,
                                                      fontWeight: FontWeight.w700,
                                                      color: isSelected
                                                          ? Colors.white
                                                          : Colors.white.withValues(alpha: 0.6),
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
                              const SizedBox(height: 24),

                              // The Stacking Cards Stage
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
                                        child: _HowItWorksCardWidget(
                                          item: item,
                                          index: i,
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
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }
}

class _HowItWorksCardWidget extends StatefulWidget {
  final HowItWorksStepItem item;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const _HowItWorksCardWidget({
    required this.item,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_HowItWorksCardWidget> createState() => _HowItWorksCardWidgetState();
}

class _HowItWorksCardWidgetState extends State<_HowItWorksCardWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
          decoration: BoxDecoration(
            color: const Color(0xFF131722), // Matching reference dark luxury card
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? item.accentColor.withValues(alpha: 0.45)
                  : (widget.isActive
                      ? item.accentColor.withValues(alpha: 0.25)
                      : Colors.white.withValues(alpha: 0.08)),
              width: 1.2,
            ),
            boxShadow: [
              // Negative-spread deep ambient shadow to layer over previous stacked cards
              BoxShadow(
                color: Colors.black.withValues(alpha: _isHovered ? 0.65 : 0.45),
                blurRadius: _isHovered ? 36 : 28,
                spreadRadius: -6,
                offset: const Offset(0, 10),
              ),
              if (_isHovered || widget.isActive)
                BoxShadow(
                  color: item.accentColor.withValues(alpha: _isHovered ? 0.18 : 0.08),
                  blurRadius: 24,
                  spreadRadius: -4,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header Row: Icon on left, Step Numeral on right
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: item.accentColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: item.accentColor.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Icon(item.icon, color: item.accentColor, size: 22),
                  ),
                  Text(
                    item.step,
                    style: AppTypography.ui(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white.withValues(alpha: 0.18),
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Title
              Text(
                item.title,
                style: AppTypography.ui(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 8),

              // Description
              Text(
                item.desc,
                style: AppTypography.ui(
                  fontSize: 13.5,
                  color: const Color(0xFFBAC0D6),
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
