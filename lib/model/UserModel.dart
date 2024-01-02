
class User {
  final String uid;
  final String nom;
  final String prenom;
  final String localisation;
  final String numero;

  User({
    required this.uid,
    required this.nom,
    required this.prenom,
    required this.localisation,
    required this.numero,
  });

  User.empty() : // Constructeur par défaut sans arguments
        uid = '',
        nom = '',
        prenom = '',
        localisation = '',
        numero = '';
}
