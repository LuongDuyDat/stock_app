import 'package:flutter/material.dart';
import 'package:stock_app/util/globals.dart';
import 'package:stock_app/util/string.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.08,
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stockString,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              '${DateTime.now().day} ${month.elementAt(DateTime.now().month)}',
              style: const TextStyle(
                color: Color(0xFF9F9F9F),
                fontWeight: FontWeight.bold,
                fontSize: 27,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              editString,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Container(
                width: double.infinity,
                height: screenHeight * 0.05,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(201, 201, 201, 1),
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.black, size: 20,),
                    hintText: searchString,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  autofocus: false,
                  cursorColor: Colors.blue,
                  onChanged: (text) {
                    //context.read<SearchBloc>().add(SearchWordChange(keyWord: text));
                  },
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

}