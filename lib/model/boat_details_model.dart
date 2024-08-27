class BoatDetailsModel {
  BoatDetailsModel({
    required this.name,
    required this.fromTime,
    required this.toTime,
    required this.price,
    required this.description,
    required this.image,
    required this.amenities,
    required this.safetyFeatures,
    required this.availableSeats,
    required this.totalSeats,
  });

  final String? name;
  final String? fromTime;
  final String? toTime;
  final int? price;
  final String? description;
  final String? image;
  final List<String> amenities;
  final List<String> safetyFeatures;
  final int? availableSeats;
  final int? totalSeats;

  BoatDetailsModel copyWith({
    String? name,
    String? fromTime,
    String? toTime,
    int? price,
    String? description,
    String? image,
    List<String>? amenities,
    List<String>? safetyFeatures,
    int? availableSeats,
    int? totalSeats,
  }) {
    return BoatDetailsModel(
      name: name ?? this.name,
      fromTime: fromTime ?? this.fromTime,
      toTime: toTime ?? this.toTime,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
      amenities: amenities ?? this.amenities,
      safetyFeatures: safetyFeatures ?? this.safetyFeatures,
      availableSeats: availableSeats ?? this.availableSeats,
      totalSeats: totalSeats ?? this.totalSeats,
    );
  }

  factory BoatDetailsModel.fromJson(Map<String, dynamic> json) {
    return BoatDetailsModel(
      name: json["name"],
      fromTime: json["fromTime"],
      toTime: json["toTime"],
      price: json["price"],
      description: json["description"],
      image: json["image"],
      amenities: json["amenities"] == null
          ? []
          : List<String>.from(json["amenities"]!.map((x) => x)),
      safetyFeatures: json["safetyFeatures"] == null
          ? []
          : List<String>.from(json["safetyFeatures"]!.map((x) => x)),
      availableSeats: json["availableSeats"],
      totalSeats: json["totalSeats"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "fromTime": fromTime,
        "toTime": toTime,
        "price": price,
        "description": description,
        "image": image,
        "amenities": amenities.map((x) => x).toList(),
        "safetyFeatures": safetyFeatures.map((x) => x).toList(),
        "availableSeats": availableSeats,
        "totalSeats": totalSeats,
      };

  @override
  String toString() {
    return "$name, $fromTime, $toTime, $price, $description, $image, $amenities, $safetyFeatures, $availableSeats, $totalSeats, ";
  }
}
