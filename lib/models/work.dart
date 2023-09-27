class Work {
  String? occupation;
  String? base;

  Work({
    this.occupation,
    this.base,
  });

  factory Work.fromJson(Map<String, dynamic> json) => Work(
        occupation: json["occupation"],
        base: json["base"],
      );

  Map<String, dynamic> toJson() => {
        "occupation": occupation,
        "base": base,
      };
}
