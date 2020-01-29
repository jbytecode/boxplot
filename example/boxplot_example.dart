import 'dart:html';
import 'package:boxplot/boxplot.dart';

void main() {
  DivElement mydiv = querySelector("#mydiv");
  /*
  Creating a boxplot with the dimension 500 x 200 in pixels
   */
  BoxPlot boxplot = new BoxPlot(500, 200);

  /*
  Quantiles can be set manually
   */
  boxplot.setQuantiles(
      /* min */
      50,
      /* 25th percentile */ 60,
      /* median */ 70,
      /* 75th percentile */ 80,
      /* max */ 200);

  /*
  Appending drawable component into a div element
   */
  mydiv.append(boxplot.getDrawableComponent());

  /*
  or, quantiles can be estimated using a dataset:
   */
  //boxplot.setQuantilesUsingData(aListOfDoubleValues);

  RangeInputElement myrange = querySelector("#myrange");
  myrange.onInput.listen((event) {
    boxplot.setValue(double.parse(myrange.value));
    boxplot.drawComponent();
  });
}
