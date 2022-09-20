import 'package:flutter/material.dart';


class SocialProfile extends StatefulWidget {
  const SocialProfile({Key? key}) : super(key: key);

  @override
  _SocialProfileState createState() => _SocialProfileState();
}

class _SocialProfileState extends State<SocialProfile> {

  late double width = MediaQuery.of(context).size.width;

  String dropDownValue = '';
  List<int> socialAddArray = [];

  Widget dropDownOpen() {
    return Container();
    // return DropdownButton(
    //   value: dropDownValue,
    //   items: <String>['asd', 'bad', 'slow'].map((String value) {
    //       return DropdownMenuItem(
    //         value: value,
    //         child: Text(value),
    //       );
    //   }).toList(),
    // );
  }

  Widget addSocial(VoidCallback onTap, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(color: const Color.fromRGBO(216, 216, 216, 1))
                ),
                child: TextField(
                    maxLines: 1,
                    textAlignVertical: TextAlignVertical.top,
                    textAlign: TextAlign.end,
                    //controller: socialText,
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 10, right: 10),
                      hintText: socialAddArray[index].toString(),
                    )
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {


                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: const Color.fromRGBO(216, 216, 216, 1))
                  ),
                  child: TextField(
                      maxLines: 1,
                      enabled: false,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(left: 10),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_drop_down,
                            color: Color.fromRGBO(144, 144, 144, 1),
                          ),
                        ),
                      )
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(233, 108, 96, 1),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: const Center(
                      child: Text('X', textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white
                          )
                      )
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            children: [
              const SizedBox(height: 25),

              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: socialAddArray.length,
                itemBuilder: (context, index) {
                  return addSocial(() {
                    socialAddArray.removeAt(index);
                    setState(() {});
                  }, index);
                },
              ),



              GestureDetector(
                onTap: () {
                  setState(() {
                    socialAddArray.add(socialAddArray.length + 1);
                  });
                },
                child: Container(
                  height: 50,
                  width: width / 2.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(112, 168, 49, 1)
                  ),
                  child: const Center(
                      child: Text('+ Add Social', textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 17)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 80,
                  width: width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromRGBO(112, 168, 49, 1)
                  ),
                  child: const Center(
                      child: Text('Social Update', textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 17)
                      )
                  ),
                ),
              ),
            ]
          )
        ),
      ),
    );
  }
}
