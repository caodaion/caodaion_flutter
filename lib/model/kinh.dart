class Kinh {
  final String key;
  final String name;
  final String group;

  Kinh({
    required this.key,
    required this.name,
    required this.group,
  });

  factory Kinh.fromJson(Map<String, dynamic> json) {
    return Kinh(
      key: json['key'],
      name: json['name'],
      group: json['group'],
    );
  }
}
