import 'package:flutter/material.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../core/session/app_session.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme_controller.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/arena_widgets.dart';
import '../../../shared/widgets/tactile_button.dart';

/// Member Login (Phase 1B) — the screen this app never had.
///
/// Front-end only, matching the project's scope: the player enters the
/// phone or email from their registration, "receives" a 6-digit code
/// (any 6 digits work in this demo build), and lands back in the arena
/// as themselves. Toby lesson applied: error states are explicit and
/// recoverable, never silent.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  bool _codeSent = false;
  String? _error;

  @override
  void dispose() {
    _idController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  void _sendCode() {
    final id = _idController.text.trim();
    final looksLikeEmail = id.contains('@') && id.contains('.');
    final looksLikePhone = id.replaceAll(RegExp(r'[\s+\-]'), '').length >= 9;
    if (!looksLikeEmail && !looksLikePhone) {
      setState(() => _error = 'Enter the phone number or email you registered with.');
      return;
    }
    setState(() {
      _error = null;
      _codeSent = true;
    });
    ArenaToast.show(context, message: 'Code sent to $id (demo: any 6 digits work)');
  }

  void _verify() {
    final code = _codeController.text.trim();
    if (code.length != 6 || int.tryParse(code) == null) {
      setState(() => _error = 'That code is 6 digits — check and try again.');
      return;
    }
    AppSession.signInMember();
    AppNavigator.toHomeAndClear(context);
  }

  @override
  Widget build(BuildContext context) {
    return ThemeScope(
      builder: (context, isDark) {
        return Scaffold(
          backgroundColor: AppColors.canvasBg,
          body: ArenaBackdrop(
            child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.maybePop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.obsidianCard,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            size: 16, color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Welcome back',
                    style: AppTypography.ui(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Log in with the phone or email on your member pass.',
                    style: AppTypography.ui(fontSize: 12, color: AppColors.textSecondary),
                  ),
                  const SizedBox(height: 24),

                  _field(
                    controller: _idController,
                    hint: '+60 12-xxx xxxx or your.email@domain.com',
                    label: 'PHONE OR EMAIL',
                    keyboard: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 14),

                  if (_codeSent)
                    _field(
                      controller: _codeController,
                      hint: '6-digit code',
                      label: 'VERIFICATION CODE',
                      keyboard: TextInputType.number,
                    ),
                  if (_codeSent) const SizedBox(height: 14),

                  if (_error != null) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.electricCrimson.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.electricCrimson.withValues(alpha: 0.45)),
                      ),
                      child: Text(
                        _error!,
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.electricCrimson,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],

                  if (!_codeSent)
                    TactileButton.volt(text: 'Send Login Code →', onPressed: _sendCode)
                  else ...[
                    TactileButton.volt(text: 'Enter the Arena →', onPressed: _verify),
                    const SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: _sendCode,
                        child: Text(
                          'Resend code',
                          style: AppTypography.ui(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),

                  Center(
                    child: GestureDetector(
                      onTap: () => AppNavigator.toRegister(context),
                      child: Text(
                        'Not a member yet? Register →',
                        style: AppTypography.ui(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ittfTableBorder,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
        );
      },
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String hint,
    required String label,
    TextInputType? keyboard,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.ui(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: AppColors.textSecondary,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboard,
          style: AppTypography.ui(fontSize: 14, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTypography.ui(fontSize: 13, color: AppColors.textMuted),
            filled: true,
            fillColor: AppColors.obsidianCard,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.voltLime, width: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}
