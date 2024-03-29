import 'package:equatable/equatable.dart';

class Menu extends Equatable {
  final String _id;
  final String? _userId;
  final String? _title;
  final String? _summary;
  final String? _content;
  final String? _imageUrl;

  const Menu({
    required String id,
    String? userId,
    String? title,
    String? summary,
    String? content,
    String? imageUrl,
  })  : _id = id,
        _userId = userId,
        _title = title,
        _summary = summary,
        _content = content,
        _imageUrl = imageUrl;

  static Menu empty(String? userId) {
    return Menu(
        id: '',
        userId: userId ?? '',
        title: 'Title',
        summary: 'Summary',
        content: 'content',
        imageUrl: 'http://192.168.0.252:3000/items/ph/hot-pot.png');
  }

  copyWith({
    String? userId,
    String? title,
    String? summary,
    String? content,
    String? imageUrl,
  }) {
    return Menu(
      id: _id,
      title: title ?? _title,
      userId: userId ?? _userId,
      content: content ?? _content,
      summary: summary ?? _summary,
      imageUrl: imageUrl ?? _imageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': _userId,
        'title': _title,
        'summary': _summary,
        'content': _content,
        "imageUrl": _imageUrl,
      };

  static fromJson(Map<dynamic, dynamic> data) {
    return Menu(
      id: '${data['_id']}',
      userId: '${data['userId']}',
      title: '${data['title']}',
      summary: '${data['summary']}',
      content: '${data['content']}',
      imageUrl: '${data['imageUrl']}',
    );
  }

  String? get id => _id;
  String? get userId => _userId;
  String? get title => _title;
  String? get summary => _summary;
  String? get content => _content;
  String? get imageUrl => _imageUrl;

  @override
  List<Object?> get props => [
        _id,
        _userId,
        _title,
        _summary,
        _content,
        _imageUrl,
      ];
}
