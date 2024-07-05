class TeamMember {
  final String name;
  final String role;
  final String imageUrl;

  TeamMember({required this.name, required this.role, required this.imageUrl});
}

List<TeamMember> teamMembers = [
  TeamMember(
      name: "Carlos Fornari",
      role: "Líder y Arquitecto",
      imageUrl: "assets/team/carlos.jpeg"),
  TeamMember(
      name: "Juan Hedderich",
      role: "Líder de Front y Diseñador",
      imageUrl: "assets/team/Juan.JPG"),
  TeamMember(
      name: "Sandro Portanova",
      role: "Frontend",
      imageUrl: "assets/team/andres.png"),
  TeamMember(
      name: "Andrés Arispe",
      role: "Frontend",
      imageUrl: "assets/team/andres.png"),
  TeamMember(
      name: "Renato Torrela",
      role: "Frontend",
      imageUrl: "assets/team/renato.png"),
  TeamMember(
      name: "Luis Elian", role: "Backend", imageUrl: "assets/team/elian.png"),
  TeamMember(
      name: "Jose Pérez", role: "Backend", imageUrl: "assets/team/jose.jpeg"),
  TeamMember(
      name: "El Censurado",
      role: "Backend",
      imageUrl: "assets/team/andres.png"),
  TeamMember(
      name: "Roselyn Medeiro",
      role: "Frontend",
      imageUrl: "assets/team/andres.png"),
];
