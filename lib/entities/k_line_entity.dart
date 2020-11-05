import 'package:flutter/foundation.dart';

import 'k_entity.dart';

class KLineEntity extends KEntity {
  final double high;
  final double open;
  final double low;
  final double close;
  final double vol;
  final double amount;
  final double change;
  final double ratio;
  final double dLine;
  final double dea;
  final double dif;
  final double dn;
  final double jLine;
  final double kLine;
  final double macd;
  final double mb;
  final double range;
  final double rsi;
  final double up;
  final double BOLLMA;
  final double MA10Volume;
  final double MA5Volume;
  final int time;
  final List<double> maValueList;

  KLineEntity({
    this.amount,
    this.open,
    this.close,
    this.change,
    this.ratio,
    this.time,
    this.high,
    this.low,
    this.vol,
    this.dLine,
    this.dea,
    this.dif,
    this.dn,
    this.jLine,
    this.kLine,
    this.macd,
    this.mb,
    this.range,
    this.rsi,
    this.up,
    this.BOLLMA,
    this.MA10Volume,
    this.MA5Volume,
    this.maValueList,
  });

  KLineEntity copyWith({
    double high,
    double open,
    double low,
    double close,
    double vol,
    double amount,
    double change,
    double ratio,
    double dLine,
    double dea,
    double dif,
    double dn,
    double jLine,
    double kLine,
    double macd,
    double mb,
    double range,
    double rsi,
    double up,
    double BOLLMA,
    double MA10Volume,
    double MA5Volume,
    int time,
    List<double> maValueList,
  }) =>
      KLineEntity(
        high: high ?? this.high,
        open: open ?? this.open,
        low: low ?? this.low,
        close: close ?? this.close,
        vol: vol ?? this.vol,
        amount: amount ?? this.amount,
        change: change ?? this.change,
        ratio: ratio ?? this.ratio,
        dLine: dLine ?? this.dLine,
        dea: dea ?? this.dea,
        dif: dif ?? this.dif,
        dn: dn ?? this.dn,
        jLine: jLine ?? this.jLine,
        kLine: kLine ?? this.kLine,
        macd: macd ?? this.macd,
        mb: mb ?? this.mb,
        range: range ?? this.range,
        rsi: rsi ?? this.rsi,
        up: up ?? this.up,
        BOLLMA: BOLLMA ?? this.BOLLMA,
        MA10Volume: MA10Volume ?? this.MA10Volume,
        MA5Volume: MA5Volume ?? this.MA5Volume,
        time: time ?? this.time,
        maValueList: maValueList ?? this.maValueList,
      );

  @override
  String toString() {
    return 'MarketModel{open: $open, high: $high, low: $low, close: $close, vol: $vol, time: $time, amount: $amount, ratio: $ratio, change: $change}';
  }
}
