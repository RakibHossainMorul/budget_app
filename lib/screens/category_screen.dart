// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:budget_app/helper/helper_color.dart';
import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/widgets/radial_painter.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;

  CategoryScreen(this.category);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    double totalAmountSpend = 0.0;
    for (var expense in widget.category.expenses) {
      totalAmountSpend += expense.cost;
    }
    final double amountLeft = widget.category.maxAmount - totalAmountSpend;
    double percent = amountLeft / widget.category.maxAmount;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.category.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
            iconSize: 30,
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 2),
                        blurRadius: 6.0)
                  ]),
              child: CustomPaint(
                foregroundPainter: RadialPanter(
                    bgColor: Colors.grey.shade200,
                    lineColor: getColor(context, percent),
                    percent: percent,
                    width: 15),
                child: Center(
                    child: Text(
                  "\$${(widget.category.maxAmount - totalAmountSpend).toStringAsFixed(2)} / \$${widget.category.maxAmount.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                )),
              ),
            ),
            _buildCategoryItem()
          ],
        ),
      ),
    );
  }

  _buildCategoryItem() {
    List<Widget> expenseList = [];
    for (var expense in widget.category.expenses) {
      expenseList.add(Container(
        height: 80,
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black45, offset: Offset(0, 2), blurRadius: 6.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                expense.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                expense.cost.toStringAsFixed(2),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ));
    }
    return Column(
      children: expenseList,
    );
  }
}
