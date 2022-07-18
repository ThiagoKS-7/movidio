class AppConfig {
  final String BASE_API_URL;
  final String READ_TOKEN;
  final String BASE_IMAGE_API_URL;
  final String API_KEY;

  AppConfig(
      {required this.BASE_API_URL,
      required this.READ_TOKEN,
      required this.BASE_IMAGE_API_URL,
      required this.API_KEY});
}
