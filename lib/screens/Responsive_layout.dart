import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

// Responsive Breakpoints
class ResponsiveBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1100;
  static const double desktop = 1440;
}

// Responsive Layout Utility
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check for different screen sizes and platforms
        if (kIsWeb) {
          return desktop;
        } else if (Platform.isAndroid || Platform.isIOS) {
          // Mobile specific handling
          return constraints.maxWidth < ResponsiveBreakpoints.mobile 
              ? mobile 
              : tablet;
        } else {
          // Desktop platforms
          return constraints.maxWidth < ResponsiveBreakpoints.desktop 
              ? tablet 
              : desktop;
        }
      },
    );
  }
}

// Device Information Utility
class DeviceInfoService {
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    
    try {
      if (kIsWeb) {
        WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        return {
          'platform': 'Web',
          'browser': webInfo.browserName.toString(),
          'userAgent': webInfo.userAgent,
        };
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidDeviceInfo;
        return {
          'platform': 'Android',
          'model': androidInfo.model,
          'version': androidInfo.version.release,
          'isPhysicalDevice': androidInfo.isPhysicalDevice,
        };
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosDeviceInfo;
        return {
          'platform': 'iOS',
          'model': iosInfo.model,
          'version': iosInfo.systemVersion,
          'name': iosInfo.name,
        };
      } else if (Platform.isWindows) {
        WindowsDeviceInfo windowsInfo = await deviceInfo.windowsDeviceInfo;
        return {
          'platform': 'Windows',
          'computerName': windowsInfo.computerName,
          'numberOfCores': windowsInfo.numberOfCores,
        };
      } else if (Platform.isMacOS) {
        MacOsDeviceInfo macInfo = await deviceInfo.macOsDeviceInfo;
        return {
          'platform': 'MacOS',
          'model': macInfo.model,
          'version': macInfo.osRelease,
        };
      } else if (Platform.isLinux) {
        LinuxDeviceInfo linuxInfo = await deviceInfo.linuxDeviceInfo;
        return {
          'platform': 'Linux',
          'version': linuxInfo.version,
          'machineId': linuxInfo.machineId,
        };
      }
    } catch (e) {
      print('Error getting device info: $e');
    }
    
    return {'platform': 'Unknown'};
  }

  // Platform-specific handling
  static bool isMobile() {
    return Platform.isAndroid || Platform.isIOS;
  }

  static bool isDesktop() {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }
}

// Orientation-Aware Layout
class OrientationLayout extends StatelessWidget {
  final Widget portrait;
  final Widget? landscape;

  const OrientationLayout({
    Key? key,
    required this.portrait,
    this.landscape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? portrait
            : landscape ?? portrait;
      },
    );
  }
}

// Responsive Screen Example
class ResponsiveScreen extends StatefulWidget {
  const ResponsiveScreen({Key? key}) : super(key: key);

  @override
  _ResponsiveScreenState createState() => _ResponsiveScreenState();
}

class _ResponsiveScreenState extends State<ResponsiveScreen> {
  Map<String, dynamic> _deviceInfo = {};

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    final info = await DeviceInfoService.getDeviceInfo();
    setState(() {
      _deviceInfo = info;
    });
  }

  // URL Launcher with Error Handling
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
    return ResponsiveLayout(
      mobile: _buildMobileLayout(context),
      tablet: _buildTabletLayout(context),
      desktop: _buildDesktopLayout(context),
    );
  }

  // Mobile Layout
  Widget _buildMobileLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mobile View',
          style: TextStyle(fontSize: screenWidth * 0.05),
        ),
      ),
      body: OrientationLayout(
        portrait: SingleChildScrollView(
          child: Column(
            children: [
              // Device Info Card
              _buildDeviceInfoCard(screenWidth),
              
              // Responsive Content
              Container(
                width: screenWidth * 0.9,
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Mobile Content',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Optimized for small screens with vertical layout',
                      style: TextStyle(fontSize: screenWidth * 0.04),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        landscape: Row(
          children: [
            // Device Info Side Panel
            SizedBox(
              width: screenWidth * 0.4,
              child: _buildDeviceInfoCard(screenWidth),
            ),
            // Main Content
            SizedBox(
              width: screenWidth * 0.6,
              child: Center(
                child: Text(
                  'Landscape Mobile View',
                  style: TextStyle(fontSize: screenWidth * 0.04),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Tablet Layout
  Widget _buildTabletLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tablet View',
          style: TextStyle(fontSize: screenWidth * 0.04),
        ),
      ),
      body: Row(
        children: [
          // Side Panel
          Container(
            width: screenWidth * 0.3,
            color: Colors.blue.shade50,
            child: _buildDeviceInfoCard(screenWidth),
          ),
          // Main Content
          Container(
            width: screenWidth * 0.7,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tablet Optimized Layout',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _launchUrl('https://example.com'),
                  child: const Text('Open Website'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Desktop Layout
  Widget _buildDesktopLayout(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          // Navigation Sidebar
          Container(
            width: screenWidth * 0.2,
            color: Colors.blue.shade100,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Navigation',
                    style: TextStyle(
                      fontSize: screenWidth * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildDeviceInfoCard(screenWidth),
              ],
            ),
          ),
          // Main Content Area
          Container(
            width: screenWidth * 0.8,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Desktop Expanded View',
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _launchUrl('https://example.com'),
                  child: const Text('Open Website'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Device Info Card
  Widget _buildDeviceInfoCard(double screenWidth) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Information',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ..._deviceInfo.entries.map((entry) => Text(
                  '${entry.key}: ${entry.value}',
                  style: TextStyle(fontSize: screenWidth * 0.035),
                )),
          ],
        ),
      ),
    );
  }
}

// Main App
void main() {
  runApp(MaterialApp(
    home: ResponsiveScreen(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}