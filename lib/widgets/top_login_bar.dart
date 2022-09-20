// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:basalon/services/my_color.dart';
import 'package:flutter/material.dart';

class TopLoginbar extends StatelessWidget {
  const TopLoginbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 15),
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
                    child: Text('+ יצירת פעילות')),
                style: ElevatedButton.styleFrom(
                  primary: MyColors.topOrange,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Image.asset(
                'assets/basalon.png',
                height: 60,
                width: 130,
              )
            ],
          ),
          Row(
            children: [
              Text(
                ' התחברות',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.person,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
