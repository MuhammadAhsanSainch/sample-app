class IslamicEvents {
  IslamicEvents({
    required this.summary,
    required this.start,
    required this.end,
    required this.status,
    required this.htmlLink,
    required this.description,
  });

  final String? summary;
  final End? start;
  final End? end;
  final String? status;
  final String? htmlLink;
  final String? description;

  factory IslamicEvents.fromJson(Map<String, dynamic> json) {
    return IslamicEvents(
      summary: json["summary"],
      start: json["start"] == null ? null : End.fromJson(json["start"]),
      end: json["end"] == null ? null : End.fromJson(json["end"]),
      status: json["status"],
      htmlLink: json["htmlLink"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
    "summary": summary,
    "start": start?.toJson(),
    "end": end?.toJson(),
    "status": status,
    "htmlLink": htmlLink,
    "description": description,
  };
}

class End {
  End({required this.date});

  final DateTime? date;

  factory End.fromJson(Map<String, dynamic> json) {
    return End(date: DateTime.tryParse(json["date"] ?? ""));
  }

  Map<String, dynamic> toJson() => {"date": date?.toIso8601String()};
}
