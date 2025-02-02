import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Widget buildMatchCard(Match match) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 3,
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  match.league.round,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildTeamInfo(match.homeTeam, match.homeGoals),
              const Text(
                'VS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              buildTeamInfo(match.awayTeam, match.awayGoals),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildInfoRow(
                  Icons.calendar_today, formatTime(match.fixture.date)),
              buildInfoRow(Icons.info, match.fixture.status.long),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget buildTeamInfo(Team team, int score) {
  return Column(
    children: [
      Image.network(
        team.logo,
        width: 60,
        height: 60,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
      ),
      const SizedBox(height: 8),
      Text(team.name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      const SizedBox(height: 4),
      Text(score.toString(),
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent)),
    ],
  );
}

Widget buildInfoRow(IconData icon, String text) {
  return Row(
    children: [
      Icon(icon, size: 16, color: Colors.grey),
      const SizedBox(width: 6),
      Text(text, style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
    ],
  );
}

String formatTime(String dateString) {
  try {
    final dateTime = DateTime.parse(dateString).toLocal();
    return DateFormat('yyyy-MM-dd h:mm a').format(dateTime);
  } catch (e) {
    return 'Invalid date';
  }
}
