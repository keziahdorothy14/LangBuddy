import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:math';

const Map<String, String> ttsLanguages = {
  "English": "en-US",
  "French": "fr-FR",
  "Spanish": "es-ES",
  "Hindi": "hi-IN",
  "German": "de-DE",
  "Italian": "it-IT",
  "Portuguese": "pt-PT",
  "Russian": "ru-RU",
  "Chinese": "zh-CN",
  "Japanese": "ja-JP",
  "Korean": "ko-KR",

  // Others
  "Dutch": "nl-NL",
  "Turkish": "tr-TR",
  "Vietnamese": "vi-VN",
  "Indonesian": "id-ID",
};

Future<void> speak(String text, String language) async {
  final tts = FlutterTts();

  // Get the device-supported languages
  List<dynamic> availableLanguages = await tts.getLanguages;

  // Use the requested language code
  String langCode = ttsLanguages[language] ?? "en-US";

  // Fallback if not available
  if (!availableLanguages.contains(langCode)) {
    print("Language $language not supported. Falling back to English.");
    langCode = "en-US";
  }

  await tts.setLanguage(langCode);
  await tts.setSpeechRate(0.45);
  await tts.setPitch(1.0);

  await tts.speak(text);
}
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool('isDarkMode') ?? false;
  themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;

  runApp(const LangBuddyApp());
}


/* ================= APP ROOT ================= */

class LangBuddyApp extends StatelessWidget {
  const LangBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,  // Listen to the themeNotifier
      builder: (context, currentMode, child) {
        return MaterialApp(
          title: 'LangBuddy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),       // Light theme
          darkTheme: ThemeData.dark(),    // Dark theme
          themeMode: currentMode,         // Dynamically controlled
          home: const HomeScreen(),
        );
      },
    );
  }
}

/* ================= DATA ================= */

