import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_services.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/ui/widgets/league_header.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_models.dart';
import 'package:shimmer/shimmer.dart';

class MatchScheduleScreen extends StatefulWidget {
  const MatchScheduleScreen({super.key});

  @override
  _MatchScheduleScreenState createState() => _MatchScheduleScreenState();
}

class _MatchScheduleScreenState extends State<MatchScheduleScreen> {
  List<Match> matches = [];
  List<Match> filteredMatches = [];
  bool isLoading = true;
  String selectedLeague = "All";
  final MatchScheduleServices matchService = MatchScheduleServices(Dio());

  final List<String> famousLeagues = [
    "All",
    "UEFA Champions League",
    "UEFA Europa League",
    "Premier League",
    "La Liga",
    "Serie A",
    "Bundesliga",
    "Ligue 1",
    "Eredivisie",
    "Primeira Liga",
    "Pro League",
  ];

  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  Future<void> fetchMatches() async {
    try {
      List<Match> fetchedMatches = await matchService.fetchMatches();
      setState(() {
        matches = fetchedMatches;
        filteredMatches = fetchedMatches; // Initially, all matches are shown
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching matches: $e');
    }
  }

  void filterMatches(String league) {
    setState(() {
      selectedLeague = league;
      if (league == "All") {
        filteredMatches = matches; // Show all matches
      } else {
        filteredMatches = matches
            .where((match) => match.league.name == league)
            .toList(); // Filter matches by league
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Group matches by league and country
    Map<String, Map<String, List<Match>>> leaguesByCountry = {};

    for (var match in filteredMatches) {
      leaguesByCountry.putIfAbsent(match.league.name, () => {});
      leaguesByCountry[match.league.name]!
          .putIfAbsent(match.league.country, () => [])
          .add(match);
    }

    // Sorting leagues to display famous leagues first, then other leagues
    List<String> sortedLeagues = famousLeagues
        .where((league) => leaguesByCountry.containsKey(league))
        .toList();
    List<String> otherLeagues = leaguesByCountry.keys
        .where((league) => !famousLeagues.contains(league))
        .toList()
      ..sort();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(55.0), // Adjust the height if needed
        child: AppBar(
          title: const Text(
            "Match Schedule",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          elevation: 4,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown button at the top of the body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.deepPurpleAccent,
                  width: 2,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: selectedLeague,
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                underline: Container(), // Remove underline for cleaner look
                isExpanded: true,
                iconSize: 28,
                iconEnabledColor: Colors.deepPurpleAccent,
                items: famousLeagues.map((String league) {
                  return DropdownMenuItem<String>(
                    value: league,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        league,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    filterMatches(newValue);
                  }
                },
                dropdownColor: Colors
                    .white, // Keep the dropdown background white for contrast
              ),
            ),
          ),

          // Displaying the list of matches
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : ListView(
                      padding: const EdgeInsets.all(10),
                      children: [
                        ...sortedLeagues.map((league) {
                          return buildLeagueSection(leaguesByCountry[league]!);
                        }),
                        ...otherLeagues.map((league) {
                          return buildLeagueSection(leaguesByCountry[league]!);
                        }),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
