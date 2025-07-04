class NotificationsModel {
  NotificationsModel({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
  });

  final List<NotificationModel> data;
  final num? total;
  final num? page;
  final num? limit;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      data:
          json["data"] == null ? [] : List<NotificationModel>.from(json["data"]!.map((x) => NotificationModel.fromJson(x))),
      total: json["total"],
      page: json["page"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
    "data": data.map((x) => x?.toJson()).toList(),
    "total": total,
    "page": page,
    "limit": limit,
  };
}

class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.createdAt,
  });

  final String? id;
  final String? title;
  final String? body;
  final String? type;
  final DateTime? createdAt;

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      type: json["type"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "body": body,
    "type": type,
    "createdAt": createdAt?.toIso8601String(),
  };
}
