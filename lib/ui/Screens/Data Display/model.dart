class msg {
  String? content;
  String title;
  String date;

  msg({
    required this.content,
    required this.title,
    required this.date,
  });

  factory msg.fromJson(Map<dynamic, dynamic> json) {
    return msg(
      content: json['Content'],
      title: json['Title'] ?? '',
      date: json['Date'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Message(title: $title, content: $content, date: $date)';
  }
}

class Contact {
  String? name;
  String phNo;

  Contact({
    required this.name,
    required this.phNo,
  });

  factory Contact.fromJson(Map<dynamic, dynamic> json) {
    return Contact(
      name: json['name'],
      phNo: json['phone_number'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Contact(name: $name, phNo: $phNo)';
  }
}

class loc {
  String? date;
  String latitude;
  String longitude;

  loc({
    required this.date,
    required this.latitude,
    required this.longitude,
  });

  factory loc.fromJson(Map<dynamic, dynamic> json) {
    return loc(
      date: json['Date'],
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Location(date: $date, latitude: $latitude, longitude: $longitude)';
  }
}

class mobId {
  String? id;

  mobId({
    required this.id,
  });

  factory mobId.fromJson(Map<dynamic, dynamic> json) {
    return mobId(
      id: json['id'],
    );
  }

  @override
  String toString() {
    return 'mobId(id: $id)';
  }
}

class liveLoc {
  String? name;
  String longitude;
  String latitude;

  liveLoc({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory liveLoc.fromJson(Map<dynamic, dynamic> json) {
    return liveLoc(
      name: json['name'],
      longitude: json['longitude'] ?? '',
      latitude: json['latitude'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Location(name: $name, latitude: $latitude, longitude: $longitude)';
  }
}
