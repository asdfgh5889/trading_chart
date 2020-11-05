import 'kdj_entity.dart';
import 'rsi_entity.dart';
import 'rw_entity.dart';

mixin MACDEntity on KDJEntity, RSIEntity, WREntity {
  double get dea;
  double get dif;
  double get macd;
}
