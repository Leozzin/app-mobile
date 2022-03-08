class Eleves {
  int id;
  String nom;
  String prenom;
  String classe;
  String dateNaissance;
  String parent;
  String phoneParent;
  String emailParent;
  String address;
  String image;

  Eleves(
      {this.id,
      this.nom,
      this.prenom,
      this.classe,
      this.dateNaissance,
      this.parent,
      this.phoneParent,
      this.emailParent,
      this.address,
      this.image});

  Eleves.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    classe = json['classe'];
    dateNaissance = json['dateNaissance'];
    parent = json['parent'];
    phoneParent = json['phoneParent'];
    emailParent = json['emailParent'];
    address = json['address'];
    image = json['image'];
  }
}
