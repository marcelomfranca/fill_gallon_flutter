import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GallonWidget extends StatefulWidget {
  var gallon;
  var update;

  GallonWidget({Key key, this.gallon, this.update}) : super(key: key);

  @override
  _GallonWidgetState createState() => _GallonWidgetState();
}

class _GallonWidgetState extends State<GallonWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.gallon != null) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  child: SvgPicture.asset(
                    'assets/bottle.svg',
                    height: MediaQuery.of(context).size.height * 40 / 100,
                    //color: (widget.gallon.isEmpty) ? Colors.black12 : null,
                    placeholderBuilder: (BuildContext context) =>
                        Container(child: Text(widget.gallon.label)),
                  ),
                ),
                Visibility(
                  visible: (widget.gallon.volume > 0.0),
                  child: Positioned.fill(
                    bottom: 0.0,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          height: ((((MediaQuery.of(context).size.height *
                                          40 /
                                          100) -
                                      65) *
                                  widget.gallon.volume) /
                              widget.gallon.capacity),
                          color: Colors.blue,
                          child: Container()),
                    ),
                  ),
                ),
              ],
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    widget.gallon.label,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF000000), fontSize: 36),
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
            height: MediaQuery.of(context).size.height * 40 / 100,
            //width: MediaQuery.of(context).size.width * 40 / 100,
            color: Colors.black12,
            placeholderBuilder: (BuildContext context) =>
                Container(child: Text('')),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: (MediaQuery.of(context).size.width * 30) / 100,
              child: Text(
                'tap to create a gallon',
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
