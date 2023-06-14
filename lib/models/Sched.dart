class Sched {
  String? date;
  String? time;
  String? title;
  String? reason;

  Sched({this.date, this.time, this.title, this.reason});

  Sched.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    title = json['title'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['title'] = this.title;
    data['reason'] = this.reason;
    return data;
  }
}
