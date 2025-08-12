

// Helper class for document links
class DocumentLink {
  final String title;
  final String url;

  DocumentLink({
    required this.title,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
    };
  }

  factory DocumentLink.fromJson(Map<String, dynamic> json) {
    return DocumentLink(
      title: json['title'],
      url: json['url'],
    );
  }
}

// Model for the registration request body
class CitizenRegistrationRequest {
  final bool active;
  final List<DocumentLink> documentLinks;
  final String email;
  final String firstName;
  final String lastName;
  final String nic;
  final String phone;

  CitizenRegistrationRequest({
    this.active = true,
    required this.documentLinks,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.nic,
    required this.phone,
  });

  // Method to convert the object to a JSON format for the API request
  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'document_links': documentLinks.map((link) => link.toJson()).toList(),
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'nic': nic,
      'phone': phone,
    };
  }
}

// Model for the registration response body
class CitizenRegistrationResponse {
  final bool active;
  final List<DocumentLink> documentLinks;
  final String email;
  final String firstName;
  final String lastName;
  final String nic;
  final String phone;
  final int referenceId;

  CitizenRegistrationResponse({
    required this.active,
    required this.documentLinks,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.nic,
    required this.phone,
    required this.referenceId,
  });

  // Factory constructor to create an object from a JSON response
  factory CitizenRegistrationResponse.fromJson(Map<String, dynamic> json) {
    var docLinksJson = json['document_links'] as List;
    List<DocumentLink> docLinks = docLinksJson.map((i) => DocumentLink.fromJson(i)).toList();

    return CitizenRegistrationResponse(
      active: json['active'],
      documentLinks: docLinks,
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      nic: json['nic'],
      phone: json['phone'],
      referenceId: json['reference_id'],
    );
  }
}
