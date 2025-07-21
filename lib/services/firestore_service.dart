import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_item.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get menu items
  Stream<List<FoodItem>> getMenuItems() {
    return _db.collection('menu_items').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return FoodItem.fromFirestore(doc.data(), doc.id);
      }).toList();
    });
  }

  // Add sample menu items (for initial setup)
  Future<void> addSampleMenuItems() async {
    final sampleItems = [
      {
        'name': 'Classic Burger',
        'description': 'Juicy beef patty with lettuce, tomato, and cheese',
        'price': 12.99,
        'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300',
        'category': 'Main Course',
      },
      {
        'name': 'Margherita Pizza',
        'description': 'Fresh mozzarella, tomatoes, and basil',
        'price': 14.99,
        'imageUrl': 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=300',
        'category': 'Main Course',
      },
      {
        'name': 'Caesar Salad',
        'description': 'Crisp romaine lettuce with parmesan and croutons',
        'price': 8.99,
        'imageUrl': 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=300',
        'category': 'Salad',
      },
      {
        'name': 'Chocolate Cake',
        'description': 'Rich chocolate cake with vanilla ice cream',
        'price': 6.99,
        'imageUrl': 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=300',
        'category': 'Dessert',
      },
    ];

    for (var item in sampleItems) {
      await _db.collection('menu_items').add(item);
    }
  }
}