class SuperheroImages {
  String? xs;
  String? sm;
  String? md;
  String? lg;

  SuperheroImages({
    this.xs,
    this.sm,
    this.md,
    this.lg,
  });

  factory SuperheroImages.fromJson(Map<String, dynamic> json) =>
      SuperheroImages(
        xs: json["xs"],
        sm: json["sm"],
        md: json["md"],
        lg: json["lg"],
      );

  Map<String, dynamic> toJson() => {
        "xs": xs,
        "sm": sm,
        "md": md,
        "lg": lg,
      };
}
