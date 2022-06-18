import 'package:fisplan_alupar/app/core/app_validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Validador Principal - simpleValidator:", () {
    test('Caso passar um valor vazio deve retornar uma String', () {
      expect(simpleValidate(''), isA<String>());
    });

    test('Caso passar um valor nulo deve retornar uma String', () {
      expect(simpleValidate(null), isA<String>());
    });

    test('Caso passar um valor não vazio deve retornar null', () {
      expect(simpleValidate('teste'), isNull);
    });
  });

  group("Validador de email - validateEmail: ", () {
    test('Caso passar um valor vazio deve retornar uma String', () {
      expect(validateEmail(''), isA<String>());
    });

    test('Caso passar um valor nulo deve retornar uma String', () {
      expect(validateEmail(null), isA<String>());
    });

    test('Caso passar um valor porém sem o @ deve retornar uma String', () {
      expect(validateEmail('teste.com.br'), isA<String>());
    });

    test('Caso passar um valor porém sem o . deve retornar uma String', () {
      expect(validateEmail('teste@teste'), isA<String>());
    });

    test('Caso passar um valor com dois @ deve retornar uma String', () {
      expect(validateEmail('teste@@teste.com'), isA<String>());
    });

    test('Caso contenha o @ e o . deve retornar null', () {
      expect(validateEmail('teste@teste.com'), isNull);
    });
  });
}
