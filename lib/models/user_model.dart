import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

class UserModel {
    final int id;
    final String nic;
    final String firstName;
    final String lastName;
    final String email;
    final String phone;
    final String role;
    final bool active;
    final List<DocumentLink> documentLinks;
    final DateTime createdAt;
    final String accessToken;
    final String tokenType;

    UserModel({
        required this.id,
        required this.nic,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phone,
        required this.role,
        required this.active,
        required this.documentLinks,
        required this.createdAt,
        required this.accessToken,
        required this.tokenType,
    });

factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
  id: json["id"] ?? 0,
  nic: json["nic"] ?? "",
  firstName: json["first_name"] ?? "",
  lastName: json["last_name"] ?? "",
  email: json["email"] ?? "",
  phone: json["phone"] ?? "",
  role: json["role"] ?? "",
  active: json["active"] ?? false,
  documentLinks: json["document_links"] != null
      ? List<DocumentLink>.from(json["document_links"].map((x) => DocumentLink.fromJson(x)))
      : [],
  createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : DateTime.now(),
  accessToken: json["access_token"] ?? "",
  tokenType: json["token_type"] ?? "",
);


   Map<String, dynamic> toJson() => {
        "id": id,
        "nic": nic,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone": phone,
        "role": role,
        "active": active,
        "document_links": List<dynamic>.from(documentLinks.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class DocumentLink {
    final String title;
    final String url;
    final DateTime uploadedAt;

    DocumentLink({
        required this.title,
        required this.url,
        required this.uploadedAt,
    });

    factory DocumentLink.fromJson(Map<String, dynamic> json) => DocumentLink(
  title: json["title"] ?? "",
  url: json["url"] ?? "",
  uploadedAt: json["uploaded_at"] != null ? DateTime.parse(json["uploaded_at"]) : DateTime.now(),
);


    Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
    "uploaded_at": uploadedAt.toIso8601String(), 
};
}