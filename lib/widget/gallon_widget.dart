import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GallonWidget extends StatefulWidget {
  var gallon;

  GallonWidget({Key key, this.gallon}) : super(key: key);

  @override
  _GallonWidgetState createState() => _GallonWidgetState();
}

class _GallonWidgetState extends State<GallonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Stack(
            children: [
              Container(
                child: SvgPicture.asset(
                  'assets/gallon.svg',
                  height: MediaQuery.of(context).size.height * 40 / 100,
                  placeholderBuilder: (BuildContext context) =>
                      Container(child: Text(widget.gallon.label)),
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                    height: ((((MediaQuery.of(context).size.height * 40 / 100) -
                                30) *
                            widget.gallon.volume) /
                        widget.gallon.capacity),
                    width: 100,
                    color: Colors.blue,
                    child: Container()),
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
                  style: TextStyle(color: Color(0xFF000000), fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
