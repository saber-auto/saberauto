class Service {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.imageUrl = 'assets/images/saber.png', // ✅ Default image path
  });
}
