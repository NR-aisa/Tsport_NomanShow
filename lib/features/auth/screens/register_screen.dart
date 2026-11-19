import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback? onRegisterSuccess;

  const RegisterScreen({super.key, this.onRegisterSuccess});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _agreedToPrivacy = true;
  final _nameController = TextEditingController(text: 'Noman Rashid');
  final _emailController = TextEditingController(text: 'noman@example.com');
  final _phoneController = TextEditingController(text: '+60 12-345 6789');
  final _dobController = TextEditingController(text: '14 / 08 / 1996');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: Text(
          'NEW PLAYER REGISTRATION',
          style: GoogleFonts.bebasNeue(fontSize: 22, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGlow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.flash_on_rounded, color: AppColors.primary),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1500 STARTER XP UNLOCKED',
                          style: GoogleFonts.bebasNeue(
                            fontSize: 18,
                            color: AppColors.xpGold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          'Register now to join the live TV leaderboard and challenge system.',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Avatar Upload Picker
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surface2,
                      border: Border.all(color: AppColors.primary, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'NR',
                        style: GoogleFonts.bebasNeue(
                          fontSize: 36,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 16,
                        color: AppColors.bg,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Photo for TV Leaderboard & VS Match Screen',
                style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted),
              ),
            ),
            const SizedBox(height: 24),

            // Form Fields
            _buildLabel('FULL NAME'),
            _buildTextField(
              controller: _nameController,
              icon: Icons.person_outline_rounded,
              hint: 'Enter your legal name',
            ),
            const SizedBox(height: 16),

            _buildLabel('EMAIL ADDRESS'),
            _buildTextField(
              controller: _emailController,
              icon: Icons.alternate_email_rounded,
              hint: 'your.email@domain.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            _buildLabel('PHONE NUMBER (MALAYSIA)'),
            _buildTextField(
              controller: _phoneController,
              icon: Icons.phone_android_rounded,
              hint: '+60 12-xxx xxxx',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),

            _buildLabel('DATE OF BIRTH'),
            _buildTextField(
              controller: _dobController,
              icon: Icons.cake_outlined,
              hint: 'DD / MM / YYYY',
            ),
            const SizedBox(height: 24),

            // Privacy Checkbox
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: _agreedToPrivacy ? AppColors.primary.withValues(alpha: 0.4) : AppColors.border,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _agreedToPrivacy,
                    activeColor: AppColors.primary,
                    checkColor: AppColors.bg,
                    onChanged: (val) {
                      setState(() => _agreedToPrivacy = val ?? false);
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'I agree to the Privacy Statement (PDPA 2010). My name, avatar, and match statistics can be displayed publicly on the venue TV leaderboard and challenge screen.',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Submit Button
            ElevatedButton(
              onPressed: _agreedToPrivacy ? widget.onRegisterSuccess : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.bg,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      'PROCEED TO SELECT PLAN',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(color: AppColors.textPrimary, fontSize: 14),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 14),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
