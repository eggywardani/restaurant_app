import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/restaurant_detail.dart';
import 'package:restaurant_app/provider/detail_provider.dart';
import 'package:restaurant_app/provider/post_review_provider.dart';
import 'package:restaurant_app/screens/detail_page.dart';
import 'package:restaurant_app/themes/style.dart';

class PostReviewScreen extends StatefulWidget {
  final Restaurant model;
  PostReviewScreen({required this.model});

  @override
  _PostReviewScreenState createState() => _PostReviewScreenState();
}

class _PostReviewScreenState extends State<PostReviewScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _reviewController = TextEditingController();

  bool isVisibleLoading = false;
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var detailProvider = Provider.of<DetailProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("${widget.model.name}"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  hintText: "Name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _reviewController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  hintText: "Review",
                  prefixIcon: Icon(Icons.reviews),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)))),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: TextButton(
                    onPressed: () {
                      setState(() {
                        isVisibleLoading = !isVisibleLoading;
                      });
                      Provider.of<PostReviewProvider>(context, listen: false)
                          .postReviewRestaurant("${widget.model.id}",
                              _nameController.text, _reviewController.text)
                          .then((value) {
                        detailProvider.update(value.customerReviews);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Review Added")));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(id: "${widget.model.id}"),
                            ));

                        isVisibleLoading = !isVisibleLoading;
                      });
                    },
                    child: Text(
                      'Add Review',
                      style: myTextTheme.button?.copyWith(color: Colors.white),
                    ))),
            SizedBox(
              height: 20,
            ),
            isVisibleLoading
                ? Visibility(
                    visible: true,
                    child: CircularProgressIndicator(
                      color: Colors.blueGrey,
                    ))
                : Visibility(
                    visible: false,
                    child: CircularProgressIndicator(
                      color: Colors.blueGrey,
                    ))
          ],
        ),
      ),
    );
  }
}
