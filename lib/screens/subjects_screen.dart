import 'package:flutter/material.dart';
import 'notes_by_subject_screen.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          'Mis Materias',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecciona una materia para ver tus notas',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: _subjects.length,
                itemBuilder: (context, index) {
                  final subject = _subjects[index];
                  return _buildSubjectCard(subject, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotesBySubjectScreen(subject: subject['name'] as String),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono de la materia
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: (subject['color'] as Color).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    subject['icon'] as IconData,
                    size: 30,
                    color: subject['color'] as Color,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Nombre de la materia
                Text(
                  subject['name'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                
                // Número de notas
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: (subject['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${subject['notesCount']} notas',
                    style: TextStyle(
                      fontSize: 12,
                      color: subject['color'] as Color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const List<Map<String, dynamic>> _subjects = [
    {
      'name': 'Matemáticas',
      'icon': Icons.calculate,
      'color': Colors.blue,
      'notesCount': 8,
    },
    {
      'name': 'Programación',
      'icon': Icons.code,
      'color': Colors.green,
      'notesCount': 12,
    },
    {
      'name': 'Redes',
      'icon': Icons.router,
      'color': Colors.purple,
      'notesCount': 6,
    },
    {
      'name': 'Base de Datos',
      'icon': Icons.storage,
      'color': Colors.orange,
      'notesCount': 4,
    },
    {
      'name': 'Algoritmos',
      'icon': Icons.account_tree,
      'color': Colors.red,
      'notesCount': 7,
    },
    {
      'name': 'Inglés',
      'icon': Icons.language,
      'color': Colors.teal,
      'notesCount': 3,
    },
  ];
}
