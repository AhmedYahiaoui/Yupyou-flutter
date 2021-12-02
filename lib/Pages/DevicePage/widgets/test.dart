/*


class CardHolder extends StatelessWidget {
  const CardHolder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery
              .of(context)
              .size
              .height - 360, right: 20, left: 20),
      height: 320,
      width: MediaQuery
          .of(context)
          .size
          .width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 10),
          ]),


      child: new Card(),


    );
  }
}



class Card extends StatelessWidget {
  const Card({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          '2948 posts created',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'category ',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 12,
              child: VerticalDivider(
                width: 2,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              '934 Feedback',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.only(left: 20, right: 20, top: 8),
          width: 320,
          height: 200,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 30,
                    spreadRadius: 5)
              ],
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                'Biography',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                  'Contrary to popular belief, Lorem Ipsum is not simply random text It has roots in a piece of classical Latin literature from 45 BC')
            ],
          ),
        ),
      ],
    );
  }
}







 */