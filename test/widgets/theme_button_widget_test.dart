import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kak_kashka/product/model/product_model.dart';
import 'package:kak_kashka/product/ui/widgets/product_card.dart';

import 'utils.dart';

void main() {
  group('ThemeButton builder', () {
    testWidgets('for light theme', (tester) async {
      await tester.pumpWidget(
        makeTestableWidget(
          ProductCard(
            productModel: ProductModel.empty(),
          ),
        ),
      );

      expect(find.text('-EMPTY-NAME-'), findsOneWidget);
      expect(find.text('Банан'), findsNothing);

      // не понял как работает, нужно почиттать
      final typeFinder = find.byWidgetPredicate((widget) {
        if (widget is! Icon) {
          return false;
        }

        return widget.icon == Icons.brightness_3;
      });
    });
  });
}
