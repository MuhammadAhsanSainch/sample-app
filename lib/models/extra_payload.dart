

class ExtraPayload {
  ExtraPayload({required this.notificationType, required this.refId, required this.message});

  final String? notificationType;
  final String? refId;
  final String? message;

  factory ExtraPayload.fromJson(Map<String, dynamic> json) {
    return ExtraPayload(
      notificationType: json["notification_type"],
      refId: json["type"],

      message: json["message"],
    );
  }
}
