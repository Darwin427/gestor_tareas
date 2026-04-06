import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mis Categorías',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Organiza tus tareas y notas por categorías',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Seleccionaste: ${category['name']}'),
                          backgroundColor: category['color'] as Color,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Imagen de fondo
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              category['image'] as String,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: (category['color'] as Color).withValues(alpha: 0.3),
                                  child: Center(
                                    child: Icon(
                                      category['icon'] as IconData,
                                      size: 50,
                                      color: category['color'] as Color,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          // Overlay semitransparente para mejor legibilidad
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.7),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          // Contenido (texto e iconos)
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      category['icon'] as IconData,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        category['name'] as String,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${category['count']} tareas',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _categories = [
    {
      'name': 'Estudio',
      'icon': Icons.school,
      'count': 8,
      'color': Colors.blue,
      'image': 'https://picsum.photos/seed/study/400/300.jpg',
    },
    {
      'name': 'Trabajo',
      'icon': Icons.work,
      'count': 5,
      'color': Colors.red,
      'image': 'https://picsum.photos/seed/work/400/300.jpg',
    },
    {
      'name': 'Personal',
      'icon': Icons.person,
      'count': 12,
      'color': Colors.green,
      'image': 'https://picsum.photos/seed/personal/400/300.jpg',
    },
    {
      'name': 'Proyecto',
      'icon': Icons.code,
      'count': 6,
      'color': Colors.purple,
      'image': 'https://picsum.photos/seed/project/400/300.jpg',
    },
    {
      'name': 'Salud',
      'icon': Icons.favorite,
      'count': 3,
      'color': Colors.pink,
      'image': 'https://picsum.photos/seed/health/400/300.jpg',
    },
    {
      'name': 'Finanzas',
      'icon': Icons.account_balance,
      'count': 4,
      'color': Colors.orange,
      'image': 'https://picsum.photos/seed/finance/400/300.jpg',
    },
  ];
}
