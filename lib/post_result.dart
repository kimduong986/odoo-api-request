import 'dart:convert';

import 'package:http/http.dart' as http;

class Contact {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;
  final String function;
  final bool companyId;
  final String contactAddress;
  // final List<dynamic> userIds;
  final bool active;

  Contact(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.website,
      required this.function,
      required this.companyId,
      required this.contactAddress,
      // required this.userIds,
      required this.active});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
      function: json['function'],
      companyId: json['company_id'],
      contactAddress: json['contact_address'],
      // userIds: json['user_ids'],
      active: json['active'],
    );
  }
}

Future<Contact> fetchSingleContact(int id) async {
  var auth = base64Encode(
      utf8.encode('nyoba_api:b58e472b-a7a0-46ef-a721-ae24fa46917d'));

  final response = await http.get(
    Uri.parse("http://192.168.4.158:8069/api/v1/partner/res.partner/$id"),
    headers: {'Authorization': 'Basic $auth'},
  );

  if (response.statusCode == 200) {
    return Contact.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch contact ${response.statusCode}');
  }
}
