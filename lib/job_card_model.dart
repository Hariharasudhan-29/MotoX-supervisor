import 'dart:ui';

class JobCardModel {
  final String jcNumber;
  final String jcDate;
  final String regNumber;
  final String make;
  final String model;
  final String year;
  final String color;
  final String odo;
  final String chassis;
  final String engine;
  final String fuelType;
  final String transmission;
  final String custName;
  final String custPhone;
  final String custEmail;
  final String custAddress;
  final String saName;
  final String techName;
  final String contactPref;
  final List<String> serviceTypes;
  final List<String> complaints;
  final String complaintDetails;
  final double fuelLevel;
  final bool hasSpareWheel;
  final bool hasToolKit;
  final bool hasJackKit;
  final bool hasDocuments;
  final Map<String, bool> inspectionStatuses;
  final String otherIssues;
  final Map<String, String> photoPaths;
  final List<PointModel?> signaturePoints;
  final String? signatureBase64;

  JobCardModel({
    required this.jcNumber,
    required this.jcDate,
    required this.regNumber,
    required this.make,
    required this.model,
    required this.year,
    required this.color,
    required this.odo,
    required this.chassis,
    required this.engine,
    required this.fuelType,
    required this.transmission,
    required this.custName,
    required this.custPhone,
    required this.custEmail,
    required this.custAddress,
    required this.saName,
    required this.techName,
    required this.contactPref,
    required this.serviceTypes,
    required this.complaints,
    required this.complaintDetails,
    required this.fuelLevel,
    required this.hasSpareWheel,
    required this.hasToolKit,
    required this.hasJackKit,
    required this.hasDocuments,
    required this.inspectionStatuses,
    required this.otherIssues,
    required this.photoPaths,
    required this.signaturePoints,
    this.signatureBase64,
  });

  Map<String, dynamic> toJson() {
    return {
      'jcNumber': jcNumber,
      'jcDate': jcDate,
      'customer': {
        'name': custName,
        'phone': custPhone,
        'email': custEmail,
        'address': custAddress,
      },
      'vehicle': {
        'registration': regNumber,
        'make': make,
        'model': model,
        'year': year,
        'color': color,
        'odometer': odo,
        'chassis': chassis,
        'engine': engine,
        'fuel': fuelType,
        'transmission': transmission,
      },
      'service': {
        'advisor': saName,
        'technician': techName,
        'contactPreference': contactPref,
        'types': serviceTypes,
        'complaints': complaints,
        'details': complaintDetails,
        'fuelLevel': fuelLevel,
        'inventory': {
          'spareWheel': hasSpareWheel,
          'toolKit': hasToolKit,
          'jackKit': hasJackKit,
          'documents': hasDocuments,
        },
      },
      'inspection': inspectionStatuses,
      'otherIssues': otherIssues,
      'photosCount': photoPaths.length,
      'signed': signaturePoints.isNotEmpty || signatureBase64 != null,
      'signatureBase64': signatureBase64,
    };
  }
}

class PointModel {
  final double x;
  final double y;
  final String type; // 'move' or 'line' or 'up'

  PointModel(this.x, this.y, this.type);
}
