import 'dart:convert';

class Data {
  Weight? weight;
  int? reps;
  Data({
    this.weight,
    this.reps,
  });


  Data copyWith({
    Weight? weight,
    int? reps,
  }) {
    return Data(
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'weight': weight?.toMap(),
      'reps': reps,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      weight: map['weight'] != null ? Weight.fromMap(map['weight']) : null,
      reps: map['reps']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) => Data.fromMap(json.decode(source));

  @override
  String toString() => 'Data(weight: $weight, reps: $reps)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Data &&
      other.weight == weight &&
      other.reps == reps;
  }

  @override
  int get hashCode => weight.hashCode ^ reps.hashCode;
}

class Weight {
  double? kg;
  double? lbs;

  Weight({
    this.kg,
    this.lbs,
  });


  Weight copyWith({
    double? kg,
    double? lbs,
  }) {
    return Weight(
      kg: kg ?? this.kg,
      lbs: lbs ?? this.lbs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'kg': kg,
      'lbs': lbs,
    };
  }

  factory Weight.fromMap(Map<String, dynamic> map) {
    return Weight(
      kg: map['kg']?.toDouble(),
      lbs: map['lbs']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weight.fromJson(String source) => Weight.fromMap(json.decode(source));

  @override
  String toString() => 'Weight(kg: $kg, lbs: $lbs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Weight &&
      other.kg == kg &&
      other.lbs == lbs;
  }

  @override
  int get hashCode => kg.hashCode ^ lbs.hashCode;
}
