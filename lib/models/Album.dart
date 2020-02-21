
class Album {

  int userId;
  int id;
  String title;

	Album.fromJsonMap(Map<String, dynamic> map): 
		userId = map["userId"],
		id = map["id"],
		title = map["title"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userId'] = userId;
		data['id'] = id;
		data['title'] = title;
		return data;
	}
}