final List<Map<String, dynamic>> vocabularyData = [
  {
    "word": "Apple",
    "translations": {
      "English": "Apple",
      "French": "Pomme",
      "Spanish": "Manzana",
      "Hindi": "सेब",
      "German": "Apfel",
      "Italian": "Mela",
      "Portuguese": "Maçã",
      "Russian": "Яблоко",
      "Chinese": "苹果",
      "Japanese": "りんご",
      "Korean": "사과",
      "Dutch": "Appel",
      "Turkish": "Elma",
      "Vietnamese": "Táo",
      "Indonesian": "Apel"
    }
  },
  {
    "word": "Book",
    "translations": {
      "English": "Book",
      "French": "Livre",
      "Spanish": "Libro",
      "Hindi": "किताब",
      "German": "Buch",
      "Italian": "Libro",
      "Portuguese": "Livro",
      "Russian": "Книга",
      "Chinese": "书",
      "Japanese": "本",
      "Korean": "책",
      "Dutch": "Boek",
      "Turkish": "Kitap",
      "Vietnamese": "Sách",
      "Indonesian": "Buku"
    }
  },
  {
    "word": "Water",
    "translations": {
      "English": "Water",
      "French": "Eau",
      "Spanish": "Agua",
      "Hindi": "पानी",
      "German": "Wasser",
      "Italian": "Acqua",
      "Portuguese": "Água",
      "Russian": "Вода",
      "Chinese": "水",
      "Japanese": "水",
      "Korean": "물",
      "Dutch": "Water",
      "Turkish": "Su",
      "Vietnamese": "Nước",
      "Indonesian": "Air"
    }
  },
  {
    "word": "House",
    "translations": {
      "English": "House",
      "French": "Maison",
      "Spanish": "Casa",
      "Hindi": "घर",
      "German": "Haus",
      "Italian": "Casa",
      "Portuguese": "Casa",
      "Russian": "Дом",
      "Chinese": "房子",
      "Japanese": "家",
      "Korean": "집",
      "Dutch": "Huis",
      "Turkish": "Ev",
      "Vietnamese": "Nhà",
      "Indonesian": "Rumah"
    }
  },
  {
    "word": "Food",
    "translations": {
      "English": "Food",
      "French": "Nourriture",
      "Spanish": "Comida",
      "Hindi": "भोजन",
      "German": "Essen",
      "Italian": "Cibo",
      "Portuguese": "Comida",
      "Russian": "Еда",
      "Chinese": "食物",
      "Japanese": "食べ物",
      "Korean": "음식",
      "Dutch": "Eten",
      "Turkish": "Yemek",
      "Vietnamese": "Thức ăn",
      "Indonesian": "Makanan"
    }
  },
  {
    "word": "School",
    "translations": {
      "English": "School",
      "French": "École",
      "Spanish": "Escuela",
      "Hindi": "स्कूल",
      "German": "Schule",
      "Italian": "Scuola",
      "Portuguese": "Escola",
      "Russian": "Школа",
      "Chinese": "学校",
      "Japanese": "学校",
      "Korean": "학교",
      "Dutch": "School",
      "Turkish": "Okul",
      "Vietnamese": "Trường",
      "Indonesian": "Sekolah"
    }
  },
  {
    "word": "Car",
    "translations": {
      "English": "Car",
      "French": "Voiture",
      "Spanish": "Coche",
      "Hindi": "कार",
      "German": "Auto",
      "Italian": "Auto",
      "Portuguese": "Carro",
      "Russian": "Машина",
      "Chinese": "汽车",
      "Japanese": "車",
      "Korean": "자동차",
      "Dutch": "Auto",
      "Turkish": "Araba",
      "Vietnamese": "Xe hơi",
      "Indonesian": "Mobil"
    }
  },
  {
    "word": "Sun",
    "translations": {
      "English": "Sun",
      "French": "Soleil",
      "Spanish": "Sol",
      "Hindi": "सूरज",
      "German": "Sonne",
      "Italian": "Sole",
      "Portuguese": "Sol",
      "Russian": "Солнце",
      "Chinese": "太阳",
      "Japanese": "太陽",
      "Korean": "태양",
      "Dutch": "Zon",
      "Turkish": "Güneş",
      "Vietnamese": "Mặt trời",
      "Indonesian": "Matahari"
    }
  },
  {
    "word": "Tree",
    "translations": {
      "English": "Tree",
      "French": "Arbre",
      "Spanish": "Árbol",
      "Hindi": "पेड़",
      "German": "Baum",
      "Italian": "Albero",
      "Portuguese": "Árvore",
      "Russian": "Дерево",
      "Chinese": "树",
      "Japanese": "木",
      "Korean": "나무",
      "Dutch": "Boom",
      "Turkish": "Ağaç",
      "Vietnamese": "Cây",
      "Indonesian": "Pohon"
    }
  },
  {
    "word": "Friend",
    "translations": {
      "English": "Friend",
      "French": "Ami",
      "Spanish": "Amigo",
      "Hindi": "दोस्त",
      "German": "Freund",
      "Italian": "Amico",
      "Portuguese": "Amigo",
      "Russian": "Друг",
      "Chinese": "朋友",
      "Japanese": "友達",
      "Korean": "친구",
      "Dutch": "Vriend",
      "Turkish": "Arkadaş",
      "Vietnamese": "Bạn bè",
      "Indonesian": "Teman"
    }
  },
  {
    "word": "City",
    "translations": {
      "English": "City",
      "French": "Ville",
      "Spanish": "Ciudad",
      "Hindi": "शहर",
      "German": "Stadt",
      "Italian": "Città",
      "Portuguese": "Cidade",
      "Russian": "Город",
      "Chinese": "城市",
      "Japanese": "都市",
      "Korean": "도시",
      "Dutch": "Stad",
      "Turkish": "Şehir",
      "Vietnamese": "Thành phố",
      "Indonesian": "Kota"
    }
  },
  {
    "word": "Love",
    "translations": {
      "English": "Love",
      "French": "Amour",
      "Spanish": "Amor",
      "Hindi": "प्यार",
      "German": "Liebe",
      "Italian": "Amore",
      "Portuguese": "Amor",
      "Russian": "Любовь",
      "Chinese": "爱",
      "Japanese": "愛",
      "Korean": "사랑",
      "Dutch": "Liefde",
      "Turkish": "Aşk",
      "Vietnamese": "Tình yêu",
      "Indonesian": "Cinta"
    }
  },
  {
    "word": "Dog",
    "translations": {
      "English": "Dog",
      "French": "Chien",
      "Spanish": "Perro",
      "Hindi": "कुत्ता",
      "German": "Hund",
      "Italian": "Cane",
      "Portuguese": "Cão",
      "Russian": "Собака",
      "Chinese": "狗",
      "Japanese": "犬",
      "Korean": "개",
      "Dutch": "Hond",
      "Turkish": "Köpek",
      "Vietnamese": "Chó",
      "Indonesian": "Anjing"
    }
  },
  {
    "word": "Cat",
    "translations": {
      "English": "Cat",
      "French": "Chat",
      "Spanish": "Gato",
      "Hindi": "बिल्ली",
      "German": "Katze",
      "Italian": "Gatto",
      "Portuguese": "Gato",
      "Russian": "Кошка",
      "Chinese": "猫",
      "Japanese": "猫",
      "Korean": "고양이",
      "Dutch": "Kat",
      "Turkish": "Kedi",
      "Vietnamese": "Mèo",
      "Indonesian": "Kucing"
    }
  },
  {
    "word": "Chair",
    "translations": {
      "English": "Chair",
      "French": "Chaise",
      "Spanish": "Silla",
      "Hindi": "कुर्सी",
      "German": "Stuhl",
      "Italian": "Sedia",
      "Portuguese": "Cadeira",
      "Russian": "Стул",
      "Chinese": "椅子",
      "Japanese": "椅子",
      "Korean": "의자",
      "Dutch": "Stoel",
      "Turkish": "Sandalye",
      "Vietnamese": "Ghế",
      "Indonesian": "Kursi"
    }
  },
  {
    "word": "Table",
    "translations": {
      "English": "Table",
      "French": "Table",
      "Spanish": "Mesa",
      "Hindi": "मेज़",
      "German": "Tisch",
      "Italian": "Tavolo",
      "Portuguese": "Mesa",
      "Russian": "Стол",
      "Chinese": "桌子",
      "Japanese": "テーブル",
      "Korean": "테이블",
      "Dutch": "Tafel",
      "Turkish": "Masa",
      "Vietnamese": "Bàn",
      "Indonesian": "Meja"
    }
  },
  {
    "word": "Milk",
    "translations": {
      "English": "Milk",
      "French": "Lait",
      "Spanish": "Leche",
      "Hindi": "दूध",
      "German": "Milch",
      "Italian": "Latte",
      "Portuguese": "Leite",
      "Russian": "Молоко",
      "Chinese": "牛奶",
      "Japanese": "牛乳",
      "Korean": "우유",
      "Dutch": "Melk",
      "Turkish": "Süt",
      "Vietnamese": "Sữa",
      "Indonesian": "Susu"
    }
  },
  {
    "word": "Bread",
    "translations": {
      "English": "Bread",
      "French": "Pain",
      "Spanish": "Pan",
      "Hindi": "रोटी",
      "German": "Brot",
      "Italian": "Pane",
      "Portuguese": "Pão",
      "Russian": "Хлеб",
      "Chinese": "面包",
      "Japanese": "パン",
      "Korean": "빵",
      "Dutch": "Brood",
      "Turkish": "Ekmek",
      "Vietnamese": "Bánh mì",
      "Indonesian": "Roti"
    }
  },
  {
    "word": "Road",
    "translations": {
      "English": "Road",
      "French": "Route",
      "Spanish": "Carretera",
      "Hindi": "सड़क",
      "German": "Straße",
      "Italian": "Strada",
      "Portuguese": "Estrada",
      "Russian": "Дорога",
      "Chinese": "道路",
      "Japanese": "道路",
      "Korean": "도로",
      "Dutch": "Weg",
      "Turkish": "Yol",
      "Vietnamese": "Đường",
      "Indonesian": "Jalan"
    }
  },
  {
    "word": "Window",
    "translations": {
      "English": "Window",
      "French": "Fenêtre",
      "Spanish": "Ventana",
      "Hindi": "खिड़की",
      "German": "Fenster",
      "Italian": "Finestra",
      "Portuguese": "Janela",
      "Russian": "Окно",
      "Chinese": "窗户",
      "Japanese": "窓",
      "Korean": "창문",
      "Dutch": "Raam",
      "Turkish": "Pencere",
      "Vietnamese": "Cửa sổ",
      "Indonesian": "Jendela"
    }
  },
  {
    "word": "Door",
    "translations": {
      "English": "Door",
      "French": "Porte",
      "Spanish": "Puerta",
      "Hindi": "दरवाज़ा",
      "German": "Tür",
      "Italian": "Porta",
      "Portuguese": "Porta",
      "Russian": "Дверь",
      "Chinese": "门",
      "Japanese": "ドア",
      "Korean": "문",
      "Dutch": "Deur",
      "Turkish": "Kapı",
      "Vietnamese": "Cửa",
      "Indonesian": "Pintu"
    }
  },
  {
    "word": "Pen",
    "translations": {
      "English": "Pen",
      "French": "Stylo",
      "Spanish": "Pluma",
      "Hindi": "कलम",
      "German": "Stift",
      "Italian": "Penna",
      "Portuguese": "Caneta",
      "Russian": "Ручка",
      "Chinese": "笔",
      "Japanese": "ペン",
      "Korean": "펜",
      "Dutch": "Pen",
      "Turkish": "Kalem",
      "Vietnamese": "Bút",
      "Indonesian": "Pulpen"
    }
  },
  {
    "word": "Chairman",
    "translations": {
      "English": "Chairman",
      "French": "Président",
      "Spanish": "Presidente",
      "Hindi": "अध्यक्ष",
      "German": "Vorsitzender",
      "Italian": "Presidente",
      "Portuguese": "Presidente",
      "Russian": "Председатель",
      "Chinese": "主席",
      "Japanese": "議長",
      "Korean": "회장",
      "Dutch": "Voorzitter",
      "Turkish": "Başkan",
      "Vietnamese": "Chủ tịch",
      "Indonesian": "Ketua"
    }
  },
  {
    "word": "Schoolbag",
    "translations": {
      "English": "Schoolbag",
      "French": "Cartable",
      "Spanish": "Mochila",
      "Hindi": "स्कूल बैग",
      "German": "Schultasche",
      "Italian": "Zaino",
      "Portuguese": "Mochila",
      "Russian": "Рюкзак",
      "Chinese": "书包",
      "Japanese": "スクールバッグ",
      "Korean": "책가방",
      "Dutch": "Schooltas",
      "Turkish": "Okul çantası",
      "Vietnamese": "Cặp sách",
      "Indonesian": "Tas sekolah"
    }
  },
  {
    "word": "Chairperson",
    "translations": {
      "English": "Chairperson",
      "French": "Présidente",
      "Spanish": "Presidenta",
      "Hindi": "अध्यक्ष",
      "German": "Vorsitzende",
      "Italian": "Presidente",
      "Portuguese": "Presidente",
      "Russian": "Председатель",
      "Chinese": "主席",
      "Japanese": "議長",
      "Korean": "회장",
      "Dutch": "Voorzitter",
      "Turkish": "Başkan",
      "Vietnamese": "Chủ tịch",
      "Indonesian": "Ketua"
    }
  },
  {
    "word": "Computer",
    "translations": {
      "English": "Computer",
      "French": "Ordinateur",
      "Spanish": "Computadora",
      "Hindi": "कंप्यूटर",
      "German": "Computer",
      "Italian": "Computer",
      "Portuguese": "Computador",
      "Russian": "Компьютер",
      "Chinese": "电脑",
      "Japanese": "コンピュータ",
      "Korean": "컴퓨터",
      "Dutch": "Computer",
      "Turkish": "Bilgisayar",
      "Vietnamese": "Máy tính",
      "Indonesian": "Komputer"
    }
  },
  {
    "word": "Phone",
    "translations": {
      "English": "Phone",
      "French": "Téléphone",
      "Spanish": "Teléfono",
      "Hindi": "फ़ोन",
      "German": "Telefon",
      "Italian": "Telefono",
      "Portuguese": "Telefone",
      "Russian": "Телефон",
      "Chinese": "电话",
      "Japanese": "電話",
      "Korean": "전화",
      "Dutch": "Telefoon",
      "Turkish": "Telefon",
      "Vietnamese": "Điện thoại",
      "Indonesian": "Telepon"
    }
  },
  {
    "word": "Bag",
    "translations": {
      "English": "Bag",
      "French": "Sac",
      "Spanish": "Bolsa",
      "Hindi": "बैग",
      "German": "Tasche",
      "Italian": "Borsa",
      "Portuguese": "Saco",
      "Russian": "Сумка",
      "Chinese": "包",
      "Japanese": "バッグ",
      "Korean": "가방",
      "Dutch": "Tas",
      "Turkish": "Çanta",
      "Vietnamese": "Túi",
      "Indonesian": "Tas"
    }
  },
  {
    "word": "Shoes",
    "translations": {
      "English": "Shoes",
      "French": "Chaussures",
      "Spanish": "Zapatos",
      "Hindi": "जूते",
      "German": "Schuhe",
      "Italian": "Scarpe",
      "Portuguese": "Sapatos",
      "Russian": "Обувь",
      "Chinese": "鞋",
      "Japanese": "靴",
      "Korean": "신발",
      "Dutch": "Schoenen",
      "Turkish": "Ayakkabı",
      "Vietnamese": "Giày",
      "Indonesian": "Sepatu"
    }
  },
  {
    "word": "Hat",
    "translations": {
      "English": "Hat",
      "French": "Chapeau",
      "Spanish": "Sombrero",
      "Hindi": "टोपी",
      "German": "Hut",
      "Italian": "Cappello",
      "Portuguese": "Chapéu",
      "Russian": "Шляпа",
      "Chinese": "帽子",
      "Japanese": "帽子",
      "Korean": "모자",
      "Dutch": "Hoed",
      "Turkish": "Şapka",
      "Vietnamese": "Mũ",
      "Indonesian": "Topi"
    }
  },
  {
    "word": "Bagpack",
    "translations": {
      "English": "Bagpack",
      "French": "Sac à dos",
      "Spanish": "Mochila",
      "Hindi": "बैग पैक",
      "German": "Rucksack",
      "Italian": "Zaino",
      "Portuguese": "Mochila",
      "Russian": "Рюкзак",
      "Chinese": "背包",
      "Japanese": "バックパック",
      "Korean": "배낭",
      "Dutch": "Rugzak",
      "Turkish": "Sırt çantası",
      "Vietnamese": "Balo",
      "Indonesian": "Ransel"
    }
  },
  {
    "word": "Bottle",
    "translations": {
      "English": "Bottle",
      "French": "Bouteille",
      "Spanish": "Botella",
      "Hindi": "बोतल",
      "German": "Flasche",
      "Italian": "Bottiglia",
      "Portuguese": "Garrafa",
      "Russian": "Бутылка",
      "Chinese": "瓶子",
      "Japanese": "ボトル",
      "Korean": "병",
      "Dutch": "Fles",
      "Turkish": "Şişe",
      "Vietnamese": "Chai",
      "Indonesian": "Botol"
    }
  },
  {
    "word": "Bagel",
    "translations": {
      "English": "Bagel",
      "French": "Bagel",
      "Spanish": "Bagel",
      "Hindi": "बागेल",
      "German": "Bagel",
      "Italian": "Bagel",
      "Portuguese": "Bagel",
      "Russian": "Бублик",
      "Chinese": "贝果",
      "Japanese": "ベーグル",
      "Korean": "베이글",
      "Dutch": "Bagel",
      "Turkish": "Simit",
      "Vietnamese": "Bánh vòng",
      "Indonesian": "Roti bulat"
    }
  },
  {
    "word": "Ball",
    "translations": {
      "English": "Ball",
      "French": "Balle",
      "Spanish": "Pelota",
      "Hindi": "गेंद",
      "German": "Ball",
      "Italian": "Palla",
      "Portuguese": "Bola",
      "Russian": "Мяч",
      "Chinese": "球",
      "Japanese": "ボール",
      "Korean": "공",
      "Dutch": "Bal",
      "Turkish": "Top",
      "Vietnamese": "Bóng",
      "Indonesian": "Bola"
    }
  },
  {
    "word": "Clock",
    "translations": {
      "English": "Clock",
      "French": "Horloge",
      "Spanish": "Reloj",
      "Hindi": "घड़ी",
      "German": "Uhr",
      "Italian": "Orologio",
      "Portuguese": "Relógio",
      "Russian": "Часы",
      "Chinese": "时钟",
      "Japanese": "時計",
      "Korean": "시계",
      "Dutch": "Klok",
      "Turkish": "Saat",
      "Vietnamese": "Đồng hồ",
      "Indonesian": "Jam"
    }
  },
  {
    "word": "Key",
    "translations": {
      "English": "Key",
      "French": "Clé",
      "Spanish": "Llave",
      "Hindi": "चाबी",
      "German": "Schlüssel",
      "Italian": "Chiave",
      "Portuguese": "Chave",
      "Russian": "Ключ",
      "Chinese": "钥匙",
      "Japanese": "鍵",
      "Korean": "열쇠",
      "Dutch": "Sleutel",
      "Turkish": "Anahtar",
      "Vietnamese": "Chìa khóa",
      "Indonesian": "Kunci"
    }
  },
  {
    "word": "Bagel",
    "translations": {
      "English": "Bagel",
      "French": "Bagel",
      "Spanish": "Bagel",
      "Hindi": "बागेल",
      "German": "Bagel",
      "Italian": "Bagel",
      "Portuguese": "Bagel",
      "Russian": "Бублик",
      "Chinese": "贝果",
      "Japanese": "ベーグル",
      "Korean": "베이글",
      "Dutch": "Bagel",
      "Turkish": "Simit",
      "Vietnamese": "Bánh vòng",
      "Indonesian": "Roti bulat"
    }
  },
  {
    "word": "Knife",
    "translations": {
      "English": "Knife",
      "French": "Couteau",
      "Spanish": "Cuchillo",
      "Hindi": "चाकू",
      "German": "Messer",
      "Italian": "Coltello",
      "Portuguese": "Faca",
      "Russian": "Нож",
      "Chinese": "刀",
      "Japanese": "ナイフ",
      "Korean": "칼",
      "Dutch": "Mes",
      "Turkish": "Bıçak",
      "Vietnamese": "Dao",
      "Indonesian": "Pisau"
    }
  },
  {
    "word": "Spoon",
    "translations": {
      "English": "Spoon",
      "French": "Cuillère",
      "Spanish": "Cuchara",
      "Hindi": "चम्मच",
      "German": "Löffel",
      "Italian": "Cucchiaio",
      "Portuguese": "Colher",
      "Russian": "Ложка",
      "Chinese": "勺子",
      "Japanese": "スプーン",
      "Korean": "숟가락",
      "Dutch": "Lepel",
      "Turkish": "Kaşık",
      "Vietnamese": "Muỗng",
      "Indonesian": "Sendok"
    }
  },
  {
    "word": "Fork",
    "translations": {
      "English": "Fork",
      "French": "Fourchette",
      "Spanish": "Tenedor",
      "Hindi": "काँटा",
      "German": "Gabel",
      "Italian": "Forchetta",
      "Portuguese": "Garfo",
      "Russian": "Вилка",
      "Chinese": "叉子",
      "Japanese": "フォーク",
      "Korean": "포크",
      "Dutch": "Vork",
      "Turkish": "Çatal",
      "Vietnamese": "Nĩa",
      "Indonesian": "Garpu"
    }
  },
  {
    "word": "Plate",
    "translations": {
      "English": "Plate",
      "French": "Assiette",
      "Spanish": "Plato",
      "Hindi": "प्लेट",
      "German": "Teller",
      "Italian": "Piatto",
      "Portuguese": "Prato",
      "Russian": "Тарелка",
      "Chinese": "盘子",
      "Japanese": "皿",
      "Korean": "접시",
      "Dutch": "Bord",
      "Turkish": "Tabak",
      "Vietnamese": "Đĩa",
      "Indonesian": "Piring"
    }
  },
  {
    "word": "Bag",
    "translations": {
      "English": "Bag",
      "French": "Sac",
      "Spanish": "Bolsa",
      "Hindi": "बैग",
      "German": "Tasche",
      "Italian": "Borsa",
      "Portuguese": "Saco",
      "Russian": "Сумка",
      "Chinese": "包",
      "Japanese": "バッグ",
      "Korean": "가방",
      "Dutch": "Tas",
      "Turkish": "Çanta",
      "Vietnamese": "Túi",
      "Indonesian": "Tas"
    }
  },
  {
    "word": "Pen",
    "translations": {
      "English": "Pen",
      "French": "Stylo",
      "Spanish": "Pluma",
      "Hindi": "कलम",
      "German": "Stift",
      "Italian": "Penna",
      "Portuguese": "Caneta",
      "Russian": "Ручка",
      "Chinese": "笔",
      "Japanese": "ペン",
      "Korean": "펜",
      "Dutch": "Pen",
      "Turkish": "Kalem",
      "Vietnamese": "Bút",
      "Indonesian": "Pulpen"
    }
  },
  {
    "word": "Notebook",
    "translations": {
      "English": "Notebook",
      "French": "Cahier",
      "Spanish": "Cuaderno",
      "Hindi": "किताब",
      "German": "Notizbuch",
      "Italian": "Quaderno",
      "Portuguese": "Caderno",
      "Russian": "Блокнот",
      "Chinese": "笔记本",
      "Japanese": "ノート",
      "Korean": "노트",
      "Dutch": "Schrift",
      "Turkish": "Defter",
      "Vietnamese": "Vở",
      "Indonesian": "Buku catatan"
    }
  },
  {
    "word": "Clock",
    "translations": {
      "English": "Clock",
      "French": "Horloge",
      "Spanish": "Reloj",
      "Hindi": "घड़ी",
      "German": "Uhr",
      "Italian": "Orologio",
      "Portuguese": "Relógio",
      "Russian": "Часы",
      "Chinese": "时钟",
      "Japanese": "時計",
      "Korean": "시계",
      "Dutch": "Klok",
      "Turkish": "Saat",
      "Vietnamese": "Đồng hồ",
      "Indonesian": "Jam"
    }
  },
  {
    "word": "Window",
    "translations": {
      "English": "Window",
      "French": "Fenêtre",
      "Spanish": "Ventana",
      "Hindi": "खिड़की",
      "German": "Fenster",
      "Italian": "Finestra",
      "Portuguese": "Janela",
      "Russian": "Окно",
      "Chinese": "窗户",
      "Japanese": "窓",
      "Korean": "창문",
      "Dutch": "Raam",
      "Turkish": "Pencere",
      "Vietnamese": "Cửa sổ",
      "Indonesian": "Jendela"
    }
  },
  {
    "word": "Door",
    "translations": {
      "English": "Door",
      "French": "Porte",
      "Spanish": "Puerta",
      "Hindi": "दरवाज़ा",
      "German": "Tür",
      "Italian": "Porta",
      "Portuguese": "Porta",
      "Russian": "Дверь",
      "Chinese": "门",
      "Japanese": "ドア",
      "Korean": "문",
      "Dutch": "Deur",
      "Turkish": "Kapı",
      "Vietnamese": "Cửa",
      "Indonesian": "Pintu"
    }
  },
  {
    "word": "Bed",
    "translations": {
      "English": "Bed",
      "French": "Lit",
      "Spanish": "Cama",
      "Hindi": "बिस्तर",
      "German": "Bett",
      "Italian": "Letto",
      "Portuguese": "Cama",
      "Russian": "Кровать",
      "Chinese": "床",
      "Japanese": "ベッド",
      "Korean": "침대",
      "Dutch": "Bed",
      "Turkish": "Yatak",
      "Vietnamese": "Giường",
      "Indonesian": "Tempat tidur"
    }
  },
  {
    "word": "Chair",
    "translations": {
      "English": "Chair",
      "French": "Chaise",
      "Spanish": "Silla",
      "Hindi": "कुर्सी",
      "German": "Stuhl",
      "Italian": "Sedia",
      "Portuguese": "Cadeira",
      "Russian": "Стул",
      "Chinese": "椅子",
      "Japanese": "椅子",
      "Korean": "의자",
      "Dutch": "Stoel",
      "Turkish": "Sandalye",
      "Vietnamese": "Ghế",
      "Indonesian": "Kursi"
    }
  },
  {
    "word": "Table",
    "translations": {
      "English": "Table",
      "French": "Table",
      "Spanish": "Mesa",
      "Hindi": "मेज़",
      "German": "Tisch",
      "Italian": "Tavolo",
      "Portuguese": "Mesa",
      "Russian": "Стол",
      "Chinese": "桌子",
      "Japanese": "テーブル",
      "Korean": "테이블",
      "Dutch": "Tafel",
      "Turkish": "Masa",
      "Vietnamese": "Bàn",
      "Indonesian": "Meja"
    }
  },
  {
    "word": "Computer",
    "translations": {
      "English": "Computer",
      "French": "Ordinateur",
      "Spanish": "Computadora",
      "Hindi": "कंप्यूटर",
      "German": "Computer",
      "Italian": "Computer",
      "Portuguese": "Computador",
      "Russian": "Компьютер",
      "Chinese": "电脑",
      "Japanese": "コンピュータ",
      "Korean": "컴퓨터",
      "Dutch": "Computer",
      "Turkish": "Bilgisayar",
      "Vietnamese": "Máy tính",
      "Indonesian": "Komputer"
    }
  },
  {
    "word": "Phone",
    "translations": {
      "English": "Phone",
      "French": "Téléphone",
      "Spanish": "Teléfono",
      "Hindi": "फ़ोन",
      "German": "Telefon",
      "Italian": "Telefono",
      "Portuguese": "Telefone",
      "Russian": "Телефон",
      "Chinese": "电话",
      "Japanese": "電話",
      "Korean": "전화",
      "Dutch": "Telefoon",
      "Turkish": "Telefon",
      "Vietnamese": "Điện thoại",
      "Indonesian": "Telepon"
    }
  },
  {
    "word": "Television",
    "translations": {
      "English": "Television",
      "French": "Télévision",
      "Spanish": "Televisión",
      "Hindi": "टेलीविजन",
      "German": "Fernseher",
      "Italian": "Televisione",
      "Portuguese": "Televisão",
      "Russian": "Телевизор",
      "Chinese": "电视",
      "Japanese": "テレビ",
      "Korean": "텔레비전",
      "Dutch": "Televisie",
      "Turkish": "Televizyon",
      "Vietnamese": "Tivi",
      "Indonesian": "Televisi"
    }
  },
  {
    "word": "Fridge",
    "translations": {
      "English": "Fridge",
      "French": "Réfrigérateur",
      "Spanish": "Refrigerador",
      "Hindi": "फ्रिज़",
      "German": "Kühlschrank",
      "Italian": "Frigorifero",
      "Portuguese": "Geladeira",
      "Russian": "Холодильник",
      "Chinese": "冰箱",
      "Japanese": "冷蔵庫",
      "Korean": "냉장고",
      "Dutch": "Koelkast",
      "Turkish": "Buzdolabı",
      "Vietnamese": "Tủ lạnh",
      "Indonesian": "Kulkas"
    }
  },
  {
    "word": "Oven",
    "translations": {
      "English": "Oven",
      "French": "Four",
      "Spanish": "Horno",
      "Hindi": "ओवन",
      "German": "Ofen",
      "Italian": "Forno",
      "Portuguese": "Forno",
      "Russian": "Духовка",
      "Chinese": "烤箱",
      "Japanese": "オーブン",
      "Korean": "오븐",
      "Dutch": "Oven",
      "Turkish": "Fırın",
      "Vietnamese": "Lò nướng",
      "Indonesian": "Oven"
    }
  },
  {
    "word": "Chair",
    "translations": {
      "English": "Chair",
      "French": "Chaise",
      "Spanish": "Silla",
      "Hindi": "कुर्सी",
      "German": "Stuhl",
      "Italian": "Sedia",
      "Portuguese": "Cadeira",
      "Russian": "Стул",
      "Chinese": "椅子",
      "Japanese": "椅子",
      "Korean": "의자",
      "Dutch": "Stoel",
      "Turkish": "Sandalye",
      "Vietnamese": "Ghế",
      "Indonesian": "Kursi"
    }
  },
  {
    "word": "Table",
    "translations": {
      "English": "Table",
      "French": "Table",
      "Spanish": "Mesa",
      "Hindi": "मेज़",
      "German": "Tisch",
      "Italian": "Tavolo",
      "Portuguese": "Mesa",
      "Russian": "Стол",
      "Chinese": "桌子",
      "Japanese": "テーブル",
      "Korean": "테이블",
      "Dutch": "Tafel",
      "Turkish": "Masa",
      "Vietnamese": "Bàn",
      "Indonesian": "Meja"
    }
  },
  {
    "word": "Chairperson",
    "translations": {
      "English": "Chairperson",
      "French": "Présidente",
      "Spanish": "Presidenta",
      "Hindi": "अध्यक्ष",
      "German": "Vorsitzende",
      "Italian": "Presidente",
      "Portuguese": "Presidente",
      "Russian": "Председатель",
      "Chinese": "主席",
      "Japanese": "議長",
      "Korean": "회장",
      "Dutch": "Voorzitter",
      "Turkish": "Başkan",
      "Vietnamese": "Chủ tịch",
      "Indonesian": "Ketua"
    }
  },
  {
    "word": "Bagpack",
    "translations": {
      "English": "Bagpack",
      "French": "Sac à dos",
      "Spanish": "Mochila",
      "Hindi": "बैग पैक",
      "German": "Rucksack",
      "Italian": "Zaino",
      "Portuguese": "Mochila",
      "Russian": "Рюкзак",
      "Chinese": "背包",
      "Japanese": "バックパック",
      "Korean": "배낭",
      "Dutch": "Rugzak",
      "Turkish": "Sırt çantası",
      "Vietnamese": "Balo",
      "Indonesian": "Ransel"
    }
  },
  {
    "word": "Bottle",
    "translations": {
      "English": "Bottle",
      "French": "Bouteille",
      "Spanish": "Botella",
      "Hindi": "बोतल",
      "German": "Flasche",
      "Italian": "Bottiglia",
      "Portuguese": "Garrafa",
      "Russian": "Бутылка",
      "Chinese": "瓶子",
      "Japanese": "ボトル",
      "Korean": "병",
      "Dutch": "Fles",
      "Turkish": "Şişe",
      "Vietnamese": "Chai",
      "Indonesian": "Botol"
    }
  },
  {
    "word": "Knife",
    "translations": {
      "English": "Knife",
      "French": "Couteau",
      "Spanish": "Cuchillo",
      "Hindi": "चाकू",
      "German": "Messer",
      "Italian": "Coltello",
      "Portuguese": "Faca",
      "Russian": "Нож",
      "Chinese": "刀",
      "Japanese": "ナイフ",
      "Korean": "칼",
      "Dutch": "Mes",
      "Turkish": "Bıçak",
      "Vietnamese": "Dao",
      "Indonesian": "Pisau"
    }
  },
  {
    "word": "Ball",
    "translations": {
      "English": "Ball",
      "French": "Balle",
      "Spanish": "Pelota",
      "Hindi": "गेंद",
      "German": "Ball",
      "Italian": "Palla",
      "Portuguese": "Bola",
      "Russian": "Мяч",
      "Chinese": "球",
      "Japanese": "ボール",
      "Korean": "공",
      "Dutch": "Bal",
      "Turkish": "Top",
      "Vietnamese": "Bóng",
      "Indonesian": "Bola"
    }
  },
  {
    "word": "Glasses",
    "translations": {
      "English": "Glasses",
      "French": "Lunettes",
      "Spanish": "Gafas",
      "Hindi": "चश्मा",
      "German": "Brille",
      "Italian": "Occhiali",
      "Portuguese": "Óculos",
      "Russian": "Очки",
      "Chinese": "眼镜",
      "Japanese": "メガネ",
      "Korean": "안경",
      "Dutch": "Bril",
      "Turkish": "Gözlük",
      "Vietnamese": "Kính",
      "Indonesian": "Kacamata"
    }
  },
  {
    "word": "Shoes",
    "translations": {
      "English": "Shoes",
      "French": "Chaussures",
      "Spanish": "Zapatos",
      "Hindi": "जूते",
      "German": "Schuhe",
      "Italian": "Scarpe",
      "Portuguese": "Sapatos",
      "Russian": "Обувь",
      "Chinese": "鞋",
      "Japanese": "靴",
      "Korean": "신발",
      "Dutch": "Schoenen",
      "Turkish": "Ayakkabı",
      "Vietnamese": "Giày",
      "Indonesian": "Sepatu"
    }
  },
  {
    "word": "Hat",
    "translations": {
      "English": "Hat",
      "French": "Chapeau",
      "Spanish": "Sombrero",
      "Hindi": "टोपी",
      "German": "Hut",
      "Italian": "Cappello",
      "Portuguese": "Chapéu",
      "Russian": "Шляпа",
      "Chinese": "帽子",
      "Japanese": "帽子",
      "Korean": "모자",
      "Dutch": "Hoed",
      "Turkish": "Şapka",
      "Vietnamese": "Mũ",
      "Indonesian": "Topi"
    }
  },
  {
    "word": "Clothes",
    "translations": {
      "English": "Clothes",
      "French": "Vêtements",
      "Spanish": "Ropa",
      "Hindi": "कपड़े",
      "German": "Kleidung",
      "Italian": "Vestiti",
      "Portuguese": "Roupas",
      "Russian": "Одежда",
      "Chinese": "衣服",
      "Japanese": "服",
      "Korean": "옷",
      "Dutch": "Kleding",
      "Turkish": "Giysi",
      "Vietnamese": "Quần áo",
      "Indonesian": "Pakaian"
    }
  },
  {
    "word": "School",
    "translations": {
      "English": "School",
      "French": "École",
      "Spanish": "Escuela",
      "Hindi": "स्कूल",
      "German": "Schule",
      "Italian": "Scuola",
      "Portuguese": "Escola",
      "Russian": "Школа",
      "Chinese": "学校",
      "Japanese": "学校",
      "Korean": "학교",
      "Dutch": "School",
      "Turkish": "Okul",
      "Vietnamese": "Trường",
      "Indonesian": "Sekolah"
    }
  },
  {
    "word": "Teacher",
    "translations": {
      "English": "Teacher",
      "French": "Professeur",
      "Spanish": "Profesor",
      "Hindi": "शिक्षक",
      "German": "Lehrer",
      "Italian": "Insegnante",
      "Portuguese": "Professor",
      "Russian": "Учитель",
      "Chinese": "老师",
      "Japanese": "先生",
      "Korean": "선생님",
      "Dutch": "Leraar",
      "Turkish": "Öğretmen",
      "Vietnamese": "Giáo viên",
      "Indonesian": "Guru"
    }
  },
  {
    "word": "Student",
    "translations": {
      "English": "Student",
      "French": "Étudiant",
      "Spanish": "Estudiante",
      "Hindi": "छात्र",
      "German": "Student",
      "Italian": "Studente",
      "Portuguese": "Estudante",
      "Russian": "Студент",
      "Chinese": "学生",
      "Japanese": "学生",
      "Korean": "학생",
      "Dutch": "Student",
      "Turkish": "Öğrenci",
      "Vietnamese": "Học sinh",
      "Indonesian": "Siswa"
    }
  },
  {
    "word": "Airport",
    "translations": {
      "English": "Airport",
      "French": "Aéroport",
      "Spanish": "Aeropuerto",
      "Hindi": "हवाई अड्डा",
      "German": "Flughafen",
      "Italian": "Aeroporto",
      "Portuguese": "Aeroporto",
      "Russian": "Аэропорт",
      "Chinese": "机场",
      "Japanese": "空港",
      "Korean": "공항",
      "Dutch": "Vliegveld",
      "Turkish": "Havalimanı",
      "Vietnamese": "Sân bay",
      "Indonesian": "Bandara"
    }
  },
  {
    "word": "Bakery",
    "translations": {
      "English": "Bakery",
      "French": "Boulangerie",
      "Spanish": "Panadería",
      "Hindi": "बेकरी",
      "German": "Bäckerei",
      "Italian": "Panetteria",
      "Portuguese": "Padaria",
      "Russian": "Пекарня",
      "Chinese": "面包店",
      "Japanese": "パン屋",
      "Korean": "빵집",
      "Dutch": "Bakkerij",
      "Turkish": "Fırın",
      "Vietnamese": "Tiệm bánh",
      "Indonesian": "Toko roti"
    }
  },
  {
    "word": "Bicycle",
    "translations": {
      "English": "Bicycle",
      "French": "Vélo",
      "Spanish": "Bicicleta",
      "Hindi": "साइकिल",
      "German": "Fahrrad",
      "Italian": "Bicicletta",
      "Portuguese": "Bicicleta",
      "Russian": "Велосипед",
      "Chinese": "自行车",
      "Japanese": "自転車",
      "Korean": "자전거",
      "Dutch": "Fiets",
      "Turkish": "Bisiklet",
      "Vietnamese": "Xe đạp",
      "Indonesian": "Sepeda"
    }
  },
  {
    "word": "Bridge",
    "translations": {
      "English": "Bridge",
      "French": "Pont",
      "Spanish": "Puente",
      "Hindi": "पुल",
      "German": "Brücke",
      "Italian": "Ponte",
      "Portuguese": "Ponte",
      "Russian": "Мост",
      "Chinese": "桥",
      "Japanese": "橋",
      "Korean": "다리",
      "Dutch": "Brug",
      "Turkish": "Köprü",
      "Vietnamese": "Cầu",
      "Indonesian": "Jembatan"
    }
  },
  {
    "word": "Bus",
    "translations": {
      "English": "Bus",
      "French": "Bus",
      "Spanish": "Autobús",
      "Hindi": "बस",
      "German": "Bus",
      "Italian": "Autobus",
      "Portuguese": "Ônibus",
      "Russian": "Автобус",
      "Chinese": "公共汽车",
      "Japanese": "バス",
      "Korean": "버스",
      "Dutch": "Bus",
      "Turkish": "Otobüs",
      "Vietnamese": "Xe buýt",
      "Indonesian": "Bus"
    }
  },
  {
    "word": "Camera",
    "translations": {
      "English": "Camera",
      "French": "Appareil photo",
      "Spanish": "Cámara",
      "Hindi": "कैमरा",
      "German": "Kamera",
      "Italian": "Fotocamera",
      "Portuguese": "Câmera",
      "Russian": "Камера",
      "Chinese": "相机",
      "Japanese": "カメラ",
      "Korean": "카메라",
      "Dutch": "Camera",
      "Turkish": "Kamera",
      "Vietnamese": "Máy ảnh",
      "Indonesian": "Kamera"
    }
  },
  {
    "word": "Candle",
    "translations": {
      "English": "Candle",
      "French": "Bougie",
      "Spanish": "Vela",
      "Hindi": "मोमबत्ती",
      "German": "Kerze",
      "Italian": "Candela",
      "Portuguese": "Vela",
      "Russian": "Свеча",
      "Chinese": "蜡烛",
      "Japanese": "ろうそく",
      "Korean": "촛불",
      "Dutch": "Kaars",
      "Turkish": "Mum",
      "Vietnamese": "Nến",
      "Indonesian": "Lilin"
    }
  },
  {
    "word": "Castle",
    "translations": {
      "English": "Castle",
      "French": "Château",
      "Spanish": "Castillo",
      "Hindi": "किला",
      "German": "Schloss",
      "Italian": "Castello",
      "Portuguese": "Castelo",
      "Russian": "Замок",
      "Chinese": "城堡",
      "Japanese": "城",
      "Korean": "성",
      "Dutch": "Kasteel",
      "Turkish": "Kale",
      "Vietnamese": "Lâu đài",
      "Indonesian": "Kastil"
    }
  },
  {
    "word": "Cloud",
    "translations": {
      "English": "Cloud",
      "French": "Nuage",
      "Spanish": "Nube",
      "Hindi": "बादल",
      "German": "Wolke",
      "Italian": "Nuvola",
      "Portuguese": "Nuvem",
      "Russian": "Облако",
      "Chinese": "云",
      "Japanese": "雲",
      "Korean": "구름",
      "Dutch": "Wolk",
      "Turkish": "Bulut",
      "Vietnamese": "Đám mây",
      "Indonesian": "Awan"
    }
  },
  {
    "word": "Coffee",
    "translations": {
      "English": "Coffee",
      "French": "Café",
      "Spanish": "Café",
      "Hindi": "कॉफ़ी",
      "German": "Kaffee",
      "Italian": "Caffè",
      "Portuguese": "Café",
      "Russian": "Кофе",
      "Chinese": "咖啡",
      "Japanese": "コーヒー",
      "Korean": "커피",
      "Dutch": "Koffie",
      "Turkish": "Kahve",
      "Vietnamese": "Cà phê",
      "Indonesian": "Kopi"
    }
  },
  {
    "word": "Computer",
    "translations": {
      "English": "Computer",
      "French": "Ordinateur",
      "Spanish": "Computadora",
      "Hindi": "कंप्यूटर",
      "German": "Computer",
      "Italian": "Computer",
      "Portuguese": "Computador",
      "Russian": "Компьютер",
      "Chinese": "电脑",
      "Japanese": "コンピュータ",
      "Korean": "컴퓨터",
      "Dutch": "Computer",
      "Turkish": "Bilgisayar",
      "Vietnamese": "Máy tính",
      "Indonesian": "Komputer"
    }
  },
  {
    "word": "Cookie",
    "translations": {
      "English": "Cookie",
      "French": "Biscuit",
      "Spanish": "Galleta",
      "Hindi": "कुकी",
      "German": "Keks",
      "Italian": "Biscotto",
      "Portuguese": "Biscoito",
      "Russian": "Печенье",
      "Chinese": "饼干",
      "Japanese": "クッキー",
      "Korean": "쿠키",
      "Dutch": "Koekje",
      "Turkish": "Kurabiye",
      "Vietnamese": "Bánh quy",
      "Indonesian": "Kue kering"
    }
  },
  {
    "word": "Cup",
    "translations": {
      "English": "Cup",
      "French": "Tasse",
      "Spanish": "Taza",
      "Hindi": "कप",
      "German": "Tasse",
      "Italian": "Tazza",
      "Portuguese": "Xícara",
      "Russian": "Чашка",
      "Chinese": "杯子",
      "Japanese": "カップ",
      "Korean": "컵",
      "Dutch": "Kop",
      "Turkish": "Fincan",
      "Vietnamese": "Cốc",
      "Indonesian": "Cangkir"
    }
  },
  {
    "word": "Desk",
    "translations": {
      "English": "Desk",
      "French": "Bureau",
      "Spanish": "Escritorio",
      "Hindi": "डेस्क",
      "German": "Schreibtisch",
      "Italian": "Scrivania",
      "Portuguese": "Escrivaninha",
      "Russian": "Письменный стол",
      "Chinese": "书桌",
      "Japanese": "机",
      "Korean": "책상",
      "Dutch": "Bureau",
      "Turkish": "Masa",
      "Vietnamese": "Bàn học",
      "Indonesian": "Meja"
    }
  },
  {
    "word": "Diamond",
    "translations": {
      "English": "Diamond",
      "French": "Diamant",
      "Spanish": "Diamante",
      "Hindi": "हीरा",
      "German": "Diamant",
      "Italian": "Diamante",
      "Portuguese": "Diamante",
      "Russian": "Бриллиант",
      "Chinese": "钻石",
      "Japanese": "ダイヤモンド",
      "Korean": "다이아몬드",
      "Dutch": "Diamant",
      "Turkish": "Elmas",
      "Vietnamese": "Kim cương",
      "Indonesian": "Berlian"
    }
  },
  {
    "word": "Doctor",
    "translations": {
      "English": "Doctor",
      "French": "Docteur",
      "Spanish": "Doctor",
      "Hindi": "डॉक्टर",
      "German": "Arzt",
      "Italian": "Dottore",
      "Portuguese": "Médico",
      "Russian": "Доктор",
      "Chinese": "医生",
      "Japanese": "医者",
      "Korean": "의사",
      "Dutch": "Dokter",
      "Turkish": "Doktor",
      "Vietnamese": "Bác sĩ",
      "Indonesian": "Dokter"
    }
  },
  {
    "word": "Door",
    "translations": {
      "English": "Door",
      "French": "Porte",
      "Spanish": "Puerta",
      "Hindi": "दरवाज़ा",
      "German": "Tür",
      "Italian": "Porta",
      "Portuguese": "Porta",
      "Russian": "Дверь",
      "Chinese": "门",
      "Japanese": "ドア",
      "Korean": "문",
      "Dutch": "Deur",
      "Turkish": "Kapı",
      "Vietnamese": "Cửa",
      "Indonesian": "Pintu"
    }
  },
  {
    "word": "Dress",
    "translations": {
      "English": "Dress",
      "French": "Robe",
      "Spanish": "Vestido",
      "Hindi": "पोशाक",
      "German": "Kleid",
      "Italian": "Vestito",
      "Portuguese": "Vestido",
      "Russian": "Платье",
      "Chinese": "连衣裙",
      "Japanese": "ドレス",
      "Korean": "드레스",
      "Dutch": "Jurk",
      "Turkish": "Elbise",
      "Vietnamese": "Váy",
      "Indonesian": "Gaun"
    }
  },
  {
    "word": "Drink",
    "translations": {
      "English": "Drink",
      "French": "Boisson",
      "Spanish": "Bebida",
      "Hindi": "पेय",
      "German": "Getränk",
      "Italian": "Bevanda",
      "Portuguese": "Bebida",
      "Russian": "Напиток",
      "Chinese": "饮料",
      "Japanese": "飲み物",
      "Korean": "음료",
      "Dutch": "Drank",
      "Turkish": "İçecek",
      "Vietnamese": "Đồ uống",
      "Indonesian": "Minuman"
    }
  },
  {
    "word": "Earth",
    "translations": {
      "English": "Earth",
      "French": "Terre",
      "Spanish": "Tierra",
      "Hindi": "पृथ्वी",
      "German": "Erde",
      "Italian": "Terra",
      "Portuguese": "Terra",
      "Russian": "Земля",
      "Chinese": "地球",
      "Japanese": "地球",
      "Korean": "지구",
      "Dutch": "Aarde",
      "Turkish": "Dünya",
      "Vietnamese": "Trái đất",
      "Indonesian": "Bumi"
    }
  },
  {
    "word": "Egg",
    "translations": {
      "English": "Egg",
      "French": "Œuf",
      "Spanish": "Huevo",
      "Hindi": "अंडा",
      "German": "Ei",
      "Italian": "Uovo",
      "Portuguese": "Ovo",
      "Russian": "Яйцо",
      "Chinese": "蛋",
      "Japanese": "卵",
      "Korean": "계란",
      "Dutch": "Ei",
      "Turkish": "Yumurta",
      "Vietnamese": "Trứng",
      "Indonesian": "Telur"
    }
  },
  {
    "word": "Elephant",
    "translations": {
      "English": "Elephant",
      "French": "Éléphant",
      "Spanish": "Elefante",
      "Hindi": "हाथी",
      "German": "Elefant",
      "Italian": "Elefante",
      "Portuguese": "Elefante",
      "Russian": "Слон",
      "Chinese": "大象",
      "Japanese": "象",
      "Korean": "코끼리",
      "Dutch": "Olifant",
      "Turkish": "Fil",
      "Vietnamese": "Con voi",
      "Indonesian": "Gajah"
    }
  },
  {
    "word": "Factory",
    "translations": {
      "English": "Factory",
      "French": "Usine",
      "Spanish": "Fábrica",
      "Hindi": "कारख़ाना",
      "German": "Fabrik",
      "Italian": "Fabbrica",
      "Portuguese": "Fábrica",
      "Russian": "Фабрика",
      "Chinese": "工厂",
      "Japanese": "工場",
      "Korean": "공장",
      "Dutch": "Fabriek",
      "Turkish": "Fabrika",
      "Vietnamese": "Nhà máy",
      "Indonesian": "Pabrik"
    }
  },
  {
    "word": "Family",
    "translations": {
      "English": "Family",
      "French": "Famille",
      "Spanish": "Familia",
      "Hindi": "परिवार",
      "German": "Familie",
      "Italian": "Famiglia",
      "Portuguese": "Família",
      "Russian": "Семья",
      "Chinese": "家庭",
      "Japanese": "家族",
      "Korean": "가족",
      "Dutch": "Familie",
      "Turkish": "Aile",
      "Vietnamese": "Gia đình",
      "Indonesian": "Keluarga"
    }
  },
  {
    "word": "Farmer",
    "translations": {
      "English": "Farmer",
      "French": "Agriculteur",
      "Spanish": "Granjero",
      "Hindi": "किसान",
      "German": "Bauer",
      "Italian": "Contadino",
      "Portuguese": "Agricultor",
      "Russian": "Фермер",
      "Chinese": "农民",
      "Japanese": "農家",
      "Korean": "농부",
      "Dutch": "Boer",
      "Turkish": "Çiftçi",
      "Vietnamese": "Nông dân",
      "Indonesian": "Petani"
    }
  },
  {
    "word": "Festival",
    "translations": {
      "English": "Festival",
      "French": "Festival",
      "Spanish": "Festival",
      "Hindi": "त्योहार",
      "German": "Festival",
      "Italian": "Festival",
      "Portuguese": "Festival",
      "Russian": "Фестиваль",
      "Chinese": "节日",
      "Japanese": "祭り",
      "Korean": "축제",
      "Dutch": "Festival",
      "Turkish": "Festival",
      "Vietnamese": "Lễ hội",
      "Indonesian": "Festival"
    }
  },
  {
    "word": "Fire",
    "translations": {
      "English": "Fire",
      "French": "Feu",
      "Spanish": "Fuego",
      "Hindi": "आग",
      "German": "Feuer",
      "Italian": "Fuoco",
      "Portuguese": "Fogo",
      "Russian": "Огонь",
      "Chinese": "火",
      "Japanese": "火",
      "Korean": "불",
      "Dutch": "Vuur",
      "Turkish": "Ateş",
      "Vietnamese": "Lửa",
      "Indonesian": "Api"
    }
  },
  {
    "word": "Flower",
    "translations": {
      "English": "Flower",
      "French": "Fleur",
      "Spanish": "Flor",
      "Hindi": "फूल",
      "German": "Blume",
      "Italian": "Fiore",
      "Portuguese": "Flor",
      "Russian": "Цветок",
      "Chinese": "花",
      "Japanese": "花",
      "Korean": "꽃",
      "Dutch": "Bloem",
      "Turkish": "Çiçek",
      "Vietnamese": "Hoa",
      "Indonesian": "Bunga"
    }
  },
  {
    "word": "Forest",
    "translations": {
      "English": "Forest",
      "French": "Forêt",
      "Spanish": "Bosque",
      "Hindi": "जंगल",
      "German": "Wald",
      "Italian": "Foresta",
      "Portuguese": "Floresta",
      "Russian": "Лес",
      "Chinese": "森林",
      "Japanese": "森",
      "Korean": "숲",
      "Dutch": "Bos",
      "Turkish": "Orman",
      "Vietnamese": "Rừng",
      "Indonesian": "Hutan"
    }
  },
  {
    "word": "Garden",
    "translations": {
      "English": "Garden",
      "French": "Jardin",
      "Spanish": "Jardín",
      "Hindi": "बग़ीचा",
      "German": "Garten",
      "Italian": "Giardino",
      "Portuguese": "Jardim",
      "Russian": "Сад",
      "Chinese": "花园",
      "Japanese": "庭",
      "Korean": "정원",
      "Dutch": "Tuin",
      "Turkish": "Bahçe",
      "Vietnamese": "Vườn",
      "Indonesian": "Taman"
    }
  },
  {
    "word": "Gift",
    "translations": {
      "English": "Gift",
      "French": "Cadeau",
      "Spanish": "Regalo",
      "Hindi": "उपहार",
      "German": "Geschenk",
      "Italian": "Regalo",
      "Portuguese": "Presente",
      "Russian": "Подарок",
      "Chinese": "礼物",
      "Japanese": "贈り物",
      "Korean": "선물",
      "Dutch": "Cadeau",
      "Turkish": "Hediye",
      "Vietnamese": "Quà tặng",
      "Indonesian": "Hadiah"
    }
  },
  {
    "word": "Hospital",
    "translations": {
      "English": "Hospital",
      "French": "Hôpital",
      "Spanish": "Hospital",
      "Hindi": "अस्पताल",
      "German": "Krankenhaus",
      "Italian": "Ospedale",
      "Portuguese": "Hospital",
      "Russian": "Больница",
      "Chinese": "医院",
      "Japanese": "病院",
      "Korean": "병원",
      "Dutch": "Ziekenhuis",
      "Turkish": "Hastane",
      "Vietnamese": "Bệnh viện",
      "Indonesian": "Rumah sakit"
    }
  },
  {
    "word": "Hotel",
    "translations": {
      "English": "Hotel",
      "French": "Hôtel",
      "Spanish": "Hotel",
      "Hindi": "होटल",
      "German": "Hotel",
      "Italian": "Albergo",
      "Portuguese": "Hotel",
      "Russian": "Отель",
      "Chinese": "酒店",
      "Japanese": "ホテル",
      "Korean": "호텔",
      "Dutch": "Hotel",
      "Turkish": "Otel",
      "Vietnamese": "Khách sạn",
      "Indonesian": "Hotel"
    }
  },
  {
    "word": "Ice",
    "translations": {
      "English": "Ice",
      "French": "Glace",
      "Spanish": "Hielo",
      "Hindi": "बर्फ़",
      "German": "Eis",
      "Italian": "Ghiaccio",
      "Portuguese": "Gelo",
      "Russian": "Лёд",
      "Chinese": "冰",
      "Japanese": "氷",
      "Korean": "얼음",
      "Dutch": "IJs",
      "Turkish": "Buz",
      "Vietnamese": "Đá",
      "Indonesian": "Es"
    }
  },
  {
    "word": "Island",
    "translations": {
      "English": "Island",
      "French": "Île",
      "Spanish": "Isla",
      "Hindi": "द्वीप",
      "German": "Insel",
      "Italian": "Isola",
      "Portuguese": "Ilha",
      "Russian": "Остров",
      "Chinese": "岛",
      "Japanese": "島",
      "Korean": "섬",
      "Dutch": "Eiland",
      "Turkish": "Ada",
      "Vietnamese": "Đảo",
      "Indonesian": "Pulau"
    }
  },
  {
    "word": "Jungle",
    "translations": {
      "English": "Jungle",
      "French": "Jungle",
      "Spanish": "Selva",
      "Hindi": "जंगल",
      "German": "Dschungel",
      "Italian": "Giungla",
      "Portuguese": "Selva",
      "Russian": "Джунгли",
      "Chinese": "丛林",
      "Japanese": "ジャングル",
      "Korean": "정글",
      "Dutch": "Jungle",
      "Turkish": "Orman",
      "Vietnamese": "Rừng rậm",
      "Indonesian": "Hutan"
    }
  },
  {
    "word": "Key",
    "translations": {
      "English": "Key",
      "French": "Clé",
      "Spanish": "Llave",
      "Hindi": "चाबी",
      "German": "Schlüssel",
      "Italian": "Chiave",
      "Portuguese": "Chave",
      "Russian": "Ключ",
      "Chinese": "钥匙",
      "Japanese": "鍵",
      "Korean": "열쇠",
      "Dutch": "Sleutel",
      "Turkish": "Anahtar",
      "Vietnamese": "Chìa khóa",
      "Indonesian": "Kunci"
    }
  },
  {
    "word": "King",
    "translations": {
      "English": "King",
      "French": "Roi",
      "Spanish": "Rey",
      "Hindi": "राजा",
      "German": "König",
      "Italian": "Re",
      "Portuguese": "Rei",
      "Russian": "Король",
      "Chinese": "国王",
      "Japanese": "王",
      "Korean": "왕",
      "Dutch": "Koning",
      "Turkish": "Kral",
      "Vietnamese": "Vua",
      "Indonesian": "Raja"
    }
  },
  {
    "word": "Kitchen",
    "translations": {
      "English": "Kitchen",
      "French": "Cuisine",
      "Spanish": "Cocina",
      "Hindi": "रसोई",
      "German": "Küche",
      "Italian": "Cucina",
      "Portuguese": "Cozinha",
      "Russian": "Кухня",
      "Chinese": "厨房",
      "Japanese": "台所",
      "Korean": "부엌",
      "Dutch": "Keuken",
      "Turkish": "Mutfak",
      "Vietnamese": "Nhà bếp",
      "Indonesian": "Dapur"
    }
  },
  {
    "word": "Lamp",
    "translations": {
      "English": "Lamp",
      "French": "Lampe",
      "Spanish": "Lámpara",
      "Hindi": "लैम्प",
      "German": "Lampe",
      "Italian": "Lampada",
      "Portuguese": "Lâmpada",
      "Russian": "Лампа",
      "Chinese": "灯",
      "Japanese": "ランプ",
      "Korean": "램프",
      "Dutch": "Lamp",
      "Turkish": "Lamba",
      "Vietnamese": "Đèn",
      "Indonesian": "Lampu"
    }
  },
  {
    "word": "Library",
    "translations": {
      "English": "Library",
      "French": "Bibliothèque",
      "Spanish": "Biblioteca",
      "Hindi": "पुस्तकालय",
      "German": "Bibliothek",
      "Italian": "Biblioteca",
      "Portuguese": "Biblioteca",
      "Russian": "Библиотека",
      "Chinese": "图书馆",
      "Japanese": "図書館",
      "Korean": "도서관",
      "Dutch": "Bibliotheek",
      "Turkish": "Kütüphane",
      "Vietnamese": "Thư viện",
      "Indonesian": "Perpustakaan"
    }
  },
  {
    "word": "Market",
    "translations": {
      "English": "Market",
      "French": "Marché",
      "Spanish": "Mercado",
      "Hindi": "बाज़ार",
      "German": "Markt",
      "Italian": "Mercato",
      "Portuguese": "Mercado",
      "Russian": "Рынок",
      "Chinese": "市场",
      "Japanese": "市場",
      "Korean": "시장",
      "Dutch": "Markt",
      "Turkish": "Pazar",
      "Vietnamese": "Chợ",
      "Indonesian": "Pasar"
    }
  },
  {
    "word": "Mirror",
    "translations": {
      "English": "Mirror",
      "French": "Miroir",
      "Spanish": "Espejo",
      "Hindi": "दर्पण",
      "German": "Spiegel",
      "Italian": "Specchio",
      "Portuguese": "Espelho",
      "Russian": "Зеркало",
      "Chinese": "镜子",
      "Japanese": "鏡",
      "Korean": "거울",
      "Dutch": "Spiegel",
      "Turkish": "Ayna",
      "Vietnamese": "Gương",
      "Indonesian": "Cermin"
    }
  },
  {
    "word": "Acrobat",
    "translations": {
      "English": "Acrobat",
      "French": "Acrobate",
      "Spanish": "Acróbata",
      "Hindi": "कलाबाज",
      "German": "Akrobat",
      "Italian": "Acrobata",
      "Portuguese": "Acrobata",
      "Russian": "Акробат",
      "Chinese": "杂技演员",
      "Japanese": "曲芸師",
      "Korean": "곡예사",
      "Dutch": "Acrobaat",
      "Turkish": "Akrobat",
      "Vietnamese": "Người nhào lộn",
      "Indonesian": "Akrabat"
    }
  },
  {
    "word": "Adventure",
    "translations": {
      "English": "Adventure",
      "French": "Aventure",
      "Spanish": "Aventura",
      "Hindi": "साहसिक कार्य",
      "German": "Abenteuer",
      "Italian": "Avventura",
      "Portuguese": "Aventura",
      "Russian": "Приключение",
      "Chinese": "冒险",
      "Japanese": "冒険",
      "Korean": "모험",
      "Dutch": "Avontuur",
      "Turkish": "Macera",
      "Vietnamese": "Cuộc phiêu lưu",
      "Indonesian": "Petualangan"
    }
  },
  {
    "word": "AirportTerminal",
    "translations": {
      "English": "Airport Terminal",
      "French": "Terminal d'aéroport",
      "Spanish": "Terminal del aeropuerto",
      "Hindi": "हवाई अड्डा टर्मिनल",
      "German": "Flughafenterminal",
      "Italian": "Terminal aeroportuale",
      "Portuguese": "Terminal do aeroporto",
      "Russian": "Терминал аэропорта",
      "Chinese": "机场航站楼",
      "Japanese": "空港ターミナル",
      "Korean": "공항 터미널",
      "Dutch": "Luchthaventerminal",
      "Turkish": "Havalimanı Terminali",
      "Vietnamese": "Nhà ga sân bay",
      "Indonesian": "Terminal Bandara"
    }
  },
  {
    "word": "Alley",
    "translations": {
      "English": "Alley",
      "French": "Allée",
      "Spanish": "Callejón",
      "Hindi": "गली",
      "German": "Gasse",
      "Italian": "Vicolo",
      "Portuguese": "Beco",
      "Russian": "Переулок",
      "Chinese": "小巷",
      "Japanese": "路地",
      "Korean": "골목",
      "Dutch": "Steeg",
      "Turkish": "Ara sokak",
      "Vietnamese": "Ngõ",
      "Indonesian": "Gang"
    }
  },
  {
    "word": "Anchor",
    "translations": {
      "English": "Anchor",
      "French": "Ancre",
      "Spanish": "Ancla",
      "Hindi": "लंगर",
      "German": "Anker",
      "Italian": "Ancora",
      "Portuguese": "Âncora",
      "Russian": "Якорь",
      "Chinese": "锚",
      "Japanese": "アンカー",
      "Korean": "닻",
      "Dutch": "Anker",
      "Turkish": "Çapa",
      "Vietnamese": "Mỏ neo",
      "Indonesian": "Jangkar"
    }
  },
  {
    "word": "Aquarium",
    "translations": {
      "English": "Aquarium",
      "French": "Aquarium",
      "Spanish": "Acuario",
      "Hindi": "जलीय उद्यान",
      "German": "Aquarium",
      "Italian": "Acquario",
      "Portuguese": "Aquário",
      "Russian": "Аквариум",
      "Chinese": "水族馆",
      "Japanese": "水族館",
      "Korean": "아쿠아리움",
      "Dutch": "Aquarium",
      "Turkish": "Akvaryum",
      "Vietnamese": "Bể cá",
      "Indonesian": "Akuarium"
    }
  },
  {
    "word": "Artist",
    "translations": {
      "English": "Artist",
      "French": "Artiste",
      "Spanish": "Artista",
      "Hindi": "कलाकार",
      "German": "Künstler",
      "Italian": "Artista",
      "Portuguese": "Artista",
      "Russian": "Художник",
      "Chinese": "艺术家",
      "Japanese": "芸術家",
      "Korean": "예술가",
      "Dutch": "Kunstenaar",
      "Turkish": "Sanatçı",
      "Vietnamese": "Nghệ sĩ",
      "Indonesian": "Seniman"
    }
  },
  {
    "word": "Athlete",
    "translations": {
      "English": "Athlete",
      "French": "Athlète",
      "Spanish": "Atleta",
      "Hindi": "खिलाड़ी",
      "German": "Sportler",
      "Italian": "Atleta",
      "Portuguese": "Atleta",
      "Russian": "Атлет",
      "Chinese": "运动员",
      "Japanese": "アスリート",
      "Korean": "운동선수",
      "Dutch": "Atleet",
      "Turkish": "Atlet",
      "Vietnamese": "Vận động viên",
      "Indonesian": "Atlet"
    }
  },
  {
    "word": "Backpacker",
    "translations": {
      "English": "Backpacker",
      "French": "Routard",
      "Spanish": "Mochilero",
      "Hindi": "पथिक",
      "German": "Rucksacktourist",
      "Italian": "Zaino",
      "Portuguese": "Mochileiro",
      "Russian": "Бэкпекер",
      "Chinese": "背包客",
      "Japanese": "バックパッカー",
      "Korean": "배낭여행자",
      "Dutch": "Backpacker",
      "Turkish": "Sırt çantalı gezgin",
      "Vietnamese": "Du khách ba lô",
      "Indonesian": "Backpacker"
    }
  },
  {
    "word": "Balloon",
    "translations": {
      "English": "Balloon",
      "French": "Ballon",
      "Spanish": "Globo",
      "Hindi": "गुब्बारा",
      "German": "Ballon",
      "Italian": "Palloncino",
      "Portuguese": "Balão",
      "Russian": "Воздушный шар",
      "Chinese": "气球",
      "Japanese": "風船",
      "Korean": "풍선",
      "Dutch": "Ballon",
      "Turkish": "Balon",
      "Vietnamese": "Bóng bay",
      "Indonesian": "Balon"
    }
  },
  {
    "word": "Bamboo",
    "translations": {
      "English": "Bamboo",
      "French": "Bambou",
      "Spanish": "Bambú",
      "Hindi": "बाँस",
      "German": "Bambus",
      "Italian": "Bambù",
      "Portuguese": "Bambu",
      "Russian": "Бамбук",
      "Chinese": "竹子",
      "Japanese": "竹",
      "Korean": "대나무",
      "Dutch": "Bamboe",
      "Turkish": "Bambu",
      "Vietnamese": "Tre",
      "Indonesian": "Bambu"
    }
  },
  {
    "word": "Basket",
    "translations": {
      "English": "Basket",
      "French": "Panier",
      "Spanish": "Cesta",
      "Hindi": "टोकरी",
      "German": "Korb",
      "Italian": "Cesto",
      "Portuguese": "Cesta",
      "Russian": "Корзина",
      "Chinese": "篮子",
      "Japanese": "バスケット",
      "Korean": "바구니",
      "Dutch": "Mand",
      "Turkish": "Sepet",
      "Vietnamese": "Rổ",
      "Indonesian": "Keranjang"
    }
  },
  {
    "word": "Beacon",
    "translations": {
      "English": "Beacon",
      "French": "Balise",
      "Spanish": "Faro",
      "Hindi": "बीकन",
      "German": "Leuchtfeuer",
      "Italian": "Faro",
      "Portuguese": "Baluarte",
      "Russian": "Маяк",
      "Chinese": "灯塔",
      "Japanese": "ビーコン",
      "Korean": "봉화",
      "Dutch": "Baken",
      "Turkish": "İşaret feneri",
      "Vietnamese": "Ngọn hải đăng",
      "Indonesian": "Suar"
    }
  },
  {
    "word": "Bell",
    "translations": {
      "English": "Bell",
      "French": "Cloche",
      "Spanish": "Campana",
      "Hindi": "घंटी",
      "German": "Glocke",
      "Italian": "Campana",
      "Portuguese": "Sino",
      "Russian": "Колокол",
      "Chinese": "铃",
      "Japanese": "鐘",
      "Korean": "종",
      "Dutch": "Bel",
      "Turkish": "Çan",
      "Vietnamese": "Chuông",
      "Indonesian": "Lonceng"
    }
  },
  {
    "word": "Bench",
    "translations": {
      "English": "Bench",
      "French": "Banc",
      "Spanish": "Banco",
      "Hindi": "बेंच",
      "German": "Bank",
      "Italian": "Panchina",
      "Portuguese": "Banco",
      "Russian": "Скамейка",
      "Chinese": "长椅",
      "Japanese": "ベンチ",
      "Korean": "벤치",
      "Dutch": "Bank",
      "Turkish": "Bank",
      "Vietnamese": "Ghế băng",
      "Indonesian": "Bangku"
    }
  },
  {
    "word": "Bridge",
    "translations": {
      "English": "Bridge",
      "French": "Pont",
      "Spanish": "Puente",
      "Hindi": "पुल",
      "German": "Brücke",
      "Italian": "Ponte",
      "Portuguese": "Ponte",
      "Russian": "Мост",
      "Chinese": "桥",
      "Japanese": "橋",
      "Korean": "다리",
      "Dutch": "Brug",
      "Turkish": "Köprü",
      "Vietnamese": "Cầu",
      "Indonesian": "Jembatan"
    }
  },
  {
    "word": "Butterfly",
    "translations": {
      "English": "Butterfly",
      "French": "Papillon",
      "Spanish": "Mariposa",
      "Hindi": "तितली",
      "German": "Schmetterling",
      "Italian": "Farfalla",
      "Portuguese": "Borboleta",
      "Russian": "Бабочка",
      "Chinese": "蝴蝶",
      "Japanese": "蝶",
      "Korean": "나비",
      "Dutch": "Vlinder",
      "Turkish": "Kelebek",
      "Vietnamese": "Bươm bướm",
      "Indonesian": "Kupu-kupu"
    }
  },
  {
    "word": "Candle",
    "translations": {
      "English": "Candle",
      "French": "Bougie",
      "Spanish": "Vela",
      "Hindi": "मोमबत्ती",
      "German": "Kerze",
      "Italian": "Candela",
      "Portuguese": "Vela",
      "Russian": "Свеча",
      "Chinese": "蜡烛",
      "Japanese": "ろうそく",
      "Korean": "촛불",
      "Dutch": "Kaars",
      "Turkish": "Mum",
      "Vietnamese": "Nến",
      "Indonesian": "Lilin"
    }
  },
  {
    "word": "Castle",
    "translations": {
      "English": "Castle",
      "French": "Château",
      "Spanish": "Castillo",
      "Hindi": "किला",
      "German": "Schloss",
      "Italian": "Castello",
      "Portuguese": "Castelo",
      "Russian": "Замок",
      "Chinese": "城堡",
      "Japanese": "城",
      "Korean": "성",
      "Dutch": "Kasteel",
      "Turkish": "Şato",
      "Vietnamese": "Lâu đài",
      "Indonesian": "Kastil"
    }
  },
  {
    "word": "Clock",
    "translations": {
      "English": "Clock",
      "French": "Horloge",
      "Spanish": "Reloj",
      "Hindi": "घड़ी",
      "German": "Uhr",
      "Italian": "Orologio",
      "Portuguese": "Relógio",
      "Russian": "Часы",
      "Chinese": "钟",
      "Japanese": "時計",
      "Korean": "시계",
      "Dutch": "Klok",
      "Turkish": "Saat",
      "Vietnamese": "Đồng hồ",
      "Indonesian": "Jam"
    }
  },
  {
    "word": "Cloud",
    "translations": {
      "English": "Cloud",
      "French": "Nuage",
      "Spanish": "Nube",
      "Hindi": "बादल",
      "German": "Wolke",
      "Italian": "Nuvola",
      "Portuguese": "Nuvem",
      "Russian": "Облако",
      "Chinese": "云",
      "Japanese": "雲",
      "Korean": "구름",
      "Dutch": "Wolk",
      "Turkish": "Bulut",
      "Vietnamese": "Mây",
      "Indonesian": "Awan"
    }
  },
  {
    "word": "Compass",
    "translations": {
      "English": "Compass",
      "French": "Boussole",
      "Spanish": "Brújula",
      "Hindi": "दिशासूचक",
      "German": "Kompass",
      "Italian": "Bussola",
      "Portuguese": "Bússola",
      "Russian": "Компас",
      "Chinese": "指南针",
      "Japanese": "コンパス",
      "Korean": "나침반",
      "Dutch": "Kompas",
      "Turkish": "Pusula",
      "Vietnamese": "La bàn",
      "Indonesian": "Kompas"
    }
  },
  {
    "word": "Crown",
    "translations": {
      "English": "Crown",
      "French": "Couronne",
      "Spanish": "Corona",
      "Hindi": "ताज",
      "German": "Krone",
      "Italian": "Corona",
      "Portuguese": "Coroa",
      "Russian": "Корона",
      "Chinese": "皇冠",
      "Japanese": "王冠",
      "Korean": "왕관",
      "Dutch": "Kroon",
      "Turkish": "Taç",
      "Vietnamese": "Vương miện",
      "Indonesian": "Mahkota"
    }
  },
  {
    "word": "Diamond",
    "translations": {
      "English": "Diamond",
      "French": "Diamant",
      "Spanish": "Diamante",
      "Hindi": "हीरा",
      "German": "Diamant",
      "Italian": "Diamante",
      "Portuguese": "Diamante",
      "Russian": "Бриллиант",
      "Chinese": "钻石",
      "Japanese": "ダイヤモンド",
      "Korean": "다이아몬드",
      "Dutch": "Diamant",
      "Turkish": "Elmas",
      "Vietnamese": "Kim cương",
      "Indonesian": "Berlian"
    }
  },
  {
    "word": "Drum",
    "translations": {
      "English": "Drum",
      "French": "Tambour",
      "Spanish": "Tambor",
      "Hindi": "ढोल",
      "German": "Trommel",
      "Italian": "Tamburo",
      "Portuguese": "Tambor",
      "Russian": "Барабан",
      "Chinese": "鼓",
      "Japanese": "ドラム",
      "Korean": "북",
      "Dutch": "Drum",
      "Turkish": "Davul",
      "Vietnamese": "Trống",
      "Indonesian": "Drum"
    }
  },
  {
    "word": "Eagle",
    "translations": {
      "English": "Eagle",
      "French": "Aigle",
      "Spanish": "Águila",
      "Hindi": "ईगल",
      "German": "Adler",
      "Italian": "Aquila",
      "Portuguese": "Águia",
      "Russian": "Орел",
      "Chinese": "鹰",
      "Japanese": "鷲",
      "Korean": "독수리",
      "Dutch": "Adelaar",
      "Turkish": "Kartal",
      "Vietnamese": "Đại bàng",
      "Indonesian": "Elang"
    }
  },
  {
    "word": "Feather",
    "translations": {
      "English": "Feather",
      "French": "Plume",
      "Spanish": "Pluma",
      "Hindi": "पंख",
      "German": "Feder",
      "Italian": "Piuma",
      "Portuguese": "Pena",
      "Russian": "Перо",
      "Chinese": "羽毛",
      "Japanese": "羽",
      "Korean": "깃털",
      "Dutch": "Veer",
      "Turkish": "Tüy",
      "Vietnamese": "Lông vũ",
      "Indonesian": "Bulu"
    }
  },
  {
    "word": "Flag",
    "translations": {
      "English": "Flag",
      "French": "Drapeau",
      "Spanish": "Bandera",
      "Hindi": "झंडा",
      "German": "Flagge",
      "Italian": "Bandiera",
      "Portuguese": "Bandeira",
      "Russian": "Флаг",
      "Chinese": "旗",
      "Japanese": "旗",
      "Korean": "깃발",
      "Dutch": "Vlag",
      "Turkish": "Bayrak",
      "Vietnamese": "Cờ",
      "Indonesian": "Bendera"
    }
  },
  {
    "word": "Flower",
    "translations": {
      "English": "Flower",
      "French": "Fleur",
      "Spanish": "Flor",
      "Hindi": "फूल",
      "German": "Blume",
      "Italian": "Fiore",
      "Portuguese": "Flor",
      "Russian": "Цветок",
      "Chinese": "花",
      "Japanese": "花",
      "Korean": "꽃",
      "Dutch": "Bloem",
      "Turkish": "Çiçek",
      "Vietnamese": "Hoa",
      "Indonesian": "Bunga"
    }
  },
  {
    "word": "Forest",
    "translations": {
      "English": "Forest",
      "French": "Forêt",
      "Spanish": "Bosque",
      "Hindi": "जंगल",
      "German": "Wald",
      "Italian": "Foresta",
      "Portuguese": "Floresta",
      "Russian": "Лес",
      "Chinese": "森林",
      "Japanese": "森",
      "Korean": "숲",
      "Dutch": "Bos",
      "Turkish": "Orman",
      "Vietnamese": "Rừng",
      "Indonesian": "Hutan"
    }
  },
  {
    "word": "Garden",
    "translations": {
      "English": "Garden",
      "French": "Jardin",
      "Spanish": "Jardín",
      "Hindi": "बगीचा",
      "German": "Garten",
      "Italian": "Giardino",
      "Portuguese": "Jardim",
      "Russian": "Сад",
      "Chinese": "花园",
      "Japanese": "庭",
      "Korean": "정원",
      "Dutch": "Tuin",
      "Turkish": "Bahçe",
      "Vietnamese": "Vườn",
      "Indonesian": "Taman"
    }
  },
  {
    "word": "Gift",
    "translations": {
      "English": "Gift",
      "French": "Cadeau",
      "Spanish": "Regalo",
      "Hindi": "उपहार",
      "German": "Geschenk",
      "Italian": "Regalo",
      "Portuguese": "Presente",
      "Russian": "Подарок",
      "Chinese": "礼物",
      "Japanese": "贈り物",
      "Korean": "선물",
      "Dutch": "Cadeau",
      "Turkish": "Hediye",
      "Vietnamese": "Quà",
      "Indonesian": "Hadiah"
    }
  },
  {
    "word": "Horse",
    "translations": {
      "English": "Horse",
      "French": "Cheval",
      "Spanish": "Caballo",
      "Hindi": "घोड़ा",
      "German": "Pferd",
      "Italian": "Cavallo",
      "Portuguese": "Cavalo",
      "Russian": "Лошадь",
      "Chinese": "马",
      "Japanese": "馬",
      "Korean": "말",
      "Dutch": "Paard",
      "Turkish": "At",
      "Vietnamese": "Ngựa",
      "Indonesian": "Kuda"
    }
  },
  {
    "word": "Ice",
    "translations": {
      "English": "Ice",
      "French": "Glace",
      "Spanish": "Hielo",
      "Hindi": "बर्फ",
      "German": "Eis",
      "Italian": "Ghiaccio",
      "Portuguese": "Gelo",
      "Russian": "Лед",
      "Chinese": "冰",
      "Japanese": "氷",
      "Korean": "얼음",
      "Dutch": "IJs",
      "Turkish": "Buz",
      "Vietnamese": "Đá",
      "Indonesian": "Es"
    }
  },
  {
    "word": "Island",
    "translations": {
      "English": "Island",
      "French": "Île",
      "Spanish": "Isla",
      "Hindi": "द्वीप",
      "German": "Insel",
      "Italian": "Isola",
      "Portuguese": "Ilha",
      "Russian": "Остров",
      "Chinese": "岛",
      "Japanese": "島",
      "Korean": "섬",
      "Dutch": "Eiland",
      "Turkish": "Ada",
      "Vietnamese": "Đảo",
      "Indonesian": "Pulau"
    }
  },
  {
    "word": "Jungle",
    "translations": {
      "English": "Jungle",
      "French": "Jungle",
      "Spanish": "Selva",
      "Hindi": "जंगल",
      "German": "Dschungel",
      "Italian": "Giungla",
      "Portuguese": "Selva",
      "Russian": "Джунгли",
      "Chinese": "丛林",
      "Japanese": "ジャングル",
      "Korean": "정글",
      "Dutch": "Jungle",
      "Turkish": "Orman",
      "Vietnamese": "Rừng rậm",
      "Indonesian": "Hutan"
    }
  },
  {
    "word": "King",
    "translations": {
      "English": "King",
      "French": "Roi",
      "Spanish": "Rey",
      "Hindi": "राजा",
      "German": "König",
      "Italian": "Re",
      "Portuguese": "Rei",
      "Russian": "Король",
      "Chinese": "国王",
      "Japanese": "王",
      "Korean": "왕",
      "Dutch": "Koning",
      "Turkish": "Kral",
      "Vietnamese": "Vua",
      "Indonesian": "Raja"
    }
  },
  {
    "word": "Kitchen",
    "translations": {
      "English": "Kitchen",
      "French": "Cuisine",
      "Spanish": "Cocina",
      "Hindi": "रसोई",
      "German": "Küche",
      "Italian": "Cucina",
      "Portuguese": "Cozinha",
      "Russian": "Кухня",
      "Chinese": "厨房",
      "Japanese": "台所",
      "Korean": "주방",
      "Dutch": "Keuken",
      "Turkish": "Mutfak",
      "Vietnamese": "Nhà bếp",
      "Indonesian": "Dapur"
    }
  },
  {
    "word": "Lamp",
    "translations": {
      "English": "Lamp",
      "French": "Lampe",
      "Spanish": "Lámpara",
      "Hindi": "लैंप",
      "German": "Lampe",
      "Italian": "Lampada",
      "Portuguese": "Lâmpada",
      "Russian": "Лампа",
      "Chinese": "灯",
      "Japanese": "ランプ",
      "Korean": "램프",
      "Dutch": "Lamp",
      "Turkish": "Lamba",
      "Vietnamese": "Đèn",
      "Indonesian": "Lampu"
    }
  },
  {
    "word": "Library",
    "translations": {
      "English": "Library",
      "French": "Bibliothèque",
      "Spanish": "Biblioteca",
      "Hindi": "पुस्तकालय",
      "German": "Bibliothek",
      "Italian": "Biblioteca",
      "Portuguese": "Biblioteca",
      "Russian": "Библиотека",
      "Chinese": "图书馆",
      "Japanese": "図書館",
      "Korean": "도서관",
      "Dutch": "Bibliotheek",
      "Turkish": "Kütüphane",
      "Vietnamese": "Thư viện",
      "Indonesian": "Perpustakaan"
    }
  },
  {
    "word": "Market",
    "translations": {
      "English": "Market",
      "French": "Marché",
      "Spanish": "Mercado",
      "Hindi": "बाजार",
      "German": "Markt",
      "Italian": "Mercato",
      "Portuguese": "Mercado",
      "Russian": "Рынок",
      "Chinese": "市场",
      "Japanese": "市場",
      "Korean": "시장",
      "Dutch": "Markt",
      "Turkish": "Pazar",
      "Vietnamese": "Chợ",
      "Indonesian": "Pasar"
    }
  },
  {
    "word": "Mirror",
    "translations": {
      "English": "Mirror",
      "French": "Miroir",
      "Spanish": "Espejo",
      "Hindi": "दर्पण",
      "German": "Spiegel",
      "Italian": "Specchio",
      "Portuguese": "Espelho",
      "Russian": "Зеркало",
      "Chinese": "镜子",
      "Japanese": "鏡",
      "Korean": "거울",
      "Dutch": "Spiegel",
      "Turkish": "Ayna",
      "Vietnamese": "Gương",
      "Indonesian": "Cermin"
    }
  },
  {
    "word": "Mountain",
    "translations": {
      "English": "Mountain",
      "French": "Montagne",
      "Spanish": "Montaña",
      "Hindi": "पहाड़",
      "German": "Berg",
      "Italian": "Montagna",
      "Portuguese": "Montanha",
      "Russian": "Гора",
      "Chinese": "山",
      "Japanese": "山",
      "Korean": "산",
      "Dutch": "Berg",
      "Turkish": "Dağ",
      "Vietnamese": "Núi",
      "Indonesian": "Gunung"
    }
  },
  {
    "word": "Museum",
    "translations": {
      "English": "Museum",
      "French": "Musée",
      "Spanish": "Museo",
      "Hindi": "संग्रहालय",
      "German": "Museum",
      "Italian": "Museo",
      "Portuguese": "Museu",
      "Russian": "Музей",
      "Chinese": "博物馆",
      "Japanese": "博物館",
      "Korean": "박물관",
      "Dutch": "Museum",
      "Turkish": "Müze",
      "Vietnamese": "Bảo tàng",
      "Indonesian": "Museum"
    }
  },
  {
    "word": "Music",
    "translations": {
      "English": "Music",
      "French": "Musique",
      "Spanish": "Música",
      "Hindi": "संगीत",
      "German": "Musik",
      "Italian": "Musica",
      "Portuguese": "Música",
      "Russian": "Музыка",
      "Chinese": "音乐",
      "Japanese": "音楽",
      "Korean": "음악",
      "Dutch": "Muziek",
      "Turkish": "Müzik",
      "Vietnamese": "Âm nhạc",
      "Indonesian": "Musik"
    }
  },
  {
    "word": "Newspaper",
    "translations": {
      "English": "Newspaper",
      "French": "Journal",
      "Spanish": "Periódico",
      "Hindi": "अखबार",
      "German": "Zeitung",
      "Italian": "Giornale",
      "Portuguese": "Jornal",
      "Russian": "Газета",
      "Chinese": "报纸",
      "Japanese": "新聞",
      "Korean": "신문",
      "Dutch": "Kranten",
      "Turkish": "Gazete",
      "Vietnamese": "Báo",
      "Indonesian": "Koran"
    }
  },
  {
    "word": "Night",
    "translations": {
      "English": "Night",
      "French": "Nuit",
      "Spanish": "Noche",
      "Hindi": "रात",
      "German": "Nacht",
      "Italian": "Notte",
      "Portuguese": "Noite",
      "Russian": "Ночь",
      "Chinese": "夜晚",
      "Japanese": "夜",
      "Korean": "밤",
      "Dutch": "Nacht",
      "Turkish": "Gece",
      "Vietnamese": "Đêm",
      "Indonesian": "Malam"
    }
  },
  {
    "word": "Ocean",
    "translations": {
      "English": "Ocean",
      "French": "Océan",
      "Spanish": "Océano",
      "Hindi": "महासागर",
      "German": "Ozean",
      "Italian": "Oceano",
      "Portuguese": "Oceano",
      "Russian": "Океан",
      "Chinese": "海洋",
      "Japanese": "海",
      "Korean": "대양",
      "Dutch": "Oceaan",
      "Turkish": "Okyanus",
      "Vietnamese": "Đại dương",
      "Indonesian": "Samudra"
    }
  },
];

