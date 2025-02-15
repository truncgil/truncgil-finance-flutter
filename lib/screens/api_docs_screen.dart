import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiDocsScreen extends StatelessWidget {
  const ApiDocsScreen({super.key});

  Widget _buildApiButton({
    required String title,
    required IconData icon,
    required Color color,
    required String url,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => launchUrl(Uri.parse(url)),
          borderRadius: BorderRadius.circular(12),
          child: Ink(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: color,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: color,
                  size: 32,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Detaylı bilgi için tıklayın',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF004225),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'API Dokümanları',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              const Color(0xFF00FF66).withOpacity(0.3),
              const Color(0xFF004225).withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildApiButton(
              title: 'API Documentation',
              icon: Icons.description_outlined,
              color: const Color(0xFF00FF66),
              url: 'https://finance.truncgil.com/docs',
            ),
            _buildApiButton(
              title: 'Postman Collection',
              icon: Icons.api,
              color: Colors.deepOrange,
              url: 'https://www.postman.com/truncgil/truncgil-finance-api-v5',
            ),
            _buildApiButton(
              title: 'SwaggerHub Collection',
              icon: Icons.code,
              color: Colors.blue,
              url:
                  'https://app.swaggerhub.com/apis/truncgiltechnology/truncgil-finance/5.0.0',
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Truncgil Finance v5.0.3',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
