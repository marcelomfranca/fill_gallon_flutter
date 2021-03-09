import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecipientType {
  static const gallon = 'gallon';
  static const bottle = 'bottle';
}

class RecipientWidget extends StatefulWidget {
  String objectType;
  var object;
  var width;
  var height;
  EdgeInsets padding;

  RecipientWidget(
      {Key key,
      this.width,
      this.height,
      this.object,
      this.objectType,
      this.padding})
      : super(key: key);

  @override
  _RecipientWidgetState createState() => _RecipientWidgetState();
}

class _RecipientWidgetState extends State<RecipientWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.padding =
        (widget.padding == null) ? EdgeInsets.all(0) : widget.padding;

    var ret;

    if (widget.object == null) {
      ret = Container(
        child: Text(''),
      );
    }

    ret = _create();

    return Padding(
      padding: widget.padding,
      child: ret,
    );
  }

  Widget _create() {
    var width = (MediaQuery.of(context).size.width / 8) - 13;
    var height = ((MediaQuery.of(context).size.height * 15) / 100) - 46;

    width = (widget.width != null) ? widget.width : width;
    height = (widget.height != null) ? widget.height : height;

    height = (height * widget.object.volume) / widget.object.capacity;
    height = (height < 1) ? 1 : height;

    if (widget.object.capacity > 0) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: width,
        child: Stack(
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'assets/bottle.svg',
                //height: MediaQuery.of(context).size.height * 10 / 100,
                width: width,
                placeholderBuilder: (BuildContext context) =>
                    Container(child: Text(widget.object.label)),
              ),
            ),
            Visibility(
              visible: (widget.object.volume > 0.0),
              child: Positioned(
                bottom: 0.0,
                child: Container(
                    height: height,
                    width: width,
                    color: Colors.blue,
                    child: Container()),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    widget.object.label +
                        '\n' +
                        (((widget.object.volume < widget.object.capacity) &&
                                widget.object.volume > 0)
                            ? widget.object.volume.toString() + 'l'
                            : ''),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF000000), fontSize: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Stack(
      children: [
        Container(
          child: SvgPicture.asset(
            'assets/bottle.svg',
            //height: MediaQuery.of(context).size.height * 40 / 100,
            //height: height,
            width: width,
            color: Colors.black12,
            placeholderBuilder: (BuildContext context) =>
                Container(child: Text('')),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Text(
                'tap to create a ' + widget.objectType,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black45, fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
