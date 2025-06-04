import 'dart:io';

class Helper {
  /// Return device based dimension
  static double getNormDim(double androidDimension, double iOSDimension) {
    if (Platform.isAndroid) {
      return androidDimension;
    } else {
      return iOSDimension;
    }
  }
}