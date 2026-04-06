import 'package:flutter/material.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Notas'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
                border: Border.all(
                  color: note['color'] as Color,
                  width: 2.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          note['title'] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: note['color'] as Color,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Text(
                          note['category'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    note['content'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        note['date'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.priority_high,
                            size: 16,
                            color: note['priority'] == 'Alta' 
                                ? Colors.red 
                                : note['priority'] == 'Media' 
                                    ? Colors.orange 
                                    : Colors.green,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            note['priority'] as String,
                            style: TextStyle(
                              fontSize: 12,
                              color: note['priority'] == 'Alta' 
                                  ? Colors.red 
                                  : note['priority'] == 'Media' 
                                      ? Colors.orange 
                                      : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static const List<Map<String, dynamic>> _notes = [
    {
      'title': 'Conceptos clave de Flutter',
      'content': 'Widgets son la base de todo en Flutter. StatelessWidget para UI estática, StatefulWidget para UI dinámica. El método build se llama cada vez que se necesita reconstruir la UI.',
      'category': 'Estudio',
      'date': '05/04/2026',
      'priority': 'Alta',
      'color': Colors.blue,
    },
    {
      'title': 'Ideas para el proyecto',
      'content': 'Implementar navegación con Navigator.push, usar ListView para listas, Container con decoración para tarjetas, Stack para superponer elementos. Recordar usar SizedBox para espaciado.',
      'category': 'Proyecto',
      'date': '04/04/2026',
      'priority': 'Media',
      'color': Colors.green,
    },
    {
      'title': 'Recordatorio de reunión',
      'content': 'Reunión de equipo para discutir el progreso del proyecto. Preparar slides con screenshots del avance y lista de funcionalidades completadas.',
      'category': 'Trabajo',
      'date': '06/04/2026',
      'priority': 'Alta',
      'color': Colors.red,
    },
    {
      'title': 'Lista de compras',
      'content': 'Comprar material de oficina: cuadernos, bolígrafos, post-its. También snacks para las sesiones de estudio largas.',
      'category': 'Personal',
      'date': '07/04/2026',
      'priority': 'Baja',
      'color': Colors.purple,
    },
    {
      'title': 'Resumen de patrones de diseño',
      'content': 'Singleton: una sola instancia. Observer: notificación de cambios. Factory: creación de objetos. Builder: construcción paso a paso. Aplicar en proyecto Flutter.',
      'category': 'Estudio',
      'date': '05/04/2026',
      'priority': 'Media',
      'color': Colors.teal,
    },
    {
      'title': 'Tareas pendientes de la semana',
      'content': '1. Completar pantalla de categorías 2. Implementar navegación completa 3. Probar responsive design 4. Documentar código 5. Preparar presentación final',
      'category': 'Proyecto',
      'date': '08/04/2026',
      'priority': 'Alta',
      'color': Colors.orange,
    },
  ];
}
