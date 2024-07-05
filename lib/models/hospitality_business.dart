class HospitalityBusiness {
  final num id;

  final String name;
  final String structuralScore;
  final String hygieneScore;
  final String confidenceInManagementScore;
  final String ratingValue;
  final String addressLineOne;
  final String addressLineTwo;
  final String addressLineThree;
  final String addressLineFour;
  final String postCode;
  final String businessType;
  final String localAuthority;

  final double latitude;
  final double longitude;
  final double distance;

  const HospitalityBusiness(
      {required this.id,
      required this.name,
      required this.latitude,
      required this.longitude,
      required this.structuralScore,
      required this.hygieneScore,
      required this.confidenceInManagementScore,
      required this.ratingValue,
      required this.addressLineOne,
      required this.addressLineTwo,
      required this.addressLineThree,
      required this.addressLineFour,
      required this.postCode,
      required this.businessType,
      required this.localAuthority,
      required this.distance});
}
