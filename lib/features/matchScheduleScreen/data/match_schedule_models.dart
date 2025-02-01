class Fixture {
  final int id;
  final String date;
  final Status status;

  Fixture({required this.id, required this.date, required this.status});

  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      date: json['date'],
      status: Status.fromJson(json['status']),
      id: json['id'],
    );
  }
}

class Status {
  final String long;

  Status({required this.long});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long'],
    );
  }
}

class League {
  final String name;
  final String logo;
  final String country;

  League({
    required this.name,
    required this.country,
    required this.logo,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      name: json['name'],
      logo: json['logo'],
      country: json['country'],
    );
  }
}

class Team {
  final String name;
  final String logo;

  Team({required this.name, required this.logo});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      name: json['name'],
      logo: json['logo'],
    );
  }
}

class Match {
  final Fixture fixture;
  final League league;
  final Team homeTeam;
  final Team awayTeam;
  final int homeGoals;
  final int awayGoals;

  Match({
    required this.fixture,
    required this.league,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeGoals,
    required this.awayGoals,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      fixture: Fixture.fromJson(json['fixture']),
      league: League.fromJson(json['league']),
      homeTeam: Team.fromJson(json['teams']['home']),
      awayTeam: Team.fromJson(json['teams']['away']),
      homeGoals: json['goals']['home'] ?? 0,
      awayGoals: json['goals']['away'] ?? 0,
    );
  }
}
