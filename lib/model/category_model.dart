import 'package:flutter/material.dart';

class Categories {
  int? id;
  String? name;
  String? keyword;
  IconData? icon;
  int isSelected;

  Categories({
    this.id,
    this.name,
    this.keyword,
    this.icon,
    this.isSelected = 0,
  });
}

// List of predefined categories
final List<Categories> predefinedCategories = [
  Categories(
      id: 1,
      name: 'Technology',
      keyword: 'technology',
      icon: Icons.computer,
      isSelected: 0),
  Categories(
      id: 2,
      name: 'Sports',
      keyword: 'sports',
      icon: Icons.sports_football,
      isSelected: 0),
  Categories(
      id: 3,
      name: 'Business',
      keyword: 'business',
      icon: Icons.business,
      isSelected: 0),
  Categories(
      id: 4,
      name: 'Entertainment',
      keyword: 'entertainment',
      icon: Icons.movie,
      isSelected: 0),
  Categories(
      id: 5,
      name: 'Health',
      keyword: 'health',
      icon: Icons.health_and_safety,
      isSelected: 0),
  Categories(
      id: 6,
      name: 'Science',
      keyword: 'science',
      icon: Icons.science,
      isSelected: 0),
  Categories(
      id: 7,
      name: 'World',
      keyword: 'world',
      icon: Icons.public,
      isSelected: 0),
  Categories(
      id: 8,
      name: 'Finance',
      keyword: 'finance',
      icon: Icons.attach_money,
      isSelected: 0),
  Categories(
      id: 9,
      name: 'Politics',
      keyword: 'politics',
      icon: Icons.account_balance,
      isSelected: 0),
  Categories(
      id: 10,
      name: 'Travel',
      keyword: 'travel',
      icon: Icons.travel_explore,
      isSelected: 0),
  Categories(
      id: 11,
      name: 'Food',
      keyword: 'food',
      icon: Icons.fastfood,
      isSelected: 0),
  Categories(
      id: 12,
      name: 'Fashion',
      keyword: 'fashion',
      icon: Icons.checkroom,
      isSelected: 0),
  Categories(
      id: 13,
      name: 'Education',
      keyword: 'education',
      icon: Icons.school,
      isSelected: 0),
  Categories(
      id: 15,
      name: 'Weather',
      keyword: 'weather',
      icon: Icons.wb_sunny,
      isSelected: 0),
  Categories(
      id: 16,
      name: 'Environment',
      keyword: 'environment',
      icon: Icons.eco,
      isSelected: 0),
  Categories(
      id: 17,
      name: 'History',
      keyword: 'history',
      icon: Icons.history_edu,
      isSelected: 0),
  Categories(
      id: 18,
      name: 'Automotive',
      keyword: 'automotive',
      icon: Icons.directions_car,
      isSelected: 0),
  Categories(
      id: 19,
      name: 'Gaming',
      keyword: 'gaming',
      icon: Icons.videogame_asset,
      isSelected: 0),
  Categories(
      id: 20,
      name: 'Music',
      keyword: 'music',
      icon: Icons.music_note,
      isSelected: 0),
  Categories(
      id: 21,
      name: 'Literature',
      keyword: 'literature',
      icon: Icons.menu_book,
      isSelected: 0),
  Categories(
      id: 22, name: 'Art', keyword: 'art', icon: Icons.palette, isSelected: 0),
  Categories(
      id: 23,
      name: 'Lifestyle',
      keyword: 'lifestyle',
      icon: Icons.self_improvement,
      isSelected: 0),
  Categories(
      id: 24,
      name: 'Animals',
      keyword: 'animals',
      icon: Icons.pets,
      isSelected: 0),
  Categories(
      id: 27,
      name: 'Opinion',
      keyword: 'opinion',
      icon: Icons.comment,
      isSelected: 0),
  Categories(
      id: 28,
      name: 'Relationships',
      keyword: 'relationships',
      icon: Icons.favorite,
      isSelected: 0),
  Categories(
      id: 29,
      name: 'Shopping',
      keyword: 'shopping',
      icon: Icons.shopping_cart,
      isSelected: 0),
];
