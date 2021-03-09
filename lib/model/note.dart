import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable(nullable: false)
class Note {
  String note;
  @JsonKey(name: 'created_at')
  String createdAt;
  String id;
  @JsonKey(name: 'report_id')
  String reportId;

  Note({
    @required this.note,
    @required this.createdAt,
    @required this.id,
    @required this.reportId,
  });

  Note.init();

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
