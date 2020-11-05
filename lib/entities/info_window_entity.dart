import 'k_line_entity.dart';

class InfoWindowEntity {
  final KLineEntity kLineEntity;
  final bool isLeft;

  InfoWindowEntity(this.kLineEntity, [this.isLeft = false]);
}
