class AppVersion {
  int id;
  String minappversion;
  String latestappversion;
  String updatedat;

  AppVersion(
      {this.id, this.minappversion, this.latestappversion, this.updatedat});

  AppVersion.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    minappversion = json['minappversion'];
    latestappversion = json['latestappversion'];
    updatedat = json['updatedat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['minappversion'] = this.minappversion;
    data['latestappversion'] = this.latestappversion;
    data['updatedat'] = this.updatedat;
    return data;
  }
}
