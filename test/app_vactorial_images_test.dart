import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:steam_app/resources/resources.dart';

void main() {
  test('app_vactorial_images assets test', () {
    expect(File(AppVactorialImages.bgPattern).existsSync(), true);
    expect(File(AppVactorialImages.back).existsSync(), true);
    expect(File(AppVactorialImages.close).existsSync(), true);
    expect(File(AppVactorialImages.emptyLikes).existsSync(), true);
    expect(File(AppVactorialImages.emptyWhishlist).existsSync(), true);
    expect(File(AppVactorialImages.like).existsSync(), true);
    expect(File(AppVactorialImages.likeFull).existsSync(), true);
    expect(File(AppVactorialImages.warning).existsSync(), true);
    expect(File(AppVactorialImages.whishlist).existsSync(), true);
    expect(File(AppVactorialImages.whishlistFull).existsSync(), true);
  });
}
