// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_counter_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCartCounterModelCollection on Isar {
  IsarCollection<CartCounterModel> get cartCounterModels => this.collection();
}

const CartCounterModelSchema = CollectionSchema(
  name: r'CartCounterModel',
  id: 201795983230789637,
  properties: {
    r'count': PropertySchema(
      id: 0,
      name: r'count',
      type: IsarType.long,
    ),
    r'partId': PropertySchema(
      id: 1,
      name: r'partId',
      type: IsarType.long,
    )
  },
  estimateSize: _cartCounterModelEstimateSize,
  serialize: _cartCounterModelSerialize,
  deserialize: _cartCounterModelDeserialize,
  deserializeProp: _cartCounterModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _cartCounterModelGetId,
  getLinks: _cartCounterModelGetLinks,
  attach: _cartCounterModelAttach,
  version: '3.1.0+1',
);

int _cartCounterModelEstimateSize(
  CartCounterModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _cartCounterModelSerialize(
  CartCounterModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.count);
  writer.writeLong(offsets[1], object.partId);
}

CartCounterModel _cartCounterModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CartCounterModel();
  object.count = reader.readLong(offsets[0]);
  object.id = id;
  object.partId = reader.readLong(offsets[1]);
  return object;
}

P _cartCounterModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cartCounterModelGetId(CartCounterModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cartCounterModelGetLinks(CartCounterModel object) {
  return [];
}

void _cartCounterModelAttach(
    IsarCollection<dynamic> col, Id id, CartCounterModel object) {
  object.id = id;
}

extension CartCounterModelQueryWhereSort
    on QueryBuilder<CartCounterModel, CartCounterModel, QWhere> {
  QueryBuilder<CartCounterModel, CartCounterModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CartCounterModelQueryWhere
    on QueryBuilder<CartCounterModel, CartCounterModel, QWhereClause> {
  QueryBuilder<CartCounterModel, CartCounterModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CartCounterModelQueryFilter
    on QueryBuilder<CartCounterModel, CartCounterModel, QFilterCondition> {
  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      countEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      countGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      countLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'count',
        value: value,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      countBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'count',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      partIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partId',
        value: value,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      partIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'partId',
        value: value,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      partIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'partId',
        value: value,
      ));
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterFilterCondition>
      partIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'partId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CartCounterModelQueryObject
    on QueryBuilder<CartCounterModel, CartCounterModel, QFilterCondition> {}

extension CartCounterModelQueryLinks
    on QueryBuilder<CartCounterModel, CartCounterModel, QFilterCondition> {}

extension CartCounterModelQuerySortBy
    on QueryBuilder<CartCounterModel, CartCounterModel, QSortBy> {
  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy> sortByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy>
      sortByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy>
      sortByPartId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partId', Sort.asc);
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy>
      sortByPartIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partId', Sort.desc);
    });
  }
}

extension CartCounterModelQuerySortThenBy
    on QueryBuilder<CartCounterModel, CartCounterModel, QSortThenBy> {
  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy> thenByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.asc);
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy>
      thenByCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'count', Sort.desc);
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy>
      thenByPartId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partId', Sort.asc);
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QAfterSortBy>
      thenByPartIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partId', Sort.desc);
    });
  }
}

extension CartCounterModelQueryWhereDistinct
    on QueryBuilder<CartCounterModel, CartCounterModel, QDistinct> {
  QueryBuilder<CartCounterModel, CartCounterModel, QDistinct>
      distinctByCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'count');
    });
  }

  QueryBuilder<CartCounterModel, CartCounterModel, QDistinct>
      distinctByPartId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partId');
    });
  }
}

extension CartCounterModelQueryProperty
    on QueryBuilder<CartCounterModel, CartCounterModel, QQueryProperty> {
  QueryBuilder<CartCounterModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CartCounterModel, int, QQueryOperations> countProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'count');
    });
  }

  QueryBuilder<CartCounterModel, int, QQueryOperations> partIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partId');
    });
  }
}
