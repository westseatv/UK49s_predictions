import 'package:flutter/foundation.dart';

class Saved {
  List<dynamic> numbers;
  String date;
  int? key;
  Saved({
    required this.numbers,
    required this.date,
    this.key,
  });

  Saved copyWith({
    List<dynamic>? numbers,
    String? date,
    int? key,
  }) {
    return Saved(
      numbers: numbers ?? this.numbers,
      date: date ?? this.date,
      key: key ?? this.key,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numbers': numbers,
      'date': date,
      'key': key,
    };
  }

  factory Saved.fromMap(Map<String, dynamic> map) {
    return Saved(
      numbers: map['numbers'] as List<dynamic>,
      date: map['date'] as String,
      key: map['key'] != null ? map['key'] as int : null,
    );
  }

  @override
  String toString() => 'Saved(numbers: $numbers, date: $date, key: $key)';

  @override
  bool operator ==(covariant Saved other) {
    if (identical(this, other)) return true;

    return listEquals(other.numbers, numbers) &&
        other.date == date &&
        other.key == key;
  }

  @override
  int get hashCode => numbers.hashCode ^ date.hashCode ^ key.hashCode;
}
