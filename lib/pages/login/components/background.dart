import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String topImage;
  final String bottomImage;

  const Background({
    Key? key,
    required this.child,
    this.topImage = "assets/icons/wave.svg",
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child:  Transform.translate(
                offset: const Offset(-90,-100),
                child:  Transform.rotate(
                  angle: 0 * 3.141592653589793 / 180, 
                  child:  SvgPicture.asset(topImage, width: 1000)
                ),
              )
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Transform.translate(
                offset: const Offset(80,100),
                child:  Transform.rotate(
                  angle: 180 * 3.141592653589793 / 180, 
                  child:  SvgPicture.asset(topImage, width: 1000)
                ),
              )
            ),
            SafeArea(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
