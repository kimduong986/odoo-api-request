class User {
  final String uid;
  final String name;
  final String username;

  User({required this.uid, required this.name, required this.username});

  factory User.createUser(Map<String, dynamic> json) {
    if (json.containsKey('error')) {
      return User(uid: '', name: '', username: '');
    }

    return User(
      uid: json['result']['uid'].toString(),
      name: json['result']['name'],
      username: json['result']['username'],
    );
  }
}
