// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    note: json['note'] as String,
    createdAt: json['created_at'] as String,
    id: json['id'] as String,
    reportId: json['report_id'] as String,
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'note': instance.note,
      'created_at': instance.createdAt,
      'id': instance.id,
      'report_id': instance.reportId,
    };
