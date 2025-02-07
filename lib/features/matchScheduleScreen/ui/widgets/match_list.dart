import 'package:blank_flutter_project/core/widgets/loading_shimmer.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_models.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/ui/widgets/league_header.dart';
import 'package:flutter/material.dart';

class MatchList extends StatelessWidget {
  const MatchList({
    super.key,
    required this.isLoading,
    required this.sortedLeagues,
    required this.leaguesByCountry,
    required this.otherLeagues,
  });

  final bool isLoading;
  final List<String> sortedLeagues;
  final Map<String, Map<String, List<Match>>> leaguesByCountry;
  final List<String> otherLeagues;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final containerColor = isDarkMode ? Colors.black : Colors.white;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: containerColor, // Set color based on theme
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isLoading
            ? ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: 6, // Show a few loading placeholders
                itemBuilder: (context, index) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: LoadingShimmer());
                },
              )
            : ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  ...sortedLeagues.map((league) {
                    return buildLeagueSection(
                        leaguesByCountry[league]!.cast<String, List<Match>>());
                  }),
                  ...otherLeagues.map((league) {
                    return buildLeagueSection(leaguesByCountry[league]!);
                  }),
                ],
              ),
      ),
    );
  }
}
