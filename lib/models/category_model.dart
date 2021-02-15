class CategoryModel {
  String category;
  int hours;

  CategoryModel({this.category, this.hours});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    hours = json['hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['hours'] = this.hours;
    return data;
  }
}
