class PlaceSearchModel {
	final String placeId;
	final String description;

  PlaceSearchModel({required this.placeId, required this.description});

	factory PlaceSearchModel.fromJson(Map<String, dynamic> json){
		return PlaceSearchModel(
			description: json['description'],
			placeId: json['place_id'],
		);
	}
}