import 'package:flutter/material.dart';

class NotesBySubjectScreen extends StatelessWidget {
  final String subject;

  const NotesBySubjectScreen({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final notes = _getNotesBySubject(subject);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          subject,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header con estadísticas
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF2D3748),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getSubjectIcon(subject),
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Notas de',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  subject,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildStatCard('Total', '${notes.length}', Colors.blue),
                    const SizedBox(width: 12),
                    _buildStatCard('Alta', '${_getNotesCountByPriority(notes, 'Alta')}', Colors.red),
                    const SizedBox(width: 12),
                    _buildStatCard('Hoy', '2', Colors.green),
                  ],
                ),
              ],
            ),
          ),
          
          // Lista de notas
          Expanded(
            child: notes.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final note = notes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildNoteCard(note),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteCard(Map<String, dynamic> note) {
    final priorityColor = _getPriorityColor(note['priority'] as String);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título y prioridad
            Row(
              children: [
                Expanded(
                  child: Text(
                    note['title'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3748),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: priorityColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    note['priority'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: priorityColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Contenido
            Text(
              note['content'] as String,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
            
            // Fecha
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 6),
                Text(
                  note['date'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No hay notas en $subject',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Crea tu primera nota para comenzar',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getSubjectIcon(String subject) {
    switch (subject) {
      case 'Matemáticas':
        return Icons.calculate;
      case 'Programación':
        return Icons.code;
      case 'Redes':
        return Icons.router;
      case 'Base de Datos':
        return Icons.storage;
      case 'Algoritmos':
        return Icons.account_tree;
      case 'Inglés':
        return Icons.language;
      default:
        return Icons.book;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'Alta':
        return Colors.red;
      case 'Media':
        return Colors.orange;
      case 'Baja':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> _getNotesBySubject(String subject) {
    // Datos simulados por materia
    switch (subject) {
      case 'Matemáticas':
        return [
          {
            'title': 'Ejercicios de derivadas',
            'content': 'Practicar los ejercicios del capítulo 5, especialmente las reglas de la cadena y derivación implícita.',
            'priority': 'Alta',
            'date': '05/04/2026',
          },
          {
            'title': 'Repaso de integrales',
            'content': 'Estudiar los diferentes métodos de integración: por partes, sustitución y fracciones parciales.',
            'priority': 'Media',
            'date': '06/04/2026',
          },
          {
            'title': 'Proyecto de cálculo',
            'content': 'Desarrollar el proyecto final sobre aplicaciones de las derivadas en problemas de optimización.',
            'priority': 'Alta',
            'date': '08/04/2026',
          },
        ];
      case 'Programación':
        return [
          {
            'title': 'Estudiar Flutter - StatelessWidget',
            'content': 'Repasar los conceptos de StatelessWidget y cómo manejar el estado sin setState.',
            'priority': 'Alta',
            'date': '05/04/2026',
          },
          {
            'title': 'Proyecto final - Interfaces',
            'content': 'Diseñar las interfaces para la aplicación móvil usando Material Design 3.',
            'priority': 'Alta',
            'date': '08/04/2026',
          },
          {
            'title': 'Algoritmos de ordenamiento',
            'content': 'Implementar quicksort, mergesort y heapsort en Dart.',
            'priority': 'Media',
            'date': '09/04/2026',
          },
          {
            'title': 'Estructuras de datos',
            'content': 'Estudiar árboles binarios, grafos y sus aplicaciones prácticas.',
            'priority': 'Media',
            'date': '10/04/2026',
          },
        ];
      case 'Redes':
        return [
          {
            'title': 'Configurar red local',
            'content': 'Documentar la configuración de la red para el proyecto final.',
            'priority': 'Baja',
            'date': '07/04/2026',
          },
          {
            'title': 'Estudiar protocolos TCP/IP',
            'content': 'Preparar examen sobre la capa de transporte y red.',
            'priority': 'Media',
            'date': '09/04/2026',
          },
          {
            'title': 'Configurar firewall',
            'content': 'Implementar reglas de firewall para la red del laboratorio.',
            'priority': 'Alta',
            'date': '11/04/2026',
          },
        ];
      default:
        return [];
    }
  }

  int _getNotesCountByPriority(List<Map<String, dynamic>> notes, String priority) {
    return notes.where((note) => note['priority'] == priority).length;
  }
}
