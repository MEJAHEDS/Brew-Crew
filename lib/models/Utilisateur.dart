class Utilisateur {
  final String uid;
  Utilisateur({required this.uid});
}

class UtilisateurData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UtilisateurData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}
