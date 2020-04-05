class Covid19 {
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int active;

  Covid19(
      {this.country,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active});

  factory Covid19.fromJson(Map<String, dynamic> json) {
    return Covid19(
      country: json['country'],
      cases: json['cases'],
      todayCases: json['todayCases'],
      deaths: json['deaths'],
      todayDeaths: json['todayDeaths'],
      recovered: json['recovered'],
      active: json['active'],
    );
  }
}
