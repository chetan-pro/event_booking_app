import 'dart:convert';

FilterCategoryModel filterCategoryModelFromJson(String str) =>
    FilterCategoryModel.fromJson(json.decode(str));

String filterCategoryModelToJson(FilterCategoryModel data) =>
    json.encode(data.toJson());

class FilterCategoryModel {
  FilterCategoryModel({
    this.success,
    this.data,
    this.error,
  });

  int? success;
  List<Datum>? data;
  dynamic error;

  factory FilterCategoryModel.fromJson(Map<String, dynamic> json) =>
      FilterCategoryModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "error": error,
      };
}

class Datum {
  Datum({
    this.termId,
    this.name,
    this.slug,
    this.termGroup,
    this.termTaxonomyId,
    this.taxonomy,
    this.description,
    this.parent,
    this.count,
    this.filter,
  });

  int? termId;
  String? name;
  String? slug;
  int? termGroup;
  int? termTaxonomyId;
  String? taxonomy;
  String? description;
  int? parent;
  int? count;
  String? filter;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        termId: json["term_id"],
        name: json["name"],
        slug: json["slug"],
        termGroup: json["term_group"],
        termTaxonomyId: json["term_taxonomy_id"],
        taxonomy: json["taxonomy"],
        description: json["description"],
        parent: json["parent"],
        count: json["count"],
        filter: json["filter"],
      );

  Map<String, dynamic> toJson() => {
        "term_id": termId,
        "name": name,
        "slug": slug,
        "term_group": termGroup,
        "term_taxonomy_id": termTaxonomyId,
        "taxonomy": taxonomy,
        "description": description,
        "parent": parent,
        "count": count,
        "filter": filter,
      };
}
