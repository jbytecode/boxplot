![Dart CI](https://github.com/jbytecode/boxplot/workflows/Dart%20CI/badge.svg)

A Boxplot library for Dart developers.

Created by Matletik - Mathematical Manipulatives and Interactive Learning Tools

http://www.matletik.com

![Screenshot](https://github.com/jbytecode/boxplot/raw/master/images/screenshot.png)

## Usage

A simple usage example:

```dart
import 'dart:html';
import 'package:boxplot/box_plot.dart';

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
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Matletik Boxplot for Dart - Example</title>
    <script src = "boxplot_example.dart.js"></script>

    <style>
        div{
            background-color: rgba(255, 255, 255, 0.35);
            font-size: 16px;
            margin: 0 auto;
            valign: middle;
            text-align: center;
        }
        input[type=range]{
            width: 100%;
        }
    </style>
</head>
<body>
<fieldset>
    <caption>Value on the boxplot</caption>
    <input type="range" min="0" max="100" value="65" id="myrange"/>
</fieldset>
<br/>
<div id="mydiv"></div>
</body>
</html>
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
