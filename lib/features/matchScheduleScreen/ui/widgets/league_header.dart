// Helper function to build a league section (grouped by country)
import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_models.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/ui/widgets/match_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget buildLeagueSection(Map<String, List<Match>> countries) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Ensure there's at least one match in the list to get the league
      if (countries.isNotEmpty)
        buildLeagueHeader(countries.values.first.first.league),

      // Display matches for each country in the league
      ...countries.entries.map((countryEntry) {
        String country = countryEntry.key;
        List<Match> matches = countryEntry.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCountryHeader(
                country, matches.first.league.flag), // Pass the flag here
            Column(
              children: matches.map((match) {
                return buildMatchCard(match);
              }).toList(),
            ),
            const SizedBox(height: 10),
          ],
        );
      }),
    ],
  );
}

// Helper function to build a country header with a flag (SVG)
Widget buildCountryHeader(String country, String flagUrl) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      children: [
        // Display country flag (SVG)
        SvgPicture.network(
          flagUrl,
          width: 20,
          height: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            country,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    ),
  );
}

// Helper function to build the league header
Widget buildLeagueHeader(League league) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      children: [
        // Use Image.network for logo (image format)
        Image.network(
          league.logo,
          width: 40,
          height: 40,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_not_supported,
              size: 40,
              color: Colors.grey,
            );
          },
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                league.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                league.country,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
