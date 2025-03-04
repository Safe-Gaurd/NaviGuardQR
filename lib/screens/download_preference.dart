import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ResponsiveAskScreen extends StatefulWidget {
  const ResponsiveAskScreen({Key? key}) : super(key: key);

  @override
  _ResponsiveAskScreenState createState() => _ResponsiveAskScreenState();
}

class _ResponsiveAskScreenState extends State<ResponsiveAskScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Shared URL launcher method
  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $urlString')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return _buildResponsiveLayout(context, constraints);
      },
    );
  }

  Widget _buildResponsiveLayout(BuildContext context, BoxConstraints constraints) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine if we're in mobile or desktop view
    final isMobile = constraints.maxWidth < 600 || kIsWeb;
    final effectiveWidth = isMobile ? screenWidth : 500.0;
    final effectiveHeight = isMobile ? screenHeight : screenHeight * 0.9;

    return Scaffold(
      body: Container(
        height: effectiveHeight,
        width: effectiveWidth,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF6366F1), // Indigo
              const Color(0xFF8B5CF6), // Purple
              const Color(0xFFDB2777), // Pink
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Decorative background circles
              Positioned(
                top: -100,
                right: -100,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Positioned(
                bottom: -50,
                left: -50,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: effectiveWidth * 0.05,
                      vertical: effectiveHeight * 0.02,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: effectiveHeight * 0.05),
                        Hero(
                          tag: 'app_logo',
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              "assets/splash_screen/app_logo.png",
                              width: effectiveWidth * 0.6,
                              height: effectiveHeight * 0.15,
                            ),
                          ),
                        ),
                        SizedBox(height: effectiveHeight * 0.04),
                        Text(
                          "Welcome to NaviGuard!",
                          style: TextStyle(
                            fontSize: effectiveWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: effectiveHeight * 0.02),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: effectiveWidth * 0.05,
                            vertical: effectiveHeight * 0.015,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "Do you want to install our App?",
                            style: TextStyle(
                              fontSize: effectiveWidth * 0.045,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: effectiveHeight * 0.04),
                        
                        // Install Button
                        Container(
                          width: effectiveWidth * 0.8,
                          height: effectiveHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: () => _launchUrl(
                              "https://drive.google.com/uc?export=download&id=1BoPR69qgVzy49JpfNM1iaoOOAnzkgVBy"
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF6366F1),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                            ),
                            child: Text(
                              "Install NaviGuard",
                              style: TextStyle(
                                fontSize: effectiveWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: effectiveHeight * 0.015),
                        Text(
                          "(Only For Android)",
                          style: TextStyle(
                            fontSize: effectiveWidth * 0.035,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        SizedBox(height: effectiveHeight * 0.02),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "Or",
                            style: TextStyle(
                              fontSize: effectiveWidth * 0.045,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: effectiveHeight * 0.02),
                        
                        // Website Button
                        Container(
                          width: effectiveWidth * 0.8,
                          height: effectiveHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: () => _launchUrl(
                              "https://safe-gaurd.github.io/NaviGuard/"
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                            ),
                            child: Text(
                              "Visit our Website",
                              style: TextStyle(
                                fontSize: effectiveWidth * 0.04,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: effectiveHeight * 0.03),
                        Lottie.asset(
                          'assets/splash_screen/splashscreen_lottie.json',
                          width: effectiveWidth * 0.8,
                          height: effectiveHeight * 0.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}