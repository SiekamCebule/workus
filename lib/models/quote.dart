class Quote {
  const Quote({this.author, required this.content});

  final String? author;
  final String content;

  bool get hasAuthor => author != null;

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      author: json['author'] as String?,
      content: json['content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'content': content,
    };
  }

  @override
  String toString() {
    return 'Quote{author: $author, content: $content}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final Quote otherQuote = other as Quote;
    return author == otherQuote.author && content == otherQuote.content;
  }

  @override
  int get hashCode {
    return author.hashCode ^ content.hashCode;
  }
}
