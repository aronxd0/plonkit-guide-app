import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Sötétkékes árnyalat, nem full fekete
    const backgroundColor = Color(0xFF0D1321);
    const surfaceColor = Color(0xFF1B2436);
    const accentColor = Color(0xFF5CA4FF);

    return MaterialApp(
      title: 'Continents App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: accentColor,
        colorScheme: const ColorScheme.dark(
          primary: accentColor,
          surface: surfaceColor,
        ),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        textTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        primaryTextTheme: GoogleFonts.montserratTextTheme(ThemeData.dark().primaryTextTheme),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List<Map<String, String>> continents = [
    {'name': 'Africa', 'emoji': '🌍'},
    {'name': 'Antarctica', 'emoji': '🧊'},
    {'name': 'Asia', 'emoji': '🌏'},
    {'name': 'Australia', 'emoji': '🏝️'},
    {'name': 'South America', 'emoji': '🌎'},
    {'name': 'North America', 'emoji': '🗽'},
    {'name': 'Europe', 'emoji': '🏰'},
  ];

  static const Map<String, List<String>> continentCountries = {
    'Africa': [
      'Nigeria',
      'South Africa',
      'Egypt',
      'Kenya',
      'Morocco',
    ],
    'Antarctica': [
      'Research Stations',
      'No Permanent Population',
    ],
    'Asia': [
      'China',
      'India',
      'Japan',
      'South Korea',
      'Thailand',
    ],
    'Australia': [
      'Australia',
      'New Zealand',
      'Fiji',
      'Papua New Guinea',
    ],
    'South America': [
      'Brazil',
      'Argentina',
      'Chile',
      'Peru',
      'Colombia',
      'Ecuador',
    ],
    'North America': [
      'United States',
      'Canada',
      'Mexico',
      'Costa Rica',
    ],
    'Europe': [
      'United Kingdom',
      'Germany',
      'France',
      'Italy',
      'Spain',
    ],
  };

  static const Map<String, String> continentDescriptions = {
    'Africa': 'Explore vibrant cultures, diverse wildlife, and the geography that shapes this vast continent.',
    'Antarctica': 'Discover the icebound wilderness, scientific outposts, and the raw beauty of the southernmost continent.',
    'Asia': 'Journey through ancient history, modern megacities, and the world’s most varied landscapes.',
    'Australia': 'Experience wide-open deserts, tropical coasts, and the unique wildlife of Australia and Oceania.',
    'South America': 'Explore rainforests, high mountains, and the cultural richness of this colourful continent.',
    'North America': 'Discover varied climates, iconic cities, and an immense range of natural wonders.',
    'Europe': 'Explore historic cities, classic architecture, and the cultural mosaic of the European continent.',
  };

  static const String description =
      'Learn country-specific metas, recognize key visual clues, and sharpen your GeoGuessr skills wherever you are. This mobile app brings the essential knowledge of Plonk It into a fast, simple, and mobile-friendly experience — perfect for learning on the go and dominating your next game.!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D1321),
                Color(0xFF10182B),
              ],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nagy cím
                      const Text(
                        'Plonk It Guide App',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text(
                        'Master GeoGuessr like a pro. 🌍',
                        style: TextStyle(
                          fontSize: 20,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 16),
                      // Bekezdés szerű szöveg
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.white.withOpacity(0.65),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'BROWSE BY CONTINENT',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final continent = continents[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: ContinentCard(
                          name: continent['name']!,
                          emoji: continent['emoji']!,
                          onTap: () {
                            final countries = continentCountries[continent['name']!] ?? [];
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CountriesPage(
                                  continent: continent['name']!,
                                  description: continentDescriptions[continent['name']!] ?? description,
                                  countries: countries,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    childCount: continents.length,
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

class ContinentCard extends StatelessWidget {
  final String name;
  final String emoji;
  final VoidCallback onTap;

  const ContinentCard({
    super.key,
    required this.name,
    required this.emoji,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFF1B2436),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.06),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF5CA4FF).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CountriesPage extends StatelessWidget {
  final String continent;
  final String description;
  final List<String> countries;

  const CountriesPage({
    super.key,
    required this.continent,
    required this.description,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0D1321),
                Color(0xFF10182B),
              ],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              continent,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: Colors.white.withOpacity(0.65),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Text(
                        'COUNTRIES IN $continent',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                          color: Colors.white.withOpacity(0.4),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1B2436),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.06),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            countries[index],
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                    childCount: countries.length,
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
