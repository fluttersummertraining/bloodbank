import "package:flutter/material.dart";

class PageSubtitle extends StatelessWidget {
  const PageSubtitle({
    Key? key,
    required this.subtitle,
  }) : super(key: key);

  final String subtitle;
  @override
  Widget build(BuildContext context) {
    return Text(
      subtitle,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }
}

class PageTitle extends StatelessWidget {
  PageTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
