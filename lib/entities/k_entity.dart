import 'package:flutter/foundation.dart';

import 'candle_entity.dart';
import 'kdj_entity.dart';
import 'macd_entity.dart';
import 'rsi_entity.dart';
import 'rw_entity.dart';
import 'volume_entity.dart';

class KEntity
    with
        CandleEntity,
        VolumeEntity,
        KDJEntity,
        RSIEntity,
        WREntity,
        MACDEntity {
  final double BOLLMA;
  final double MA10Volume;
  final double MA5Volume;
  final double close;
  final double d;
  final double dea;
  final double dif;
  final double dn;
  final double high;
  final double j;
  final double k;
  final double low;
  final double macd;
  final double mb;
  final double open;
  final double r;
  final double rsi;
  final double up;
  final double vol;
  final List<double> maValueList;

  KEntity({
    @required this.BOLLMA,
    @required this.MA10Volume,
    @required this.MA5Volume,
    @required this.close,
    @required this.d,
    @required this.dea,
    @required this.dif,
    @required this.dn,
    @required this.high,
    @required this.j,
    @required this.k,
    @required this.low,
    @required this.macd,
    @required this.mb,
    @required this.open,
    @required this.r,
    @required this.rsi,
    @required this.up,
    @required this.vol,
    @required this.maValueList,
  });
}