/* ================= HOME SCREEN ================= */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLanguage = "English";

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("LangBuddy"),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? const LinearGradient(
            colors: [Color(0xFF1E1E2C), Color(0xFF2A2A3D)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : const LinearGradient(
            colors: [Color(0xFF4A5CF0), Color(0xFF6A7BFF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Choose Language Label
              Text(
                "Choose Language",
                style: TextStyle(
                  color: Theme.of(context).textTheme.titleMedium?.color,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),

              // Dropdown for selecting language
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey[800] : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    items: [
                      "English",
                      "French",
                      "Spanish",
                      "Hindi",
                      "German",
                      "Italian",
                      "Japanese",
                      "Chinese",
                      "Russian",
                      "Korean",
                      "Dutch",
                      "Turkish",
                      "Vietnamese",
                      "Indonesian"
                    ].map((l) {
                      return DropdownMenuItem(
                        value: l,
                        child: Text(
                          l,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (v) => setState(() => selectedLanguage = v!),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Cards Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _buildCard(Icons.search, "Search",
                            () => open(context, const SearchScreen())),
                    _buildCard(Icons.book, "Vocabulary", () => open(
                        context, VocabularyScreen(language: selectedLanguage))),
                    _buildCard(Icons.quiz, "Quiz",
                            () => open(context, QuizScreen(language: selectedLanguage))),
                    _buildCard(Icons.bar_chart, "Progress",
                            () => open(context, const ProgressScreen())),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Theme-aware card builder
  Widget _buildCard(IconData icon, String title, VoidCallback onTap) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark ? Colors.black54 : Colors.grey.withOpacity(0.3),
              blurRadius: 6,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Theme.of(context).iconTheme.color),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Dummy open function to navigate (replace with your actual navigation)
void open(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

/* ================= UI HELPERS ================= */

Widget card(IconData icon, String title, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.indigo),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    ),
  );
}


/* ================= SEARCH SCREEN ================= */
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  late stt.SpeechToText speech;
  bool isListening = false;
  List<Map<String, dynamic>> searchResults = [];

  @override
  void initState() {
    super.initState();
    speech = stt.SpeechToText();
    searchResults = vocabularyData; // show all words initially
  }

  void search(String query) {
    setState(() {
      searchResults = vocabularyData.where((wordData) {
        final word = wordData['word'].toString().toLowerCase();
        final translations = (wordData['translations'] as Map<String, dynamic>)
            .values
            .map((e) => e.toString().toLowerCase());
        return word.contains(query.toLowerCase()) ||
            translations.any((t) => t.contains(query.toLowerCase()));
      }).toList();
    });
  }

  Future<void> startListening() async {
    bool available = await speech.initialize();
    if (available) {
      setState(() => isListening = true);
      speech.listen(
        onResult: (result) {
          controller.text = result.recognizedWords;
          search(result.recognizedWords);
        },
      );
    }
  }

  void stopListening() {
    speech.stop();
    setState(() => isListening = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Words")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Search bar + voice button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: "Search word...",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => search(value),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(isListening ? Icons.mic : Icons.mic_none),
                  onPressed: () {
                    if (isListening) {
                      stopListening();
                    } else {
                      startListening();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Search results
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final wordData = searchResults[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            wordData['word'],
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          ...wordData['translations']
                              .entries
                              .map<Widget>((entry) {
                            final language = entry.key;
                            final translation = entry.value;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$language: $translation'),
                                IconButton(
                                  icon: const Icon(Icons.volume_up),
                                  onPressed: () async {
                                    await speak(translation, language);
                                  },
                                ),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================= VOCABULARY SCREEN ================= */

class VocabularyScreen extends StatelessWidget {
  final String language;
  VocabularyScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vocabulary")),
      body: ListView(
        children: vocabularyData
            .map((w) => Card(
          child: ListTile(
            title: Text("${w['word']} → ${w['translations'][language]}"),
          ),
        ))
            .toList(),
      ),
    );
  }
}



/* ================= QUIZ SCREEN ================= */

class QuizScreen extends StatefulWidget {
  final String language;
  QuizScreen({super.key, required this.language});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> questions = [];
  int index = 0;
  int score = 0;

  @override
  void initState() {
    super.initState();
    questions = generateQuizQuestions(vocabularyData, 50, widget.language);
  }

  // Function to generate quiz questions dynamically
  List<Map<String, dynamic>> generateQuizQuestions(
      List<Map<String, dynamic>> vocab, int totalQuestions, String language) {
    final random = Random();
    List<Map<String, dynamic>> quizQuestions = [];

    // Flatten vocab translations for wrong options
    List<String> allOptions = List<String>.from(
        vocab.map((e) => e["translations"][language]!));

    while (quizQuestions.length < totalQuestions) {
      var wordEntry = vocab[random.nextInt(vocab.length)];
      String questionWord = wordEntry["word"];
      String correct = wordEntry["translations"][language]!;

      // Generate 2 wrong options
      List<String> wrongOptions = [];
      while (wrongOptions.length < 2) {
        String option = allOptions[random.nextInt(allOptions.length)];
        if (option != correct && !wrongOptions.contains(option)) {
          wrongOptions.add(option);
        }
      }

      // Shuffle options
      List<String> options = [correct, ...wrongOptions]..shuffle();

      quizQuestions.add({
        "q": "What is '$questionWord' in $language?",
        "options": options,
        "answer": correct
      });
    }

    return quizQuestions;
  }

  void answer(String selected) async {
    if (selected == questions[index]["answer"]) score++;
    if (index < questions.length - 1) {
      setState(() => index++);
    } else {
      // Save score to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt("score", score);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text("Quiz Completed!"),
          content: Text("Your Score: $score / ${questions.length}"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Go back to Home
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text("Quiz")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Question ${index + 1} / ${questions.length}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Text(
              questions[index]["q"],
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            ...questions[index]["options"].map<Widget>(
                  (option) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  onPressed: () => answer(option),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(option, style: const TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================= PROGRESS SCREEN ================= */

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  int score = 0;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => score = prefs.getInt("score") ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Progress")),
      body: Center(
          child: Text("Last Quiz Score: $score",
              style: const TextStyle(fontSize: 22))),
    );
  }
}

/* ================= SETTINGS SCREEN ================= */

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  double ttsSpeed = 0.5;
  double ttsPitch = 1.0;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      ttsSpeed = prefs.getDouble('ttsSpeed') ?? 0.5;
      ttsPitch = prefs.getDouble('ttsPitch') ?? 1.0;
    });
  }

  Future<void> saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
    await prefs.setDouble('ttsSpeed', ttsSpeed);
    await prefs.setDouble('ttsPitch', ttsPitch);
  }

  Future<void> resetProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All progress has been reset!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Theme Toggle
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: isDarkMode, // current dark mode value
                onChanged: (value) {
                  setState(() => isDarkMode = value); // update local state
                  themeNotifier.value =              // update the global theme
                  isDarkMode ? ThemeMode.dark : ThemeMode.light;
                  saveSettings();                    // save to SharedPreferences
                },
              ),
            ),
            const SizedBox(height: 16),

            // TTS Speed
            ListTile(
              title: const Text('TTS Speed'),
              subtitle: Slider(
                value: ttsSpeed,
                min: 0.1,
                max: 2.0,
                divisions: 19,
                label: ttsSpeed.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() => ttsSpeed = value);
                  saveSettings();
                },
              ),
            ),
            const SizedBox(height: 16),

            // TTS Pitch
            ListTile(
              title: const Text('TTS Pitch'),
              subtitle: Slider(
                value: ttsPitch,
                min: 0.5,
                max: 2.0,
                divisions: 15,
                label: ttsPitch.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() => ttsPitch = value);
                  saveSettings();
                },
              ),
            ),
            const SizedBox(height: 16),

            // Reset Progress
            ElevatedButton(
              onPressed: resetProgress,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent),
              child: const Text('Reset Progress'),
            ),
          ],
        ),
      ),
    );
  }
}
