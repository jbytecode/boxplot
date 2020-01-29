import "dart:html";

/// Abstract class that defines unimplemented method [getDrawableComponent]
abstract class GuiComponent {

  /// Abstract method that a GUI Component must implement
  HtmlElement getDrawableComponent();
}
