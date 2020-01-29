import 'dart:html';
import 'package:boxplot/boxplot.dart';

void main() {
  DivElement mydiv = querySelector("#mydiv");
  BoxPlot boxplot = new BoxPlot(500, 200);
  boxplot.setQuantiles(0, 30, 60, 86, 100);
  mydiv.append(boxplot.getDrawableComponent());


  RangeInputElement myrange = querySelector("#myrange");
  myrange.onInput.listen((event) {
    boxplot.setValue(double.parse(myrange.value));
    boxplot.drawComponent();
  });
}
