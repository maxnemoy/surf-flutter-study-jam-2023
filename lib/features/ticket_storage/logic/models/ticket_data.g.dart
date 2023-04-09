// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketData _$TicketDataFromJson(Map<String, dynamic> json) => TicketData(
      id: json['id'] as int?,
      type: $enumDecode(_$TicketTypeEnumMap, json['type']),
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      localPath: json['localPath'] as String?,
      externalPath: json['externalPath'] as String,
    );

Map<String, dynamic> _$TicketDataToJson(TicketData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$TicketTypeEnumMap[instance.type]!,
      'date': instance.date?.toIso8601String(),
      'localPath': instance.localPath,
      'externalPath': instance.externalPath,
    };

const _$TicketTypeEnumMap = {
  TicketType.airplane: 'airplane',
  TicketType.train: 'train',
  TicketType.bus: 'bus',
};
