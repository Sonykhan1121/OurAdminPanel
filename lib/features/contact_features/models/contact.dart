import 'address.dart';

class Contact {
  final String? fullName;
  final String? companyName;
  final String? jobTitle;
  final String? email;
  final String? phoneNumber;
  final String? mobileNumber;
  final String? faxNumber;
  final String? websiteUrl;
  final Address? address;
  final Map<String, String>? socialMediaLinks; // e.g. {"LinkedIn": "url", "Twitter": "url"}
  final List<String>? preferredContactMethods; // e.g. ["email", "phone"]
  final String? notes; // Any extra notes about contact

  Contact({
    this.fullName,
    this.companyName,
    this.jobTitle,
    this.email,
    this.phoneNumber,
    this.mobileNumber,
    this.faxNumber,
    this.websiteUrl,
    this.address,
    this.socialMediaLinks,
    this.preferredContactMethods,
    this.notes,
  });
}


