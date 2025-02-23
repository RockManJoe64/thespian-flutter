class ActorViewModel {
  final String name;
  final String profileImageUrl;
  final String biography;
  final DateTime birthday;
  final DateTime? deathday;

  ActorViewModel({
    required this.name,
    required this.profileImageUrl,
    required this.biography,
    required this.birthday,
    this.deathday,
  });
}
