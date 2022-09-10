class SpotData {
  final double x;
  final double y;

  SpotData({required this.x, required this.y});
  static List<SpotData> spotData({
    required List<double> dataX,
    required List<double> dataY,
  }) {
    List<SpotData> data = List<SpotData>.generate(
        dataX.length, (index) => SpotData(x: dataX[index], y: dataY[index]));
    return data;
  }
}
