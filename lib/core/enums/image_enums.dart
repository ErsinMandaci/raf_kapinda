enum ImageEnum {
  splash('splash'),
  onboarding('onboarding'),
  signInTop('mask_group'),
  havuc('havuc'),
  bannera('banner'),
  elma('elma'),
  banner('banner'),
  banner1('banner1'),
  banner2('banner2');

  const ImageEnum(this.value);
  final String value;


  String get toPng => 'assets/images/$value.png';
  String get toSvg => 'assets/images/$value.svg';
  String get toJpg => 'assets/images/$value.jpg';
}
