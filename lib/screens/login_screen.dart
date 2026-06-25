import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _mobileController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth > 600;
          final isSmallMobile = constraints.maxWidth < 360;
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;

          return Stack(
            children: [
              // Background with Overlay
              Positioned.fill(
                child: Image.asset(
                  'assets/bg_luxury.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(color: AppColors.deepBlack),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.deepBlack.withOpacity(0.7),
                        AppColors.deepBlack.withOpacity(0.95),
                      ],
                    ),
                  ),
                ),
              ),

              // Main Content
              SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isTablet ? screenWidth * 0.1 : 20.0,
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: screenHeight * 0.05),
                              
                              // Header
                              FadeInDown(
                                duration: const Duration(milliseconds: 1000),
                                child: Column(
                                  children: [
                                    Hero(
                                      tag: 'logo',
                                      child: Image.asset(
                                        'assets/logo_gold.png',
                                        height: isTablet ? 100 : 70,
                                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.directions_car, color: AppColors.champagneGold, size: 50),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'motoX',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.montserrat(
                                        fontSize: isTablet ? 28 : 20,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.champagneGold,
                                        letterSpacing: isSmallMobile ? 2 : 4,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '"Luxury Service. Trusted Care."',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: isTablet ? 16 : 12,
                                        color: AppColors.silver.withOpacity(0.8),
                                        fontStyle: FontStyle.italic,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: screenHeight * 0.05),

                              // Login Card
                              FadeInUp(
                                duration: const Duration(milliseconds: 800),
                                child: Center(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxWidth: isTablet ? 450 : screenWidth,
                                    ),
                                    child: GlassCard(
                                      padding: EdgeInsets.all(isTablet ? 32 : 24),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _buildFieldLabel('Mobile Number'),
                                          const SizedBox(height: 10),
                                          TextField(
                                            controller: _mobileController,
                                            keyboardType: TextInputType.number,
                                            style: const TextStyle(color: Colors.white, fontSize: 16),
                                            decoration: InputDecoration(
                                              prefixIcon: _buildCountryCode(),
                                              hintText: 'Enter mobile number',
                                              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                          _buildFieldLabel('Password'),
                                          const SizedBox(height: 10),
                                          TextField(
                                            controller: _passwordController,
                                            obscureText: _obscurePassword,
                                            style: const TextStyle(color: Colors.white, fontSize: 16),
                                            decoration: InputDecoration(
                                              hintText: 'Enter password',
                                              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                                  color: AppColors.silver,
                                                  size: 20,
                                                ),
                                                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 12),

                                          // Remember Me & Forgot Password
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 22,
                                                    width: 22,
                                                    child: Checkbox(
                                                      value: _rememberMe,
                                                      onChanged: (value) => setState(() => _rememberMe = value!),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    'Remember Me',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      color: AppColors.textMediumEmphasis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              TextButton(
                                                onPressed: () {},
                                                style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                                child: Text(
                                                  'Forgot Password?',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color: AppColors.champagneGold,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          if (isTablet) ...[
                                            const SizedBox(height: 32),
                                            _buildLoginButton(isTablet),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Security Section
                              FadeInUp(
                                duration: const Duration(milliseconds: 800),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppColors.charcoal.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.glassBorder),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.lock_outline, color: AppColors.champagneGold, size: 14),
                                      const SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          'Authorized Supervisors Only',
                                          style: GoogleFonts.inter(
                                            fontSize: 11,
                                            color: AppColors.silver,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 40),

                              // Footer
                              FadeIn(
                                duration: const Duration(milliseconds: 1500),
                                child: Column(
                                  children: [
                                    const Divider(color: AppColors.glassBorder, indent: 60, endIndent: 60),
                                    const SizedBox(height: 20),
                                    Text(
                                      'Driven by Passion. Powered by Excellence.',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: AppColors.textMediumEmphasis.withOpacity(0.7),
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Fixed/Sticky Login Button for Mobile
                    if (!isTablet)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: FadeInUp(
                          duration: const Duration(milliseconds: 800),
                          child: _buildLoginButton(isTablet),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: AppColors.silver.withOpacity(0.9),
      ),
    );
  }

  Widget _buildCountryCode() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '+91',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: AppColors.champagneGold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 20,
            width: 1,
            color: AppColors.glassBorder,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildLoginButton(bool isTablet) {
    return Container(
      width: double.infinity,
      height: isTablet ? 60 : 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.champagneGold.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.goldGradientStart,
            AppColors.goldGradientEnd,
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Login Logic
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withOpacity(0.2),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SECURE SIGN IN',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    letterSpacing: 2.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward, color: Colors.black, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
