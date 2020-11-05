import 'dart:math';

import 'package:trading_chart/entities/k_line_entity.dart';

// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import,camel_case_types
abstract class DataUtil {
  /// Calculates MA, BOLL, Volume MA, KDJ, MACD, RSI, WR for each [KLineEntity]
  ///
  /// returns [List<KLineEntity>] with calculated values
  static List<KLineEntity> calculate(
    List<KLineEntity> dataList, [
    List<int> maDayList = const [5, 10, 20],
    int n = 20,
    int k = 2,
  ]) {
    final ma = calcMA(dataList, maDayList);
    final boll = calcBOLL(dataList, n, k);
    final volMa = calcVolumeMA(dataList);
    final kdj = calcKDJ(dataList);
    final macd = calcMACD(dataList);
    final rsi = calcRSI(dataList);
    final wr = calcWR(dataList);

    final result = List<KLineEntity>(dataList.length);

    for (int i = 0; i < dataList.length; i++) {
      result[i] = dataList[i].copyWith(
        maValueList: ma[i],
        mb: boll[i][0],
        up: boll[i][1],
        dn: boll[i][2],
        MA5Volume: volMa[i][0],
        MA10Volume: volMa[i][1],
        kLine: kdj[i][0],
        dLine: kdj[i][1],
        jLine: kdj[i][2],
        dif: macd[i][0],
        dea: macd[i][1],
        macd: macd[i][2],
        rsi: rsi[i],
        range: wr[i],
      );
    }

    return result;
  }

  /// Calculates MA and returns list of MA results for each [KLineEntity]
  static List<List<double>> calcMA(
      List<KLineEntity> dataList, List<int> maDayList) {
    final ma = List<double>.filled(maDayList.length, 0);
    final result = List<List<double>>(dataList.length);

    if (dataList != null && dataList.isNotEmpty) {
      for (int i = 0; i < dataList.length; i++) {
        final closePrice = dataList[i].close;
        final maValueList = List<double>(maDayList.length);

        for (int j = 0; j < maDayList.length; j++) {
          ma[j] += closePrice;
          if (i == maDayList[j] - 1) {
            maValueList[j] = ma[j] / maDayList[j];
          } else if (i >= maDayList[j]) {
            ma[j] -= dataList[i - maDayList[j]].close;
            maValueList[j] = ma[j] / maDayList[j];
          } else {
            maValueList[j] = 0;
          }
        }

        result[i] = maValueList;
      }
    }

    return result;
  }

  /// Calculate BOLL for each [KLineEntity]
  ///
  /// returns mb - [0], up - [1], dn - [2]
  static List<List<double>> calcBOLL(List<KLineEntity> dataList, int n, int k) {
    final bollma = _calcBOLLMA(n, dataList);
    final result = List<List<double>>(dataList.length);
    for (int i = 0; i < dataList.length; i++) {
      if (i >= n) {
        double md = 0;
        for (int j = i - n + 1; j <= i; j++) {
          double c = dataList[j].close;
          double m = bollma[i];
          double value = c - m;
          md += value * value;
        }
        md = md / (n - 1);
        md = sqrt(md);
        final mb = bollma[i];
        final up = mb + k * md;
        final dn = mb - k * md;
        result[i] = [mb, up, dn];
      } else {
        result[i] = [dataList[i].mb, dataList[i].up, dataList[i].dn];
      }
    }
    return result;
  }

  static List<double> _calcBOLLMA(int day, List<KLineEntity> dataList) {
    double ma = 0;
    final bollma = List<double>.filled(dataList.length, 0);

    for (int i = 0; dataList != null && i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      ma += entity.close;
      if (i == day - 1) {
        bollma[i] = ma / day;
      } else if (i >= day) {
        ma -= dataList[i - day].close;
        bollma[i] = ma / day;
      } else {
        bollma[i] = null;
      }
    }

    return bollma;
  }

  /// Caculates MACD for each [KLineEntity]
  ///
  /// returns dif - [0], dea - [1], macd - [2]
  static List<List<double>> calcMACD(List<KLineEntity> dataList) {
    double ema12 = 0;
    double ema26 = 0;
    double dif = 0;
    double dea = 0;
    double macd = 0;
    final result = List<List<double>>(dataList.length);

    for (int i = 0; i < dataList.length; i++) {
      KLineEntity entity = dataList[i];
      final closePrice = entity.close;
      if (i == 0) {
        ema12 = closePrice;
        ema26 = closePrice;
      } else {
        // EMA（12） = 前一日EMA（12） X 11/13 + 今日收盘价 X 2/13
        ema12 = ema12 * 11 / 13 + closePrice * 2 / 13;
        // EMA（26） = 前一日EMA（26） X 25/27 + 今日收盘价 X 2/27
        ema26 = ema26 * 25 / 27 + closePrice * 2 / 27;
      }
      // DIF = EMA（12） - EMA（26） 。
      // 今日DEA = （前一日DEA X 8/10 + 今日DIF X 2/10）
      // 用（DIF-DEA）*2即为MACD柱状图。
      dif = ema12 - ema26;
      dea = dea * 8 / 10 + dif * 2 / 10;
      macd = (dif - dea) * 2;

      result[i] = [dif, dea, macd];
    }

    return result;
  }

