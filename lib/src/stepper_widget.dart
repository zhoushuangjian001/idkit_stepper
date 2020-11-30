part of idkit_stepper;

class IDKitStepper extends StatefulWidget {
  const IDKitStepper({
    Key key,
    @required this.width,
    @required this.plusChild,
    @required this.reduceChild,
    this.height,
    this.text,
    this.controller,
    this.enableEdit = false,
    this.step = 1,
    this.type = ContourType.bothSides,
    this.minValue = double.negativeInfinity,
    this.maxValue = double.infinity,
    this.bgColor = Colors.transparent,
    this.border,
    this.borderRadius = 0,
    this.dividerChild1,
    this.dividerChild2,
    this.isFloat = true,
    this.style,
  })  : assert(width != null),
        assert(plusChild != null),
        assert(reduceChild != null),
        super(key: key);

  IDKitStepper.routineBuild({
    Key key,
    @required this.width,
    @required double height,
    Color borderColor,
    this.text,
    this.controller,
    this.enableEdit = false,
    this.step = 1,
    this.type = ContourType.bothSides,
    this.minValue = double.negativeInfinity,
    this.maxValue = double.infinity,
    this.bgColor = Colors.transparent,
    this.borderRadius = 0,
    this.isFloat = true,
    this.style,
    TextStyle plusStyle,
    TextStyle reduceStyle,
    EdgeInsets dividerPadding = const EdgeInsets.all(10),
    this.dividerChild2,
  })  : height = height,
        plusChild = Container(
          width: height,
          color: Colors.transparent,
          alignment: Alignment.center,
          padding: dividerPadding,
          child: Text(
            "+",
            style: plusStyle ?? reduceStyle,
          ),
        ),
        reduceChild = Container(
          padding: dividerPadding,
          width: height,
          alignment: Alignment.center,
          color: Colors.transparent,
          child: Text(
            "-",
            style: reduceStyle ?? plusStyle,
          ),
        ),
        dividerChild1 = Container(
          color: borderColor ?? Colors.black,
          width: 1,
        ),
        border = Border.all(color: borderColor ?? Colors.black, width: 1),
        super(key: key);

  /// The [width] is  width of IDKitStepper.
  final double width;

  /// The [height] is  height of IDKitStepper.
  final double height;

  /// The [plusChild] is plus module of IDKitStepper.
  final Widget plusChild;

  /// The [reduceChild] is reduce module of IDKitStepper.
  final Widget reduceChild;

  /// The [text] is default text of middle textfield in IDKitStepper.
  final String text;

  /// The [controller] is text control of middle textfield in IDKitStepper.
  final TextEditingController controller;

  /// The [enableEdit] is state of middle textfield edit in IDKitStepper.
  final bool enableEdit;

  /// The [step] is step length of IDKitStepper.
  final double step;

  /// The [type] is presentation style of IDKitStepper.
  final ContourType type;

  /// The [minValue] is minimum value that can be displayed of IDKitStepper.
  final double minValue;

  /// The [maxValue] is maximum value that can be displayed of IDKitStepper.
  final double maxValue;

  /// The [bgColor] is background of IDKitStepper.
  final Color bgColor;

  /// The [border] is border of IDKitStepper.
  final BoxBorder border;

  /// The [borderRadius] is borderRadius of IDKitStepper.
  final double borderRadius;

  /// The [dividerChild1] is dividerChild1 module of IDKitStepper.
  final Widget dividerChild1;

  /// The [dividerChild2] is dividerChild2 module of IDKitStepper.
  final Widget dividerChild2;

  /// The [isFloat] is Whether to display configuration parameters of floating point numbers about IDKitStepper.
  final bool isFloat;

  /// The [style] is configuration parameters of middle textfield style.
  final TextStyle style;

  @override
  _IDKitStepperState createState() => _IDKitStepperState();
}

class _IDKitStepperState extends State<IDKitStepper> {
  List<Widget> _list;
  TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        TextEditingController(
            text: widget.text ?? (widget.isFloat ? "0.0" : "0"));
    _layoutItems();
  }

  void _layoutItems() {
    switch (widget.type) {
      case ContourType.bothSides:
        if (widget.dividerChild1 != null || widget.dividerChild2 != null) {
          _list = [
            gestureBuild(
                widget.reduceChild, () => _addAndSubtractEvents(false)),
            widget.dividerChild1 ?? widget.dividerChild2,
            Expanded(
              child: stepperTextField(),
            ),
            widget.dividerChild2 ?? widget.dividerChild1,
            gestureBuild(widget.plusChild, () => _addAndSubtractEvents(true)),
          ];
        } else {
          _list = [
            gestureBuild(
                widget.reduceChild, () => _addAndSubtractEvents(false)),
            Expanded(
              child: stepperTextField(),
            ),
            gestureBuild(widget.plusChild, () => _addAndSubtractEvents(true)),
          ];
        }
        break;
      case ContourType.rightSides:
        if (widget.dividerChild1 != null && widget.dividerChild2 != null) {
          _list = [
            Expanded(
              child: stepperTextField(),
            ),
            widget.dividerChild1,
            gestureBuild(
                widget.reduceChild, () => _addAndSubtractEvents(false)),
            widget.dividerChild2,
            gestureBuild(widget.plusChild, () => _addAndSubtractEvents(true)),
          ];
        } else if (widget.dividerChild1 != null ||
            widget.dividerChild2 != null) {
          _list = [
            Expanded(
              child: stepperTextField(),
            ),
            widget.dividerChild1 ?? widget.dividerChild2,
            gestureBuild(
                widget.reduceChild, () => _addAndSubtractEvents(false)),
            gestureBuild(widget.plusChild, () => _addAndSubtractEvents(true)),
          ];
        } else {
          _list = [
            Expanded(
              child: stepperTextField(),
            ),
            gestureBuild(
                widget.reduceChild, () => _addAndSubtractEvents(false)),
            gestureBuild(widget.plusChild, () => _addAndSubtractEvents(true)),
          ];
        }

        break;
      default:
        _list = [];
    }
  }

  void _addAndSubtractEvents(bool type) {
    var _curText = _controller?.text;
    var _numText = double.tryParse(_curText) ?? 0.0;
    var _resutText = _numText + (type ? 1 : -1) * widget.step;
    if (type ? _resutText > widget.maxValue : _resutText < widget.minValue)
      return;
    _controller.text = widget.isFloat
        ? _resutText.toStringAsFixed(_getLegthOfDecimal(widget.step))
        : _resutText.toInt().toString();
  }

  int _getLegthOfDecimal(num value) {
    if (num is int) {
      return 0;
    }
    var _decimal = value.toString().split(".").last;
    return _decimal.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.bgColor,
        border: widget.border,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      width: widget.width,
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _list,
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget stepperTextField() {
    return TextField(
      textAlign: TextAlign.center,
      enabled: widget.enableEdit,
      controller: _controller,
      style: widget.style,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}

///
Widget gestureBuild(Widget child, Function call) {
  return GestureDetector(
    child: child,
    onTap: call,
  );
}

enum ContourType { bothSides, rightSides }
