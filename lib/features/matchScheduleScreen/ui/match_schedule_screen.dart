import 'package:blank_flutter_project/features/matchScheduleScreen/ui/widgets/league_header.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/ui/widgets/match_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_models.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_services.dart';

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
    "MLS",
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
    Map<String, List<Match>> leagueMatches = {};
    Map<String, List<Match>> premierLeagueByCountry = {};

    for (var match in filteredMatches) {
      if (match.league.name == "Premier League") {
        premierLeagueByCountry
            .putIfAbsent(match.league.country, () => [])
            .add(match);
      } else {
        leagueMatches.putIfAbsent(match.league.name, () => []).add(match);
      }
    }

    List<String> sortedLeagues = famousLeagues
        .where((league) => leagueMatches.containsKey(league))
        .toList();
    List<String> otherLeagues = leagueMatches.keys
        .where((league) => !famousLeagues.contains(league))
        .toList()
      ..sort();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Match Schedule"),
        actions: [
          DropdownButton<String>(
            value: selectedLeague,
            items: famousLeagues.map((String league) {
              return DropdownMenuItem<String>(
                value: league,
                child: Text(league),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                filterMatches(newValue);
              }
            },
          ),
        ],
      ),
      body: Container(
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
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  // Display Premier League matches grouped by country
                  ...premierLeagueByCountry.entries.map((entry) {
                    String country = entry.key;
                    List<Match> matches = entry.value;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildPremierLeagueHeader(
                            country), // Premier League Section Header
                        Column(
                          children: matches.map((match) {
                            return buildMatchCard(match);
                          }).toList(),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  }),

                  // Display other leagues normally
                  ...sortedLeagues.map((league) {
                    return buildLeagueSection(league, leagueMatches[league]!);
                  }),
                  ...otherLeagues.map((league) {
                    return buildLeagueSection(league, leagueMatches[league]!);
                  }),
                ],
              ),
      ),
    );
  }
}
