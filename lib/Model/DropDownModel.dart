class DropDownModal {
  String id = '';
  String title = '';
  String titleKn = '';
  String status = '';

  DropDownModal({required this.id, required this.title, required this.titleKn, required this.status});

  DropDownModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    titleKn = json['titleKn'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['status'] = status;
    return data;
  }
}
