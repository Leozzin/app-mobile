class Enseignant {
  int id;
  String nom;
  String prenom;
  String classes;
  String dateNaissance;
  String parent;
  String phone;
  String email;
  String address;
  String image;

  Enseignant(
      {this.id,
      this.nom,
      this.prenom,
      this.classes,
      this.phone,
      this.email,
      this.address,
      this.image});

  Enseignant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    classes = json['classes'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    image = json['image'];
  }
}
