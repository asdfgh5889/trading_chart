import 'package:flutter/foundation.dart';

import 'k_entity.dart';

class KLineEntity extends KEntity {
  final double open;
  final double high;
  final double low;
  final double close;
  final double vol;
  final double amount;
  final double change;
  final double ratio;
  final int time;

  KLineEntity({
    @required this.amount,
    @required this.open,
    @required this.close,
    @required this.change,
    @required this.ratio,
    @required this.time,
    @required this.high,
    @required this.low,
    @required this.vol,
  });

  KLineEntity copyWith({
    double open,
    double high,
    double low,
    double close,
    double vol,
    double amount,
    double change,
    double ratio,
    int time,
  }) =>
      KLineEntity(
        open: open ?? this.open,
        high: high ?? this.high,
        low: low ?? this.low,
        close: close ?? this.close,
        vol: vol ?? this.vol,
        amount: amount ?? this.amount,
        change: change ?? this.change,
        ratio: ratio ?? this.ratio,
        time: time ?? this.time,
      );

  @override
  String toString() {
    return 'MarketModel{open: $open, high: $high, low: $low, close: $close, vol: $vol, time: $time, amount: $amount, ratio: $ratio, change: $change}';
  }
}
