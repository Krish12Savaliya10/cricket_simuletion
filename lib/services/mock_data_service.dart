class MockDataService {
  static List<Map<String, dynamic>> teams = [
    {'name': 'India', 'captain': 'Rohit Sharma'},
    {'name': 'Australia', 'captain': 'Pat Cummins'},
    {'name': 'England', 'captain': 'Jos Buttler'},
    {'name': 'Pakistan', 'captain': 'Babar Azam'},
  ];

  static List<Map<String, dynamic>> players = [
    {'name': 'Virat Kohli', 'role': 'Batsman', 'team': 'India'},
    {'name': 'Jasprit Bumrah', 'role': 'Bowler', 'team': 'India'},
    {'name': 'Steve Smith', 'role': 'Batsman', 'team': 'Australia'},
    {'name': 'Mitchell Starc', 'role': 'Bowler', 'team': 'Australia'},
  ];

  static List<Map<String, dynamic>> matches = [
    {
      'title': 'India vs Australia',
      'venue': 'Narendra Modi Stadium',
      'date': '20 Mar 2026',
      'status': 'Live',
      'score': '156/3 (17.2)'
    },
    {
      'title': 'England vs Pakistan',
      'venue': 'Lords',
      'date': '21 Mar 2026',
      'status': 'Upcoming',
      'score': '-'
    },
  ];

  static List<Map<String, dynamic>> tournaments = [
    {'name': 'World Cup 2026', 'teams': 10, 'format': 'ODI'},
    {'name': 'Asia Cup 2026', 'teams': 6, 'format': 'T20'},
  ];

  static List<Map<String, dynamic>> series = [
    {'name': 'India Tour of Australia', 'matches': 5, 'type': 'Test'},
    {'name': 'Pakistan Tour of England', 'matches': 3, 'type': 'ODI'},
  ];

  static List<Map<String, dynamic>> audienceCards = [
    {'title': 'Live Matches', 'value': '03'},
    {'title': 'Total Audience', 'value': '48.2K'},
    {'title': 'Completed Matches', 'value': '12'},
    {'title': 'Upcoming Matches', 'value': '07'},
  ];
}