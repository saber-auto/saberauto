class Service {
  final String id; // ID unique du service
  final String title;
  final String description;
  final List<String> images; // Liste d'images
  final double prixLocation;
  final double prixAchat;

  Service({
    required this.id, // Ajout de l'ID
    required this.title,
    required this.description,
    required this.images, // Liste d'images obligatoire
    required this.prixLocation,
    required this.prixAchat,
  }) : assert(images.isNotEmpty,
            "Chaque service doit avoir au moins une image !");
}
