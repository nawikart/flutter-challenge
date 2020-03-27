class MovieModel {
  int id;
  String title;
  String backdrop_path;
  String poster_path;
  String overview;
  double popularity;
  List<dynamic> genre_ids;
  List<dynamic> genres;
  String release_date;
  int vote_count;
  String vote_average;
  List<dynamic> production_companies;
  int runtime;
  int revenue;
  List<dynamic> spoken_languages;

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    backdrop_path = (json['backdrop_path'] != null) ? 'https://image.tmdb.org/t/p/original' + json['poster_path'] : '';
    poster_path = 'https://image.tmdb.org/t/p/original' + json['poster_path'];
    overview = json['overview'];
    popularity = json['popularity'];
    genre_ids = json['genre_ids'];
    genres = json['genres'];
    release_date = json['release_date'];
    vote_count = json['vote_count'] ?? 0;
    vote_average = json['vote_average'].toString();
    production_companies = json['production_companies'];
    runtime = json['runtime'] ?? 0;
    revenue = json['revenue'] ?? 0;
    spoken_languages = json['spoken_languages'];
  }
}
