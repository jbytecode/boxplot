class Stats {
  /// fit a value x in [min, max] to [0,100]
  static arrange(double min, double max, double value) {
    return 100 * ((value - min) / (max - min));
  }

  /// fit a value x in [0, 100] to [min, max]
  static rearrange(double min, double max, double value) {
    return ((max - min) * (value) / 100.0) + min;
  }

  /// minimum of the list
  static double min(List<double> arr) {
    double min = arr[0];
    arr.forEach((double element) {
      if (element < min) {
        min = element;
      }
    });
    return min;
  }

  /// maximum of the list
  static double max(List<double> arr) {
    double max = arr[0];
    arr.forEach((double element) {
      if (element > max) {
        max = element;
      }
    });
    return max;
  }

  /// A basic estimator for median
  static double median(List<double> arr) {
    List<double> temp = List.from(arr);
    temp.sort((double a, double b) {
      return a.compareTo(b);
    });
    int length = temp.length;
    if (length % 2 == 1) {
      return temp[(length / 2).ceil() - 1];
    } else {
      return (temp[(length / 2).toInt() - 1] +
              temp[((length / 2) + 1).toInt() - 1]) *
          0.5;
    }
  }

  /// A basic estimator for 25th percentile
  static double q1(List<double> arr) {
    double mymedian = Stats.median(arr);
    List<double> temp = arr.where((double element) {
      return element < mymedian;
    }).toList();
    return Stats.median(temp);
  }

  /// A basic estimator for 75th percentile
  static double q3(List<double> arr) {
    double mymedian = Stats.median(arr);
    List<double> temp = arr.where((double element) {
      return element > mymedian;
    }).toList();
    return Stats.median(temp);
  }
}
