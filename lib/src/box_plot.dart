/*
 *
 boxplot, A Dart library for Box plot tool.
 Copyright (C) 2020-2021  Matletik - Mathematical Manipulatives and Interactive Learning Tools
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU Lesser General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 any later version.
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 You should have received a copy of the GNU Lesser General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * Matletik - Mathematical Manipulatives and Interactive Learning Tools
 * http://www.matletik.com
 */

import 'dart:html';
import 'dart:math' as Math;
import 'gui_component.dart';

/// Canvas based BoxPlot GUI Component
class BoxPlot extends GuiComponent {
  /// Width and height of component in pixels
  int width, height;

  /// Canvas element to draw
  CanvasElement canvas;

  /// The 2D rendering Context
  CanvasRenderingContext2D g2;

  /// Basic statistics to draw boxplot
  double min, max, q1, q2, q3, value;

  /// Virtual cartesian dimensions for drawing
  double minx, miny, maxx, maxy;

  /// Color of the boxplot
  String boxPlotcolor = '#fed8b1';

  /// Color of the ball which defines a single observation given by [value]
  String ballColor = 'rgba(0, 0, 255, 0.50)';

  /// Font size and name for axes labels
  String font = '14px Monospace';

  /// True if mouse entered on the plot
  bool mouseEntered = false;

  /// Mouse event for controlling mouse entering in the plot
  MouseEvent mouseEvent;

  /// The constructor
  BoxPlot(int widthInPixels, int heightInPixels) {
    width = widthInPixels;
    height = heightInPixels;
    canvas = CanvasElement();
    canvas.style.border = '1px solid black';
    canvas.width = widthInPixels;
    canvas.height = heightInPixels;
    g2 = canvas.getContext('2d');
    setDimensions(-10, 110, -11, 11);
    canvas.onMouseEnter.listen((Event e) {
      mouseEntered = true;
    });
    canvas.onMouseOut.listen((Event e) {
      mouseEntered = false;
      drawComponent();
    });
    canvas.onMouseMove.listen((MouseEvent e) {
      mouseEvent = e;
      drawComponent();
    });
    setDefaultQuantiles();
  }

  /// Sets the default statistics
  void setDefaultQuantiles() {
    min = 0;
    max = 100;
    q1 = 25;
    q2 = 50;
    q3 = 75;
    value = 65;
  }

  /// Returns the statistics as a Map
  Map<String, double> getDefaultQuantiles() {
    Map<String, double> quantiles = Map<String, double>();
    quantiles['min'] = min;
    quantiles['max'] = max;
    quantiles['q1'] = q1;
    quantiles['q2'] = q2;
    quantiles['q3'] = q3;
    quantiles['value'] = value;
    return quantiles;
  }

  /// Changes the ball of [value] color
  void setBallColor(String colorCode) {
    ballColor = colorCode;
  }

  /// Gets the color of ball which in the coordinate of [value]
  String getBallColor() {
    return ballColor;
  }

  /// Changes the axis font
  void setFont(String font) {
    this.font = font;
  }

  /// Returns the current axis font
  String getFont() {
    return font;
  }

  /// Sets the current location of the ball displayed in the plot
  void setValue(double value) {
    this.value = value;
  }

  /// Returns the coordinate of ball
  double getValue() {
    return value;
  }

  /// Sets the basic statistics as a list
  /// Elements are ordered as [min], [q1], [q2], [q3], and [max]
  void setQuantilesWithList(List<double> values) {
    min = values[0];
    q1 = values[1];
    q2 = values[2];
    q3 = values[3];
    max = values[4];
  }

  /// Sets the basic statistics as single arguments for each
  void setQuantiles(double min, double q1, double q2, double q3, double max) {
    setQuantilesWithList([min, q1, q2, q3, max]);
  }

  /// Sets dimensions of the virtual cartesian
  void setDimensions(double minx, double maxx, double miny, double maxy) {
    this.minx = minx;
    this.maxx = maxx;
    this.miny = miny;
    this.maxy = maxy;
  }

  /// Translate the y coordinate from virtual cartesian to real coordinates.
  double translateY(double y) {
    return -(miny + y) * height / (maxy - miny);
  }

