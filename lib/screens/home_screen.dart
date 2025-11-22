import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ocr_screen.dart';
import 'transliteration_screen.dart';
import 'translation_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text(
              'Bali Lontar',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            ),
            centerTitle: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  // TODO: Settings
                },
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildListDelegate([
                _buildFeatureCard(
                  context,
                  title: 'Scan Lontar',
                  icon: Icons.camera_alt_outlined,
                  color: theme.colorScheme.primary,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const OCRScreen()),
                  ),
                ),
                _buildFeatureCard(
                  context,
                  title: 'Transliterate',
                  icon: Icons.translate,
                  color: theme.colorScheme.secondary,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TransliterationScreen()),
                  ),
                ),
                _buildFeatureCard(
                  context,
                  title: 'Dictionary',
                  icon: Icons.menu_book_outlined,
                  color: theme.colorScheme.tertiary,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TranslationScreen()),
                  ),
                ),
                _buildFeatureCard(
                  context,
                  title: 'History',
                  icon: Icons.history,
                  color: Colors.grey[700]!,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistoryScreen()),
                  ),
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  // Placeholder for recent activity
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.history),
                      title: const Text('No recent activity'),
                      subtitle: const Text('Start by scanning or translating'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.8),
                color,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
