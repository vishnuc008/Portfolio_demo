import 'package:flutter/material.dart';

class KitchenMenuPage extends StatefulWidget {
  const KitchenMenuPage({super.key});

  @override
  State<KitchenMenuPage> createState() => _KitchenMenuPageState();
}

class _KitchenMenuPageState extends State<KitchenMenuPage> {
List<String> containerTypes = ['Container 1', 'Container 2', 'Container 3', 'Container 4', 'Container 5'];
  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;
    return SafeArea(child: Scaffold(
     body: SingleChildScrollView(
      child: Column(
        children: [
          Expanded(
      child: GridView.builder(
        itemCount: containerTypes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 100,
            color: Colors.blue,
            child: Center(
              child: Text(
                containerTypes[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          );
        },
      ),
    ),
        ],
      ),
     ),
    ),);
  }
}