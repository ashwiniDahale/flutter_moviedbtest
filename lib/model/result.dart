import 'Movie.dart';
import 'dates.dart';

class Result {

  List<Movie> results;
  int page;
  int total_results;
  Dates dates;
  int total_pages;

	Result.fromJsonMap(Map<String, dynamic> map): 
		results = List<Movie>.from(map["results"].map((it) => Movie.fromJsonMap(it))),
		page = map["page"],
		total_results = map["total_results"],
		dates = Dates.fromJsonMap(map["dates"]),
		total_pages = map["total_pages"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['results'] = results != null ? 
			this.results.map((v) => v.toJson()).toList()
			: null;
		data['page'] = page;
		data['total_results'] = total_results;
		data['dates'] = dates == null ? null : dates.toJson();
		data['total_pages'] = total_pages;
		return data;
	}
}
