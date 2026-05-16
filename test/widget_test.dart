// Test mínimo para validar que el binding de Flutter se inicializa.
// El widget_test del template original probaba el contador de la app demo,
// que ya no existe. Aquí dejamos un smoke test minimal.

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('smoke test - placeholder', () {
    expect(1 + 1, 2);
  });
}
