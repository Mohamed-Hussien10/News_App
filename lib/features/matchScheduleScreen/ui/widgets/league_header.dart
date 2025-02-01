// Helper function to build a Premier League section header
  import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_models.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/ui/widgets/match_card.dart';
import 'package:flutter/material.dart';

Widget buildPremierLeagueHeader(String country) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          const Icon(Icons.sports_soccer, size: 30, color: Colors.blueAccent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "Premier League - $country",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
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

// Helper function to build a league section
  Widget buildLeagueSection(String league, List<Match> matches) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildLeagueHeader(matches.first.league),
        Column(
          children: matches.map((match) {
            return buildMatchCard(match);
          }).toList(),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget buildLeagueHeader(League league) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Image.network(
            league.logo,
            width: 40,
            height: 40,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.image_not_supported,
              size: 40,
              color: Colors.grey,
            ),
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
                  overflow:
                      TextOverflow.ellipsis, // Prevent overflow with ellipsis
                  maxLines:
                      1, // Ensure the text doesn't overflow and takes one line
                ),
                Text(
                  league.country,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                  overflow:
                      TextOverflow.ellipsis, // Prevent overflow with ellipsis
                  maxLines:
                      1, // Ensure the text doesn't overflow and takes one line
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  
