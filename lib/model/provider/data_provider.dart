import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../category_model.dart';
import '../news_model.dart';

String apikey = "29abcaa60389414cb8538e1baef5651d";

class NewsData {
  List<News> newsData;
  String searchKeyword;

  NewsData({required this.newsData, required this.searchKeyword});

  factory NewsData.fromJson(Map<String, dynamic> json) {
    return NewsData(
      newsData: List<News>.from(
          json['newsData']?.map((item) => News.fromJson(item)) ?? []),
      searchKeyword: json['searchKeyword'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'newsData': newsData.map((item) => item.toJson()).toList(),
      'searchKeyword': searchKeyword,
    };
  }

  NewsData copyWith({
    List<News>? newsData,
    String? searchKeyword,
  }) {
    return NewsData(
      newsData: newsData ?? this.newsData,
      searchKeyword: searchKeyword ?? this.searchKeyword,
    );
  }
}

class NewsNotifier extends StateNotifier<NewsData> {
  NewsNotifier(this.ref) : super(NewsData(newsData: [], searchKeyword: "the"));
  String newWord = "the";
  final Ref ref;

  Future<void> fetchNews() async {
    print(state.searchKeyword);
    final url =
        'https://newsapi.org/v2/everything?q=${state.searchKeyword}&apiKey=$apikey';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> articles = data['articles'];
        final List<News> newsList =
            articles.map((json) => News.fromJson(json)).toList();
        state = state.copyWith(newsData: newsList, searchKeyword: newWord);
      } else {
        throw Exception('Failed to load news');
      }
    } catch (error) {
      print("1: $error");
      throw error;
    }
  }

  Future<void> refresh() async {
    fetchNews();
  }

  Future<void> setSearchKeyword(String search) async {
    if (newWord == search) {
      newWord = "the";
    } else {
      newWord = search;
    }
    for (int i = 0; i < predefinedCategories.length; i++) {
      if (search == predefinedCategories[i].keyword.toString()) {
        predefinedCategories[i].isSelected = 1;
      } else {
        predefinedCategories[i].isSelected = 0;
      }
    }
    if (newWord == "the") {
      predefinedCategories.sort((a, b) => b.id!.compareTo(a.id!));
    } else {
      predefinedCategories.sort((a, b) => b.isSelected.compareTo(a.isSelected));
    }

    for (int i = 0; i < predefinedCategories.length; i++) {
      print(predefinedCategories[i].name);
    }
    ref
        .read(categoriesProvider.notifier)
        .updateCategories(predefinedCategories);
    await fetchNews();
    // here
  }
}

final newsNotifierProvider =
    StateNotifierProvider<NewsNotifier, NewsData>((ref) => NewsNotifier(ref));

final newsProvider = FutureProvider<NewsData>((ref) async {
  final newsNotifier = ref.watch(newsNotifierProvider.notifier);
  await newsNotifier.fetchNews();
  return ref.watch(newsNotifierProvider);
});

//
class CategoriesNotifier extends StateNotifier<List<Categories>> {
  CategoriesNotifier() : super(predefinedCategories);
  void updateCategories(List<Categories> categories) {
    state = categories;
  }
}

final categoriesProvider =
    StateNotifierProvider<CategoriesNotifier, List<Categories>>(
  (ref) => CategoriesNotifier(),
);
