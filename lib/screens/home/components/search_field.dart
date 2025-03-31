import 'package:flutter/material.dart';

//import '../../../constants.dart';
import '../../../global/size_config.dart';
import '../../../styles/colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.6,
      decoration: BoxDecoration(
        //color: bSecondaryColor.withOpacity(0.1),
        color: white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        onChanged: (value) => print(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(9)),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "ค้นหาชื่องานทั้งหมด",
            prefixIcon: Icon(Icons.search)),
      ),
    );
  }
}
