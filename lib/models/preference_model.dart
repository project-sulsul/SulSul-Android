class PreferenceRequest {
  final String type;
  final String subtype;
  final String name;

  PreferenceRequest({
    required this.type,
    required this.subtype,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "subtype": subtype,
        "name": name,
      };

  factory PreferenceRequest.fromJson(Map<String, String> json) =>
      PreferenceRequest(
        type: json['type'] ?? '',
        subtype: json['subtype'] ?? '',
        name: json['name'] ?? '',
      );
}

class PreferenceResponse {
  final int id;
  final String type;
  final String subtype;
  final String name;
  final String description;
  final bool isSelected;
  final String? image;

  PreferenceResponse({
    required this.id,
    required this.type,
    required this.subtype,
    required this.name,
    required this.description,
    required this.isSelected,
    this.image,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "subtype": subtype,
        "name": name,
        "image": image,
        "description": description,
        "isSelected": isSelected,
      };

  factory PreferenceResponse.fromJson(Map<String, dynamic> json) =>
      PreferenceResponse(
        id: json['id'],
        type: json['type'],
        subtype: json['subtype'],
        name: json['name'],
        // image: json['image'],
        image:
            'https://company.lottechilsung.co.kr/common/images/product_view0201_bh3.jpg',
        description: json['description'],
        isSelected: json['isSelected'] ?? false,
      );
}
