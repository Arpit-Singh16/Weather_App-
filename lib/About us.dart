import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Center(
              child: Icon(
                Icons.cloud_outlined,
                size: 80,
                color: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '🌦️ Welcome to WeatherWise!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'At WeatherWise, we believe that staying informed about the weather should be simple, accurate, and beautifully designed. '
                  'Whether you’re planning a trip, commuting to work, or just deciding what to wear, our goal is to help you make better decisions '
                  'based on real-time weather insights.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '🌍 Our Mission',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'To deliver reliable, real-time, and hyperlocal weather forecasts to everyone, everywhere. '
                  'We aim to make weather information more accessible, intuitive, and personalized.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '🔍 What We Offer',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              '• Live Weather Updates\n'
                  '• Accurate Forecasts (Hourly, Daily, Weekly)\n'
                  '• Interactive Maps & Radar\n'
                  '• Weather Alerts & Notifications\n'
                  '• Beautiful, Modern UI/UX',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '👥 Who We Are',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'We’re a small team of developers, designers, and weather enthusiasts passionate about combining technology and meteorology. '
                  'We’ve built WeatherWise to serve millions who rely on us daily.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              '🤝 Let’s Connect',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              '📧 Email: support@weatherwiseapp.com\n'
                  '🌐 Website: www.weatherwiseapp.com\n'
                  '📱 Follow us on social media for updates, tips, and fun weather facts!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                'Thank you for trusting WeatherWise!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
