import 'package:flutter/material.dart';

class RecommendationItem {
  final String title;
  final String category;
  final String distanceText;
  RecommendationItem({
    required this.title,
    required this.category,
    required this.distanceText,
  });
}

class HomeProvider extends ChangeNotifier {
  int currentTab = 0;

  final List<RecommendationItem> recommendations = [
    RecommendationItem(title: 'Café Central', category: 'Café', distanceText: '5 min'),
    RecommendationItem(title: 'Museo de Arte', category: 'Cultura', distanceText: '12 min'),
    RecommendationItem(title: 'Parque Norte', category: 'Naturaleza', distanceText: '8 min'),
  ];

  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  void setTab(int index) {
    currentTab = index;
    notifyListeners();
  }

  void onInterestButtonPressed() {
    // Aquí abriremos el selector de intereses o lanzaremos una búsqueda
    // Por ahora: demo -> añadimos otra recomendación al principio
    recommendations.insert(
      0,
      RecommendationItem(title: 'Restaurante La Plaza', category: 'Comida', distanceText: '10 min'),
    );
    notifyListeners();
  }

  void onSelect(RecommendationItem item) {
    // Abrir detalle del POI o resaltar en mapa
  }

  void onNavigateTo(RecommendationItem item) {
    // Iniciar cálculo de ruta y mostrar ETA en el mapa
  }

  void onSearchChanged(String value) {
    searchQuery = value;
    // Aquí podrás filtrar recomendaciones en base al query
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}