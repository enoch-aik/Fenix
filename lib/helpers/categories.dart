class Category {
  List images = [
    "apartment.png",
    "newCar.png",
    "electronics.png",
    "clothing.png",
    "kids.png",
    "food png.png",
    "kids.png",
    "tools.png",
  ];

  List homeCategories = [
    "Dacha",
    "Apartment",
    "House",
    "Car",
    "Electronics",
  ];

  List allCategories = [
    {"name": "Property"},
    {"name": "Car"},
    {"name": "Electronics"},
    {"name": "Clothing"},
    {"name": "Health Care"},
    {"name": "Food Market"},
    {"name": "Kids"},
  ];

  List property = [
    "Dacha",
    "Apartment",
    "House",
  ];

  List propertyCategory = [
    {"name": "Apartment",
      "image": "apartmentc.png"
    },
    {"name": "House",
      "image": "house.png"
    },
    {"name": "Dacha",
      "image": "dachac.png"
    }
  ];

  List carCategories = [
    {
      "name": "Cars",
      "image": "carsale.png"
    },
    {
      "name": "Car Parts",
      "image": "carparts.png",
      "products": ["Body Parts", "Engine Parts", "Tire", "Others"]
    },
    {
      "name": "Car Interior",
      "image": "carinterior.png",
      "products": ["Body Paint", "Car Accessory", "Others"]
    }
  ];

  //
  // List carPart = [
  //   "Body Parts",
  //   "Engine Parts",
  //   "Tire",
  //   "Others",
  // ];
  //
  // List carInterior = [
  //   "Body Paint",
  //   "Car Accessory",
  //   "Others",
  // ];

  List clothing = [
    {
      'name': "T-Shirt",
    },
    {
      'name': "Shirt",
    },
    {
      'name': "Trousers",
    },
    {
      'name': "Jacket",
    },
    {
      'name': "Pants",
    },
    {
      'name': "Skirts",
    },
    {
      'name': "Dresses",
    },
    {
      'name': "Pants",
    },
    {
      'name': "Face Care",
    },
    {
      'name': "Shoes",
    },
    {
      'name': "Tracksuit",
    },
    {
      'name': "Body Care",
    },
    {
      'name': "Accessories",
    },
    {
      'name': "Others",
    },
    // {
    //   "sub_category": [
    //     "Male"
    //         "Female"
    //   ],
    //   "products": [
    //     "T-Shirt",
    //     "Shirt",
    //     "Trousers",
    //     "Jacket",
    //     "Pants",
    //     "Skirts",
    //     "Dresses",
    //     "Pants",
    //     "Face Care",
    //     "Shoes",
    //     "Tracksuit",
    //     "Body Care",
    //     "Accessories",
    //     "Others",
    //   ],
    //   "color": [
    //     "Red",
    //     "Blue"
    //         "Orange"
    //         "Yello"
    //         "Green"
    //         "Purple"
    //         "White"
    //         "Mauve"
    //         "Magenta"
    //         "LightBlue"
    //         "Lime"
    //         "Lemon"
    //         "Pearl"
    //         "Orchid"
    //         "Navy Blue"
    //         "Tan"
    //         "Brown"
    //         "Wine"
    //         "Silver"
    //         "Light green"
    //         "Grey"
    //         "Gold"
    //         "Lilac"
    //         "Fuchsia"
    //         "Carrot"
    //         "Azure"
    //   ],
    //   "condition": ["New", "Used"],
    //   "brand": ["", "Used"],
    //   "size": [
    //     "Small S",
    //     "Medium M",
    //     "Large L",
    //     "Extra Large XL",
    //     "XXL",
    //     "XXXL",
    //     "XXXXL"
    //   ],
    // }
  ];

  // List male = [
  //   "T-Shirt",
  //   "Shirt",
  //   "Trousers",
  //   "Jacket",
  //   "Pants",
  //   "Shoes",
  //   "Tracksuit",
  //   "Body Care",
  //   "Accessories",
  //   "Others",
  // ];
  //
  // List female = [
  //   "Tops",
  //   "Skirts",
  //   "Dresses",
  //   "Pants",
  //   "Shoes",
  //   "Tracksuit",
  //   "Body Care",
  //   "Face Care",
  //   "Accessories",
  //   "Others",
  // ];

  List healthCare = [
    // {
    //   "sub_category": [
    {
      "name": "Vitamins & Supplements",
    },
    {
      "name": "Body Care",
    },
    {
      "name": "Kids Vitamins",
    },
    {
      "name": "Face Care",
      "products": [
        "Face Mask",
        "Face Therapy",
        "Hair Care",
        "Kids Vitamins",
        "Others",
      ]
    },
    {
      "name": "Hair Care",
      "products": [
        "Shampoo and conditioner",
        "Hair Spray",
        "Hair Color",
        "Others",
      ]
    },
    {
      "name": "Others",
    },
    // ]
    // },
  ];

  // List faceCare = [
  //   "Face Mask",
  //   "Face Therapy",
  //   "Hair Care",
  //   "Kids Vitamins",
  //   "Others",
  // ];
  //
  // List hairCare = [
  //   "Shampoo and conditioner",
  //   "Hair Spray",
  //   "Hair Color",
  //   "Others",
  // ];

  List foodMarket = [
    {
      "name": "Dry Fruit",
    },
    {
      "name": "Tea",
    },
    {
      "name": "Coffee",
    },
    {
      "name": "Frozen Foods",
    },
    {
      "name": "Snacks",
    },
    {
      "name": "Others",
    },
  ];

  List kids = [
    {
      "name": "Boy",
      "products": [
        "Shoes",
        "T-Shirt",
        "Pants",
        "Accessories",
        "Others",
      ]
    },
    {
      "name": "Girl",
      "products": [
        "T-Shirt",
        "Dresses",
        "Shoes",
        "Pants",
        "Accessories",
        "Others",
      ]
    },
    {
      "name": "Baby",
      "products": [
        "Baby Formula",
        "Baby Care",
        "Baby Diapers",
        "Others",
      ]
    },
    {
      "name": "Kid Toys",
      "products": [
        "Male Toys",
        "Female Toys",
        "Others",
      ]
    },
  ];

  List tools = [
    {
      "name": "Garden Tools",
    },
    {
      "name": "Backyard needs",
    },
    {
      "name": "Others",
    }
  ];

  List electronics = [
    {
      "name": "Laptop",
      "products": [
        "Apple",
        "Asus",
        "Samsung",
        "LG",
        "Sony",
        "Xiaomi",
        "Lenovo",
        "Acer",
        "MSI",
        "Alienware",
        "Microsoft",
        "Acer",
        "Dell",
        "Others",
      ]
    },
    {
      "name": "Cellphones and Accessories",
      "cell phones": [
        {
          'brand': "Apple",
          'model': [
            "Iphone 14 Pro Max",
            "Iphone 14 Pro",
            "Iphone 14 Plus",
            "Iphone 14",
            "Iphone 13 Pro Max",
            "Iphone 13 Pro",
            "Iphone 14 Mini",
            "Iphone 13",
            "Iphone 12 Pro Max",
            "Iphone 12 Pro",
            "Iphone 12 Mini",
            "Iphone 12",
            "Iphone 11 Pro Max",
            "Iphone 11 Pro",
            "Iphone 11",
            "Iphone SE (2nd Gen)",
            "Iphone X",
            "Iphone 8/8 plus",
            "Iphone 7/7 plus",
            "Iphone 6s/6s plus",
            "Iphone 6/6 plus",
            "Iphone SE (1st Gen)",
            "Iphone 5/4/3 ",
            "Other",
          ],
        },
        {
          'brand': "Samsung",
          'model': [
            "Galaxy S23 Ultra",
            "Galaxy S23+",
            "Galaxy A23 5G",
            "Galaxy A14 5G",
            "Galaxy XCover6 Pro",
            "Galaxy Z Fold 4",
            "Galaxy Flip4",
            "Galaxy Z Flip4 Bespoke Edition",
            "Galaxy S22",
            "Galaxy S21 FE 5G",
            "Galaxy S22 Ultra",
            "Galaxy S21 5G",
            "Galaxy A12",
            "Other",
          ],
        },
        {
          'brand': "Sony",
          'model': [
            "Xperia 5 IV",
            "Xperia 1 IV",
            "Xperia 10 IV",
            "Other",
          ],
        },
        {
          'brand': "HTC",
          'model': [],
        },
        {
          'brand': "Nokia",
          'model': [],
        },
        {
          'brand': "Sony Ericsson",
          'model': [],
        },
        {
          'brand': "Xiaomi",
          'model': [],
        },
        {
          'brand': "Oppo",
          'model': [],
        },
        {
          'brand': "Huawei",
          'model': [],
        },
        {
          'brand': "Vivo",
          'model': [],
        },
        {
          'brand': "Artel",
          'model': [],
        },
        {
          'brand': "ZTE",
          'model': [],
        },
        {
          'brand': "Other",
          'model': [],
        },
      ],
      "accessories": [
        {
          "type": "Phones Case",
          'brand': [
            "Apple",
            "Samsung",
            "Xiaomi",
            "Other",
          ],
        },
        {
          "type": "Tablet Case",
          'brand': [
            "Apple",
            "Samsung",
            "Xiaomi",
            "Other",
          ],
        },
        {
          "type": "Laptop Case",
          'brand': [
            "Apple",
            "HP",
            "Microsoft",
            "Dell",
            "Acer",
            "Lenovo",
            "Other",
          ],
        },
        {
          "type": "Phone Charger",
          'brand': [
            "Apple",
            "Samsung",
            "Xiaomi",
            "Other",
          ],
        },
        {
          "type": "Laptop Charger",
          'brand': [
            "Apple",
            "HP",
            "Microsoft",
            "Dell",
            "Acer",
            "Lenovo",
            "Other",
          ],
        },
        {
          "type": "Headphones",
          'brand': [
            "Apple",
            "Samsung",
            "Sony",
            "Beats by Dre",
            "Other",
          ],
        },
        {
          "type": "Microphone & Mic",
          'brand': [
            "Samsung",
            "Sony",
            "Blue Pro",
            "Other",
          ],
        },
      ],
    },
    {
      "name": "TVs",
      "products": [
        "Apple Box",
        "Samsung",
        "Sony",
        "Artel",
        "Xioami",
        "TV box",
        "Others",
      ]
    },
    {
      "name": "Home Electronics",
      "products": [
        "Refrigerator",
        "Freezer",
        "Microwave",
        "Washing Machine",
        "Clothes Dryer",
        "Kitchen Stove",
        "Mixer",
        "Blender",
        "Coffee Machine",
        "Artel Electronics",
        "Security Camera",
        "Others",
      ]
    },
    {
      "name": "GPS",
      "products": [
        "Garmin",
        "Sammsung",
        "Others",
      ]
    },
    {
      "name": "Smart Watch",
      "products": [
        "Apple",
        "Samsung",
        "Sony",
        "Xiaomi",
        "Smart Watch",
        "Others",
      ]
    },
    {
      "name": "Audio, Music & Mic",
    },
    {
      "name": "Tablet",
      "products": [
        "Apple"
            "Samsung",
        "LG",
        "Sony",
        "Microsoft",
        "Xiaomi",
        "Artel",
        "Others",
      ]
    },
    {
      "name": "Camera & Photo",
      "products": [
        "Canon",
        "Go Pro",
        "Sony",
        "Samsung",
        "DJI",
        "Selfie Stick",
        "Others",
      ]
    },
    {
      "name": "PC & Gaming",
      "products": [
        "Asus",
        "Alienware",
        "Razer",
        "MSI",
        "Dell",
        "Web Camera",
        "PC Graphics Card",
        "Computer Mother Board",
        "Mouse a& Keyboard",
        "Speaker",
        "Headphones",
        "Microphone",
        "Others",
      ]
    }
  ];
}