  /// Translate the x coordinate from virtual cartesian to real coordinates.
  double translateX(double x) {
    return (x - minx) * width / (maxx - minx);
  }

  /// Translate the x coordinate from real coordinates to virtual cartesian.
  double retranslateX(double x) {
    return ((x * (maxx - minx)) + (width * minx)) / width;
  }

  /// Translate the y coordinate from real coordinates to virtual cartesian.
  double retranslateY(double y) {
    return (-1) * (y * (maxy - miny) + (miny * height)) / (height);
  }

  /// Refreshes the content of the component
  void drawComponent() {
    g2.fillStyle = boxPlotcolor;
    g2.strokeStyle = 'black';

    g2.resetTransform();
    g2.clearRect(0, 0, width, height);

    // Draw Axes
    g2.beginPath();
    g2.moveTo(translateX(0), translateY(2));
    g2.lineTo(translateX(100), translateY(2));
    g2.closePath();
    g2.stroke();

    //Draw minx
    g2.beginPath();
    g2.moveTo(translateX(min), translateY(-2));
    g2.lineTo(translateX(min), translateY(6));
    g2.closePath();
    g2.stroke();

    //Draw maxx
    g2.beginPath();
    g2.moveTo(translateX(max), translateY(-2));
    g2.lineTo(translateX(max), translateY(6));
    g2.closePath();
    g2.stroke();

    // Box
    g2.beginPath();
    g2.moveTo(translateX(q1), translateY(-2));
    g2.lineTo(translateX(q1), translateY(6));
    g2.lineTo(translateX(q3), translateY(6));
    g2.lineTo(translateX(q3), translateY(-2));
    g2.closePath();
    g2.fillStyle = 'white';
    g2.fill();
    g2.fillStyle = boxPlotcolor;
    g2.fill();
    g2.stroke();

    // Median
    g2.beginPath();
    g2.moveTo(translateX(q2), translateY(-2));
    g2.lineTo(translateX(q2), translateY(6));
    g2.closePath();
    g2.stroke();

    g2.font = '14px Monospace';
    g2.fillStyle = 'black';

    // Axis labels
    for (double i = 0; i <= 100; i += 10) {
      g2.fillText(i.toString(), translateX(i - 2), translateY(-10));
    }

    //ticks
    double linewidth = 1.0;
    for (int i = 0; i <= 100; i += 10) {
      g2.beginPath();
      if ((i % 10) == 0) {
        linewidth = 1.0;
      } else {
        linewidth = 0.5;
      }
      g2.moveTo(translateX(i.toDouble()), translateY(-5.5 - linewidth));
      g2.lineTo(translateX(i.toDouble()), translateY(-5.5 + linewidth));
      g2.closePath();
      g2.stroke();
    }

    // the line above the numbers
    g2.beginPath();
    g2.moveTo(translateX(0), translateY(-4.6));
    g2.lineTo(translateX(100), translateY(-4.6));
    g2.closePath();
    g2.strokeStyle = 'black';
    g2.lineWidth = 0.5;
    g2.stroke();

    //Where is mouse
    if (mouseEntered) {
      double x = mouseEvent.client.x - canvas.getBoundingClientRect().left;
      double y = mouseEvent.client.y - canvas.getBoundingClientRect().top;
      g2.beginPath();
      g2.rect(x, y, 50, 15);
      g2.closePath();
      g2.fillStyle = 'rgba(0,0,255,0.25)';
      g2.strokeStyle = 'black';
      g2.fill();
      g2.stroke();

      g2.font = '12px Monospace';
      g2.fillStyle = 'black';
      g2.fillText(retranslateX(x).toStringAsFixed(2), x + 10, y + 12);
    }

    // Ball point
    g2.beginPath();
    g2.arc(translateX(value), translateY(2), 5, 0.0, 2.0 * Math.pi, false);
    g2.closePath();
    g2.fillStyle = 'white';
    g2.fill();
    g2.fillStyle = ballColor;
    g2.fill();
    g2.strokeStyle = 'black';
    g2.stroke();
  }

  @override
  HtmlElement getDrawableComponent() {
    drawComponent();
    return canvas;
  }
}
