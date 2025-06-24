class BannersModel {
    BannersModel({
        required this.banners,
    });

    final List<String> banners;

    factory BannersModel.fromJson(Map<String, dynamic> json){ 
        return BannersModel(
            banners: json["banners"] == null ? [] : List<String>.from(json["banners"]!.map((x) => x)),
        );
    }

    Map<String, dynamic> toJson() => {
        "banners": banners.map((x) => x).toList(),
    };

}
