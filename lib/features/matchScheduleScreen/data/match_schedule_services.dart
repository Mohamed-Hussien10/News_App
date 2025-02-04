import 'package:blank_flutter_project/features/matchScheduleScreen/data/match_schedule_models.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MatchScheduleServices {
  Dio dio;

  MatchScheduleServices(this.dio);

  Future<List<Match>> fetchMatches() async {
    try {
      final String apiKey = dotenv.env['API_KEY_MATCHS'] ?? '';

      // Get the current date in 'yyyy-MM-dd' format
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

      Response response = await dio.get(
        'https://v3.football.api-sports.io/fixtures?date=$currentDate',
        options: Options(
          headers: {
            'x-rapidapi-key': apiKey,
            'x-rapidapi-host': 'v3.football.api-sports.io',
          },
        ),
      );

      List<dynamic> responseData = response.data['response'];
      List<Match> matchList =
          responseData.map((json) => Match.fromJson(json)).toList();

      return matchList;
    } catch (e) {
      return [];
    }
  }
}
