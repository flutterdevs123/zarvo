import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/constants/app_info.dart';
import '../../res/theme/app_colors.dart';
import '../../res/utils/responsive_wrapper.dart';
import '../../view_models/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _pulseController;
  late AnimationController _loadingController;
  late AnimationController _spinController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Live Terminal Logs
  final ValueNotifier<String> _currentLog = ValueNotifier<String>("INITIALIZING SYSTEM...");
  final List<String> _bootLogs = [
    "MOUNTING OFFLINE STORAGE...",
    "LOADING UI MODULES...",
    "BYPASSING SERVER PROTOCOLS...",
    "CHECKING USER ROLE (STUDENT/BUSINESS)...",
    "ACTIVATING AI ENGINE...",
    "SYSTEM SECURE. READY FOR LAUNCH."
  ];
  Timer? _logTimer;

  @override
  void initState() {
    super.initState();

    // 1. Entrance Animations
    _entranceController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack)),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _entranceController, curve: const Interval(0.5, 1.0, curve: Curves.easeOutCubic)),
    );

    // 2. Pulse Animation
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat(reverse: true);

    // 3. Spin Animation for Orbiting Rings
    _spinController = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();

    // 4. Loading Progress
    _loadingController = AnimationController(vsync: this, duration: const Duration(milliseconds: 2500));

    // Start Sequence
    _entranceController.forward().then((_) {
      _loadingController.forward();
      _startTerminalLogs();
    });
  }

  void _startTerminalLogs() {
    int index = 0;
    _logTimer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      if (index < _bootLogs.length) {
        _currentLog.value = _bootLogs[index];
        index++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    _loadingController.dispose();
    _spinController.dispose();
    _logTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWrapper(
        disableScroll: true,
        child: Stack(
          children: [
            // --- LAYER 1: Deep Background ---
            Container(color: AppColors.bgDark),

            // Ambient Neon Blobs
            Positioned(top: -100, left: -100, child: _buildAmbientBlob(AppColors.accentPurple.withOpacity(0.15), 350)),
            Positioned(bottom: -150, right: -100, child: _buildAmbientBlob(AppColors.primaryNeonBlue.withOpacity(0.1), 450)),

            // --- LAYER 2: HUD Data (Corners) ---
            FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHudText("SYS_OS: v1.0.0\nCORE: OFFLINE"),
                        _buildHudText("STATUS: ONLINE\nMEM: 1024_MB", alignRight: true),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHudCorner(isTopLeft: false),
                        _buildHudCorner(isTopLeft: false, isRight: true),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // --- LAYER 3: Main Content (Center) ---
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),

                  // Animated Orbiting Rings & Logo
                  SizedBox(
                    height: 220,
                    width: 220,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer Spinning Ring (Clockwise)
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: RotationTransition(
                            turns: _spinController,
                            child: _buildDashedRing(220, AppColors.primaryNeonBlue.withOpacity(0.5)),
                          ),
                        ),
                        // Inner Spinning Ring (Counter-Clockwise)
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: RotationTransition(
                            turns: Tween<double>(begin: 1.0, end: 0.0).animate(_spinController),
                            child: _buildDashedRing(180, AppColors.accentPurple.withOpacity(0.5), isReverse: true),
                          ),
                        ),
                        // Main Pulsing Logo
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              return Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryNeonBlue.withOpacity(0.3 + (_pulseController.value * 0.3)),
                                      blurRadius: 40,
                                      spreadRadius: 5 + (_pulseController.value * 10),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(AppInfo.appLogo, height: 130, width: 130, fit: BoxFit.cover),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Brand Name
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [AppColors.primaryNeonBlue, AppColors.accentPurple, AppColors.highlightGold],
                        ).createShader(bounds),
                        child: Text(
                          AppInfo.appName.toUpperCase(),
                          style: const TextStyle(fontSize: 52, fontWeight: FontWeight.w900, letterSpacing: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Tagline
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryNeonBlue.withOpacity(0.05),
                          border: Border.all(color: AppColors.primaryNeonBlue.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(4), // Tech sharp edges
                        ),
                        child: const Text('ZERO-COST MULTI-UTILITY ENGINE', style: TextStyle(fontSize: 10, color: AppColors.textWhite, letterSpacing: 3.5, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),

                  const Spacer(flex: 2),

                  // --- LAYER 4: Console/Terminal & Loader ---
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Live Terminal Text
                          ValueListenableBuilder<String>(
                            valueListenable: _currentLog,
                            builder: (context, logText, child) {
                              return Text(
                                '> $logText',
                                style: const TextStyle(
                                  color: AppColors.primaryNeonBlue,
                                  fontSize: 10,
                                  fontFamily: 'Courier',
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),

                          // High-Tech Progress Bar
                          AnimatedBuilder(
                            animation: _loadingController,
                            builder: (context, child) {
                              return Stack(
                                children: [
                                  Container(height: 3, width: double.infinity, color: AppColors.textGrey.withOpacity(0.2)),
                                  FractionallySizedBox(
                                    widthFactor: _loadingController.value,
                                    child: Container(
                                      height: 3,
                                      decoration: const BoxDecoration(
                                        color: AppColors.accentPurple,
                                        boxShadow: [BoxShadow(color: AppColors.accentPurple, blurRadius: 10)],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),

                          const SizedBox(height: 5),

                          // Tech Sub-info
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('AUTH: VERIFIED', style: TextStyle(color: AppColors.textGrey, fontSize: 8)),
                              AnimatedBuilder(
                                animation: _loadingController,
                                builder: (context, child) => Text(
                                  '[${(_loadingController.value * 100).toInt()}%]',
                                  style: const TextStyle(color: AppColors.textGrey, fontSize: 8),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(flex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET BUILDER HELPERS ---

  Widget _buildAmbientBlob(Color color, double size) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(filter: ui.ImageFilter.blur(sigmaX: 100, sigmaY: 100), child: Container(color: Colors.transparent)),
    );
  }

  Widget _buildDashedRing(double size, Color color, {bool isReverse = false}) {
    return SizedBox(
      height: size, width: size,
      child: CircularProgressIndicator(
        value: 0.8, // Creates a gap in the ring
        strokeWidth: 2,
        color: color,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _buildHudText(String text, {bool alignRight = false}) {
    return Text(
      text,
      textAlign: alignRight ? TextAlign.right : TextAlign.left,
      style: TextStyle(color: AppColors.primaryNeonBlue.withOpacity(0.6), fontSize: 9, fontFamily: 'Courier', letterSpacing: 1.5, height: 1.5),
    );
  }

  Widget _buildHudCorner({required bool isTopLeft, bool isRight = false}) {
    return Container(
      height: 20, width: 20,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.primaryNeonBlue.withOpacity(0.5), width: 2),
          right: isRight ? BorderSide(color: AppColors.primaryNeonBlue.withOpacity(0.5), width: 2) : BorderSide.none,
          left: !isRight ? BorderSide(color: AppColors.primaryNeonBlue.withOpacity(0.5), width: 2) : BorderSide.none,
        ),
      ),
    );
  }
}