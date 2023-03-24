import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:steam_app/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.bgPattern).existsSync(), true);
    expect(File(Images.jacket).existsSync(), true);
    expect(File(Images.share).existsSync(), true);
  });
}