  /// Calculates MA for each [KLineEntity]
  ///
  /// returns MA5 - [0], MA10 - [1]
  static List<List<double>> calcVolumeMA(List<KLineEntity> dataList) {
    double volumeMa5 = 0;
    double volumeMa10 = 0;
    final result = List<List<double>>(dataList.length);

    for (int i = 0; i < dataList.length; i++) {
      double resultMa5;
      double resultMa10;

      volumeMa5 += dataList[i].vol;
      volumeMa10 += dataList[i].vol;

      if (i == 4) {
        resultMa5 = (volumeMa5 / 5);
      } else if (i > 4) {
        volumeMa5 -= dataList[i - 5].vol;
        resultMa5 = volumeMa5 / 5;
      } else {
        resultMa5 = 0;
      }

      if (i == 9) {
        resultMa10 = volumeMa10 / 10;
      } else if (i > 9) {
        volumeMa10 -= dataList[i - 10].vol;
        resultMa10 = volumeMa10 / 10;
      } else {
        resultMa10 = 0;
      }

      result[i] = [resultMa5, resultMa10];
    }

    return result;
  }

  /// Calculates RSI for each [KLineEntity]
  static List<double> calcRSI(List<KLineEntity> dataList) {
    double rsi;
    double rsiABSEma = 0;
    double rsiMaxEma = 0;
    final result = List<double>(dataList.length);
    for (int i = 0; i < dataList.length; i++) {
      final double closePrice = dataList[i].close;
      if (i == 0) {
        rsi = 0;
        rsiABSEma = 0;
        rsiMaxEma = 0;
      } else {
        double Rmax = max(0, closePrice - dataList[i - 1].close);
        double RAbs = (closePrice - dataList[i - 1].close).abs();

        rsiMaxEma = (Rmax + (14 - 1) * rsiMaxEma) / 14;
        rsiABSEma = (RAbs + (14 - 1) * rsiABSEma) / 14;
        rsi = (rsiMaxEma / rsiABSEma) * 100;
      }
      if (i < 13) rsi = null;
      if (rsi != null && rsi.isNaN) rsi = null;
      result[i] = rsi;
    }
    return result;
  }

  /// Calculates KDJ for each [KLineEntity]
  ///
  /// resturs kLine - [0], dLine- [1], jLine - [2]
  static List<List<double>> calcKDJ(List<KLineEntity> dataList) {
    double k = 0;
    double d = 0;
    final result = List<List<double>>(dataList.length);
    for (int i = 0; i < dataList.length; i++) {
      final closePrice = dataList[i].close;
      int startIndex = i - 13;
      if (startIndex < 0) {
        startIndex = 0;
      }
      double max14 = double.minPositive;
      double min14 = double.maxFinite;
      for (int index = startIndex; index <= i; index++) {
        max14 = max(max14, dataList[index].high);
        min14 = min(min14, dataList[index].low);
      }
      double rsv = 100 * (closePrice - min14) / (max14 - min14);
      if (rsv.isNaN) {
        rsv = 0;
      }
      if (i == 0) {
        k = 50;
        d = 50;
      } else {
        k = (rsv + 2 * k) / 3;
        d = (k + 2 * d) / 3;
      }

      double kLine;
      double dLine;
      double jLine;
      if (i < 13) {
        kLine = null;
        dLine = null;
        jLine = null;
      } else if (i == 13 || i == 14) {
        kLine = k;
        dLine = null;
        jLine = null;
      } else {
        kLine = k;
        dLine = d;
        jLine = 3 * k - 2 * d;
      }

      result[i] = [kLine, dLine, jLine];
    }

    return result;
  }

  /// Caculates WR for each [KLineEntity]
  static List<double> calcWR(List<KLineEntity> dataList) {
    double r;
    final result = List<double>.filled(dataList.length, 0);
    for (int i = 0; i < dataList.length; i++) {
      int startIndex = i - 14;
      if (startIndex < 0) {
        startIndex = 0;
      }
      double max14 = double.minPositive;
      double min14 = double.maxFinite;
      for (int index = startIndex; index <= i; index++) {
        max14 = max(max14, dataList[index].high);
        min14 = min(min14, dataList[index].low);
      }

      double range;
      if (i < 13) {
        range = -10;
      } else {
        r = -100 * (max14 - dataList[i].close) / (max14 - min14);
        if (r.isNaN) {
          range = null;
        } else {
          range = r;
        }
      }

      result[i] = range;
    }

    return result;
  }
}
