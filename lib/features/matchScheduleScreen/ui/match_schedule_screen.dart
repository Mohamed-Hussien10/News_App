import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_services.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/ui/widgets/dropdown.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/ui/widgets/match_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_models.dart';

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
          MatchFilterDropdown(
            selectedLeague: selectedLeague,
            famousLeagues: famousLeagues,
            onLeagueSelected: filterMatches,
          ),

          // Displaying the list of matches
          MatchList(
            isLoading: isLoading,
            sortedLeagues: sortedLeagues,
            leaguesByCountry: leaguesByCountry,
            otherLeagues: otherLeagues,
          ),
        ],
      ),
    );
  }
}
