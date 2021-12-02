class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.iconPath = 'assets/images/Device/team.png',

    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String iconPath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/images/Dashboard/client.png',
      iconPath: 'assets/images/Device/team.png',

      titleTxt: 'Humains',
      meals: <String>['Son,', 'Daughter' , '..' ],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/images/Dashboard/dog2.png',
      iconPath: 'assets/images/Device/car.png',

      titleTxt: 'Animals',
      meals: <String>['Rabbit,', 'Dog'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/images/Dashboard/car2.png',
      iconPath: 'assets/images/Device/rabbit.png',

      titleTxt: 'Cars',
      meals: <String>['Car ,', ' Bike '],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/images/Dashboard/obj.png',
      iconPath: 'assets/images/Device/object.png',

      titleTxt: 'Objects',
      meals: <String>['Home,', 'greenhouse,','..'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
