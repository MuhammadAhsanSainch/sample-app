///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class QuizHistoryModelDataQuiz {
/*
{
  "title": "Islamic Quiz"
}
*/

  String? title;

  QuizHistoryModelDataQuiz({
    this.title,
  });
  QuizHistoryModelDataQuiz.fromJson(Map<String, dynamic> json) {
    title = json['title']?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    return data;
  }
}

class QuizHistoryModelData {
/*
{
  "id": "b0804ea1-4315-4fa1-9c42-96de3bd89b38",
  "score": 3,
  "completedAt": "2025-06-18T13:31:02.527Z",
  "quiz": {
    "title": "Islamic Quiz"
  }
}
*/

  String? id;
  int? score;
  String? completedAt;
  QuizHistoryModelDataQuiz? quiz;

  QuizHistoryModelData({
    this.id,
    this.score,
    this.completedAt,
    this.quiz,
  });
  QuizHistoryModelData.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    score = json['score']?.toInt();
    completedAt = json['completedAt']?.toString();
    quiz = (json['quiz'] != null) ? QuizHistoryModelDataQuiz.fromJson(json['quiz']) : null;
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['score'] = score;
    data['completedAt'] = completedAt;
    if (quiz != null) {
      data['quiz'] = quiz!.toJson();
    }
    return data;
  }
}

class QuizHistoryModel {
/*
{
  "data": [
    {
      "id": "b0804ea1-4315-4fa1-9c42-96de3bd89b38",
      "score": 3,
      "completedAt": "2025-06-18T13:31:02.527Z",
      "quiz": {
        "title": "Islamic Quiz"
      }
    }
  ],
  "total": 1,
  "page": 1,
  "limit": 10
}
*/

  List<QuizHistoryModelData>? data;
  int? total;
  int? page;
  int? limit;

  QuizHistoryModel({
    this.data,
    this.total,
    this.page,
    this.limit,
  });
  QuizHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      final v = json['data'];
      final arr0 = <QuizHistoryModelData>[];
      v.forEach((v) {
        arr0.add(QuizHistoryModelData.fromJson(v));
      });
      data = arr0;
    }
    total = json['total']?.toInt();
    page = json['page']?.toInt();
    limit = json['limit']?.toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (this.data != null) {
      final v = this.data;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v.toJson());
      }
      data['data'] = arr0;
    }
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    return data;
  }
}
