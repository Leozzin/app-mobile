class Attendance {
  int id;
  String eleve;
  String eleveID;
  String classe;
  String date;
  String time;
  String matiere;
  String status;
  int start;
  int end;

  Attendance(
      {this.id,
      this.eleve,
      this.eleveID,
      this.classe,
      this.date,
      this.time,
      this.matiere,
      this.status,
      this.start,
      this.end});

  Attendance.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eleve = json['eleve'];
    eleveID = json['eleveID'];
    classe = json['classe'];
    date = json['date'];
    time = json['time'];
    matiere = json['matiere'];
    status = json['status'];
    start = json['start'];
    end = json['end'];
  }
}
