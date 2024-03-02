import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class MainUserCard extends StatefulWidget {
   const MainUserCard(
      {super.key, this.img, this.name, this.categories, this.onUserImgTap});
  final img;
  final name;
  final categories;
  final onUserImgTap;

  @override
  State<MainUserCard> createState() => _MainUserCardState();
}

class _MainUserCardState extends State<MainUserCard> {

  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(bottom: 25),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(4292214271),
                Color(4288538110),
                Color(4289505535),
                Color(4289494015),
                Color(4289494015),
                Color(4289491966),
                Color(4289491966),
              ],
            ),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 8,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: InkWell(
                  onTap: widget.onUserImgTap,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                          color: Colors.black, // Change color as needed
                          width: 1,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(
                          widget.img,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
             Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    (widget.categories.length / 3).ceil(),
                    (index) {
                      final startIndex = index * 3;
                      final endIndex = (index + 1) * 3;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = startIndex; i < endIndex; i++)
                            if (i < widget.categories.length) ...[
                              Directionality(
                                textDirection: box.read('locale') == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons
                                          .circle, // You can change this to any desired icon
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '${widget.categories[i]}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 16, // Increased text size
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width:
                                      10), // Adjust the spacing between categories
                            ],
                        ],
                      );
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


