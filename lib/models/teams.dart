class Team {
  final String id;
  final String name;
  final String joinCode;
  final String ownerId;

  Team({
    required this.id,
    required this.name,
    required this.joinCode,
    required this.ownerId,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      joinCode: json['join_code'],
      ownerId: json['owner_id'],
    );
  }
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'join_code': joinCode,
    'owner_id': ownerId,
  };
}
