import 'package:json_annotation/json_annotation.dart';

import 'ticket_types.dart';

part 'ticket_data.g.dart';

@JsonSerializable()
class TicketData {
  final int? id;
  final TicketType type;
  final DateTime createAt;
  final DateTime? date;
  final String? localPath;
  final String externalPath;

  TicketData(
      {this.id,
      required this.type,
      DateTime? created,
      this.date,
      this.localPath,
      required this.externalPath})
      : createAt = created ?? DateTime.now();

  factory TicketData.fromJson(Map<String, dynamic> json) =>
      _$TicketDataFromJson(json);

  Map<String, dynamic> toJson() => _$TicketDataToJson(this);

  TicketData copyWith({
    int? id,
    TicketType? type,
    DateTime? createAt,
    DateTime? date,
    String? localPath,
    String? externalPath,
  }) =>
      TicketData(
          id: id ?? this.id,
          type: type ?? this.type,
          created: createAt ?? this.createAt,
          date: date ?? this.date,
          externalPath: externalPath ?? this.externalPath,
          localPath: localPath ?? this.localPath);
}
