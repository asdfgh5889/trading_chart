// ignore_for_file: non_constant_identifier_names,library_prefixes,unused_import,camel_case_types
mixin CandleEntity {
  double get open;
  double get high;
  double get low;
  double get close;
  List<double> get maValueList;

  /// Upper track
  double get up;
  // Middle track
  double get mb;
  // Lower track
  double get dn;
  double get BOLLMA;
}
