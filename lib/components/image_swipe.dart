import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imagesList;
  const ImageSwipe({Key? key, required this.imagesList}) : super(key: key);

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        height: 300.0,
        child:
            // Hero(
            // tag: 'bookImage',
            // child:
            Stack(
          children: [
            PageView(
              onPageChanged: (num) {
                setState(() {
                  _selectedPage = num;
                });
              },
              children: [
                for (int i = 0; i < widget.imagesList.length; i++)
                  Container(
                    height: 100.0,
                    child: Image.network(
                      // snapshot.data?.data()?['images'][0],
                      "${widget.imagesList[i]}",
                      fit: BoxFit.contain,
                    ),
                  )
              ],
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 20.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < widget.imagesList.length; i++)
                    AnimatedContainer(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                      ),
                      margin: EdgeInsets.all(5.0),
                      width: _selectedPage == i ? 35.0 : 10.0,
                      height: 8.0,
                      duration: Duration(
                        milliseconds: 300,
                      ),
                      curve: Curves.easeOutCubic,
                    ),
                ],
              ),
            ),
          ],
        ),
        // ),
      ),
    );
  }
}
