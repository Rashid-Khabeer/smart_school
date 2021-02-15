import 'package:json_annotation/json_annotation.dart';

part 'library_model.g.dart';

@JsonSerializable()
class LibraryIssued {
  @JsonKey(name: 'book_title')
  String bookTitle;
  String author;
  @JsonKey(name: 'book_no')
  String bookNo;
  @JsonKey(name: 'issue_date')
  String issueDate;
  @JsonKey(name: 'return_date')
  String returnDate;
  @JsonKey(name: 'due_return_date')
  String dueReturnDate;
  @JsonKey(name: 'is_returned')
  String isReturned;

  LibraryIssued({
    this.author,
    this.bookNo,
    this.bookTitle,
    this.dueReturnDate,
    this.isReturned,
    this.issueDate,
    this.returnDate,
  });

  factory LibraryIssued.fromJson(Map<String, dynamic> json) =>
      _$LibraryIssuedFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryIssuedToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LibraryBooks {
  String success;

  List<LibraryBooksData> data;

  LibraryBooks({this.data, this.success});

  factory LibraryBooks.fromJson(Map<String, dynamic> json) =>
      _$LibraryBooksFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryBooksToJson(this);
}

@JsonSerializable()
class LibraryBooksData {
  @JsonKey(name: 'book_title')
  String bookTitle;
  @JsonKey(name: 'book_no')
  String bookNo;
  @JsonKey(name: 'isbn_no')
  String isbn;
  String subject;
  @JsonKey(name: 'rack_no')
  String rackNo;
  String publish;
  String author;
  String qty;
  @JsonKey(name: 'perunitcost')
  String perUnitCost;
  @JsonKey(name: 'postdate')
  String postDate;
  String description;
  String available;
  @JsonKey(name: 'is_active')
  String isActive;
  @JsonKey(name: 'created_at')
  String createdAt;
  @JsonKey(name: 'updated_at')
  String updatedAt;

  LibraryBooksData({
    this.bookTitle,
    this.bookNo,
    this.author,
    this.isActive,
    this.available,
    this.subject,
    this.createdAt,
    this.description,
    this.updatedAt,
    this.isbn,
    this.perUnitCost,
    this.postDate,
    this.publish,
    this.qty,
    this.rackNo,
  });

  factory LibraryBooksData.fromJson(Map<String, dynamic> json) =>
      _$LibraryBooksDataFromJson(json);

  Map<String, dynamic> toJson() => _$LibraryBooksDataToJson(this);
}
