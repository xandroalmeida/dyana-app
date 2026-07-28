import 'dart:async';

import 'package:flutter/material.dart';

class SessionDimmingLayer extends StatefulWidget {
  const SessionDimmingLayer({
    required this.child,
    required this.active,
    super.key,
    this.delay = const Duration(seconds: 5),
    this.transitionDuration = const Duration(seconds: 2),
    this.dimmedOpacity = 0.72,
  }) : assert(dimmedOpacity >= 0 && dimmedOpacity <= 1);

  final Widget child;
  final bool active;
  final Duration delay;
  final Duration transitionDuration;
  final double dimmedOpacity;

  @override
  State<SessionDimmingLayer> createState() => _SessionDimmingLayerState();
}

class _SessionDimmingLayerState extends State<SessionDimmingLayer> {
  static const _overlayKey = ValueKey('session-dimming-overlay');

  Timer? _dimmingTimer;
  bool _isDimmed = false;

  @override
  void initState() {
    super.initState();
    if (widget.active) {
      _scheduleDimming();
    }
  }

  @override
  void didUpdateWidget(SessionDimmingLayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.active) {
      _dimmingTimer?.cancel();
      _isDimmed = false;
      return;
    }

    if (!oldWidget.active || widget.delay != oldWidget.delay) {
      _scheduleDimming();
    }
  }

  @override
  void dispose() {
    _dimmingTimer?.cancel();
    super.dispose();
  }

  void _scheduleDimming() {
    _dimmingTimer?.cancel();
    _dimmingTimer = Timer(widget.delay, () {
      if (!mounted || !widget.active) return;
      setState(() => _isDimmed = true);
    });
  }

  void _handlePointerDown(PointerDownEvent event) {
    if (!widget.active) return;

    _scheduleDimming();
    if (_isDimmed) {
      setState(() => _isDimmed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: _handlePointerDown,
      child: Stack(
        fit: StackFit.expand,
        children: [
          widget.child,
          IgnorePointer(
            child: AnimatedOpacity(
              key: _overlayKey,
              opacity: _isDimmed ? widget.dimmedOpacity : 0,
              duration: widget.transitionDuration,
              curve: Curves.easeInOut,
              child: const ColoredBox(color: Colors.black),
            ),
          ),
          if (_isDimmed)
            const ModalBarrier(dismissible: false, color: Colors.transparent),
        ],
      ),
    );
  }
}
