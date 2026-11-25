import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Conditional web video support
import 'dart:ui_web' as ui_web;
import 'package:web/web.dart' as web;

/// High-Performance 60 FPS Looping Video Player for JOMNITTAKU Arena.
///
/// On Web: Mounts a native hardware-accelerated HTML5 `<video>` element.
/// On Mobile/Desktop: Gracefully renders the high-res cinematic action photo.
class ArenaVideoPlayer extends StatefulWidget {
  final String videoPath;
  final String fallbackImagePath;
  final double borderRadius;
  final bool showVignette;
  final Widget? overlay;

  const ArenaVideoPlayer({
    super.key,
    this.videoPath = 'videos/arena_highlight.mp4',
    this.fallbackImagePath = 'assets/images/arena_live_rally.jpg',
    this.borderRadius = 20.0,
    this.showVignette = false,
    this.overlay,
  });

  @override
  State<ArenaVideoPlayer> createState() => _ArenaVideoPlayerState();
}

class _ArenaVideoPlayerState extends State<ArenaVideoPlayer> {
  static int _viewIdCounter = 0;
  late final String _viewType;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _viewIdCounter++;
      _viewType = 'jomnittaku-video-view-$_viewIdCounter';
      _registerVideoElement();
      _initialized = true;
    }
  }

  void _registerVideoElement() {
    try {
      ui_web.platformViewRegistry.registerViewFactory(_viewType, (int viewId) {
        final video = web.HTMLVideoElement()
          ..src = widget.videoPath
          ..setAttribute('poster', 'assets/assets/images/arena_match_intensity.jpg')
          ..autoplay = true
          ..loop = true
          ..muted = true
          ..playsInline = true
          ..preload = 'auto'
          ..setAttribute('autoplay', '')
          ..setAttribute('muted', '')
          ..setAttribute('playsinline', '')
          ..setAttribute('loop', '')
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.objectFit = 'cover'
          ..style.borderRadius = '${widget.borderRadius}px'
          ..style.backgroundColor = 'transparent'
          ..style.pointerEvents = 'none';

        // Play video safely
        try {
          video.play();
        } catch (_) {}
        return video;
      });
    } catch (_) {
      // If already registered or failed, fallback to image
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. High-Res Action Image (Always present as instant cinematic background)
          Image.asset(
            widget.fallbackImagePath,
            fit: BoxFit.cover,
          ),

          // 2. Hardware-accelerated HTML5 Video on Web
          if (kIsWeb && _initialized)
            HtmlElementView(viewType: _viewType),

          // 3. Optional Vignette Gradient Overlay
          if (widget.showVignette)
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.1),
                    Colors.black.withValues(alpha: 0.65),
                  ],
                  stops: const [0.4, 1.0],
                ),
              ),
            ),

          // 4. Custom Overlay (HUD Telemetry, Court Status, Badges)
          if (widget.overlay != null) widget.overlay!,
        ],
      ),
    );
  }
}
