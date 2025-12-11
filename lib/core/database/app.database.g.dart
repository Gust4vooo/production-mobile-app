// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.database.dart';

// ignore_for_file: type=lint
class $ProduksiTable extends Produksi
    with TableInfo<$ProduksiTable, ProduksiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProduksiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _kodeProduksiMeta =
      const VerificationMeta('kodeProduksi');
  @override
  late final GeneratedColumn<String> kodeProduksi = GeneratedColumn<String>(
      'kode_produksi', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _tujuanPengirimanMeta =
      const VerificationMeta('tujuanPengiriman');
  @override
  late final GeneratedColumn<String> tujuanPengiriman = GeneratedColumn<String>(
      'tujuan_pengiriman', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tanggalPengirimanMeta =
      const VerificationMeta('tanggalPengiriman');
  @override
  late final GeneratedColumn<DateTime> tanggalPengiriman =
      GeneratedColumn<DateTime>('tanggal_pengiriman', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<ProduksiStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<ProduksiStatus>($ProduksiTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns =>
      [id, kodeProduksi, tujuanPengiriman, tanggalPengiriman, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'produksi';
  @override
  VerificationContext validateIntegrity(Insertable<ProduksiData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('kode_produksi')) {
      context.handle(
          _kodeProduksiMeta,
          kodeProduksi.isAcceptableOrUnknown(
              data['kode_produksi']!, _kodeProduksiMeta));
    }
    if (data.containsKey('tujuan_pengiriman')) {
      context.handle(
          _tujuanPengirimanMeta,
          tujuanPengiriman.isAcceptableOrUnknown(
              data['tujuan_pengiriman']!, _tujuanPengirimanMeta));
    } else if (isInserting) {
      context.missing(_tujuanPengirimanMeta);
    }
    if (data.containsKey('tanggal_pengiriman')) {
      context.handle(
          _tanggalPengirimanMeta,
          tanggalPengiriman.isAcceptableOrUnknown(
              data['tanggal_pengiriman']!, _tanggalPengirimanMeta));
    } else if (isInserting) {
      context.missing(_tanggalPengirimanMeta);
    }
    context.handle(_statusMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProduksiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProduksiData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      kodeProduksi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kode_produksi']),
      tujuanPengiriman: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}tujuan_pengiriman'])!,
      tanggalPengiriman: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}tanggal_pengiriman'])!,
      status: $ProduksiTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
    );
  }

  @override
  $ProduksiTable createAlias(String alias) {
    return $ProduksiTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ProduksiStatus, int, int> $converterstatus =
      const EnumIndexConverter<ProduksiStatus>(ProduksiStatus.values);
}

class ProduksiData extends DataClass implements Insertable<ProduksiData> {
  final int id;
  final String? kodeProduksi;
  final String tujuanPengiriman;
  final DateTime tanggalPengiriman;
  final ProduksiStatus status;
  const ProduksiData(
      {required this.id,
      this.kodeProduksi,
      required this.tujuanPengiriman,
      required this.tanggalPengiriman,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || kodeProduksi != null) {
      map['kode_produksi'] = Variable<String>(kodeProduksi);
    }
    map['tujuan_pengiriman'] = Variable<String>(tujuanPengiriman);
    map['tanggal_pengiriman'] = Variable<DateTime>(tanggalPengiriman);
    {
      map['status'] =
          Variable<int>($ProduksiTable.$converterstatus.toSql(status));
    }
    return map;
  }

  ProduksiCompanion toCompanion(bool nullToAbsent) {
    return ProduksiCompanion(
      id: Value(id),
      kodeProduksi: kodeProduksi == null && nullToAbsent
          ? const Value.absent()
          : Value(kodeProduksi),
      tujuanPengiriman: Value(tujuanPengiriman),
      tanggalPengiriman: Value(tanggalPengiriman),
      status: Value(status),
    );
  }

  factory ProduksiData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProduksiData(
      id: serializer.fromJson<int>(json['id']),
      kodeProduksi: serializer.fromJson<String?>(json['kodeProduksi']),
      tujuanPengiriman: serializer.fromJson<String>(json['tujuanPengiriman']),
      tanggalPengiriman:
          serializer.fromJson<DateTime>(json['tanggalPengiriman']),
      status: $ProduksiTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'kodeProduksi': serializer.toJson<String?>(kodeProduksi),
      'tujuanPengiriman': serializer.toJson<String>(tujuanPengiriman),
      'tanggalPengiriman': serializer.toJson<DateTime>(tanggalPengiriman),
      'status': serializer
          .toJson<int>($ProduksiTable.$converterstatus.toJson(status)),
    };
  }

  ProduksiData copyWith(
          {int? id,
          Value<String?> kodeProduksi = const Value.absent(),
          String? tujuanPengiriman,
          DateTime? tanggalPengiriman,
          ProduksiStatus? status}) =>
      ProduksiData(
        id: id ?? this.id,
        kodeProduksi:
            kodeProduksi.present ? kodeProduksi.value : this.kodeProduksi,
        tujuanPengiriman: tujuanPengiriman ?? this.tujuanPengiriman,
        tanggalPengiriman: tanggalPengiriman ?? this.tanggalPengiriman,
        status: status ?? this.status,
      );
  ProduksiData copyWithCompanion(ProduksiCompanion data) {
    return ProduksiData(
      id: data.id.present ? data.id.value : this.id,
      kodeProduksi: data.kodeProduksi.present
          ? data.kodeProduksi.value
          : this.kodeProduksi,
      tujuanPengiriman: data.tujuanPengiriman.present
          ? data.tujuanPengiriman.value
          : this.tujuanPengiriman,
      tanggalPengiriman: data.tanggalPengiriman.present
          ? data.tanggalPengiriman.value
          : this.tanggalPengiriman,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProduksiData(')
          ..write('id: $id, ')
          ..write('kodeProduksi: $kodeProduksi, ')
          ..write('tujuanPengiriman: $tujuanPengiriman, ')
          ..write('tanggalPengiriman: $tanggalPengiriman, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, kodeProduksi, tujuanPengiriman, tanggalPengiriman, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProduksiData &&
          other.id == this.id &&
          other.kodeProduksi == this.kodeProduksi &&
          other.tujuanPengiriman == this.tujuanPengiriman &&
          other.tanggalPengiriman == this.tanggalPengiriman &&
          other.status == this.status);
}

class ProduksiCompanion extends UpdateCompanion<ProduksiData> {
  final Value<int> id;
  final Value<String?> kodeProduksi;
  final Value<String> tujuanPengiriman;
  final Value<DateTime> tanggalPengiriman;
  final Value<ProduksiStatus> status;
  const ProduksiCompanion({
    this.id = const Value.absent(),
    this.kodeProduksi = const Value.absent(),
    this.tujuanPengiriman = const Value.absent(),
    this.tanggalPengiriman = const Value.absent(),
    this.status = const Value.absent(),
  });
  ProduksiCompanion.insert({
    this.id = const Value.absent(),
    this.kodeProduksi = const Value.absent(),
    required String tujuanPengiriman,
    required DateTime tanggalPengiriman,
    this.status = const Value.absent(),
  })  : tujuanPengiriman = Value(tujuanPengiriman),
        tanggalPengiriman = Value(tanggalPengiriman);
  static Insertable<ProduksiData> custom({
    Expression<int>? id,
    Expression<String>? kodeProduksi,
    Expression<String>? tujuanPengiriman,
    Expression<DateTime>? tanggalPengiriman,
    Expression<int>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kodeProduksi != null) 'kode_produksi': kodeProduksi,
      if (tujuanPengiriman != null) 'tujuan_pengiriman': tujuanPengiriman,
      if (tanggalPengiriman != null) 'tanggal_pengiriman': tanggalPengiriman,
      if (status != null) 'status': status,
    });
  }

  ProduksiCompanion copyWith(
      {Value<int>? id,
      Value<String?>? kodeProduksi,
      Value<String>? tujuanPengiriman,
      Value<DateTime>? tanggalPengiriman,
      Value<ProduksiStatus>? status}) {
    return ProduksiCompanion(
      id: id ?? this.id,
      kodeProduksi: kodeProduksi ?? this.kodeProduksi,
      tujuanPengiriman: tujuanPengiriman ?? this.tujuanPengiriman,
      tanggalPengiriman: tanggalPengiriman ?? this.tanggalPengiriman,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (kodeProduksi.present) {
      map['kode_produksi'] = Variable<String>(kodeProduksi.value);
    }
    if (tujuanPengiriman.present) {
      map['tujuan_pengiriman'] = Variable<String>(tujuanPengiriman.value);
    }
    if (tanggalPengiriman.present) {
      map['tanggal_pengiriman'] = Variable<DateTime>(tanggalPengiriman.value);
    }
    if (status.present) {
      map['status'] =
          Variable<int>($ProduksiTable.$converterstatus.toSql(status.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProduksiCompanion(')
          ..write('id: $id, ')
          ..write('kodeProduksi: $kodeProduksi, ')
          ..write('tujuanPengiriman: $tujuanPengiriman, ')
          ..write('tanggalPengiriman: $tanggalPengiriman, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $ItemProduksiTable extends ItemProduksi
    with TableInfo<$ItemProduksiTable, ItemProduksiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemProduksiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _namaProdukMeta =
      const VerificationMeta('namaProduk');
  @override
  late final GeneratedColumn<String> namaProduk = GeneratedColumn<String>(
      'nama_produk', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ukuranMeta = const VerificationMeta('ukuran');
  @override
  late final GeneratedColumn<String> ukuran = GeneratedColumn<String>(
      'ukuran', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _jumlahMeta = const VerificationMeta('jumlah');
  @override
  late final GeneratedColumn<int> jumlah = GeneratedColumn<int>(
      'jumlah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _deskripsiMeta =
      const VerificationMeta('deskripsi');
  @override
  late final GeneratedColumn<String> deskripsi = GeneratedColumn<String>(
      'deskripsi', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tanggalProduksiMeta =
      const VerificationMeta('tanggalProduksi');
  @override
  late final GeneratedColumn<DateTime> tanggalProduksi =
      GeneratedColumn<DateTime>('tanggal_produksi', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _produksiIdMeta =
      const VerificationMeta('produksiId');
  @override
  late final GeneratedColumn<int> produksiId = GeneratedColumn<int>(
      'produksi_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES produksi (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, namaProduk, ukuran, jumlah, deskripsi, tanggalProduksi, produksiId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_produksi';
  @override
  VerificationContext validateIntegrity(Insertable<ItemProduksiData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_produk')) {
      context.handle(
          _namaProdukMeta,
          namaProduk.isAcceptableOrUnknown(
              data['nama_produk']!, _namaProdukMeta));
    } else if (isInserting) {
      context.missing(_namaProdukMeta);
    }
    if (data.containsKey('ukuran')) {
      context.handle(_ukuranMeta,
          ukuran.isAcceptableOrUnknown(data['ukuran']!, _ukuranMeta));
    } else if (isInserting) {
      context.missing(_ukuranMeta);
    }
    if (data.containsKey('jumlah')) {
      context.handle(_jumlahMeta,
          jumlah.isAcceptableOrUnknown(data['jumlah']!, _jumlahMeta));
    } else if (isInserting) {
      context.missing(_jumlahMeta);
    }
    if (data.containsKey('deskripsi')) {
      context.handle(_deskripsiMeta,
          deskripsi.isAcceptableOrUnknown(data['deskripsi']!, _deskripsiMeta));
    }
    if (data.containsKey('tanggal_produksi')) {
      context.handle(
          _tanggalProduksiMeta,
          tanggalProduksi.isAcceptableOrUnknown(
              data['tanggal_produksi']!, _tanggalProduksiMeta));
    } else if (isInserting) {
      context.missing(_tanggalProduksiMeta);
    }
    if (data.containsKey('produksi_id')) {
      context.handle(
          _produksiIdMeta,
          produksiId.isAcceptableOrUnknown(
              data['produksi_id']!, _produksiIdMeta));
    } else if (isInserting) {
      context.missing(_produksiIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemProduksiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemProduksiData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      namaProduk: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama_produk'])!,
      ukuran: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}ukuran'])!,
      jumlah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}jumlah'])!,
      deskripsi: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}deskripsi']),
      tanggalProduksi: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}tanggal_produksi'])!,
      produksiId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}produksi_id'])!,
    );
  }

  @override
  $ItemProduksiTable createAlias(String alias) {
    return $ItemProduksiTable(attachedDatabase, alias);
  }
}

class ItemProduksiData extends DataClass
    implements Insertable<ItemProduksiData> {
  final int id;
  final String namaProduk;
  final String ukuran;
  final int jumlah;
  final String? deskripsi;
  final DateTime tanggalProduksi;
  final int produksiId;
  const ItemProduksiData(
      {required this.id,
      required this.namaProduk,
      required this.ukuran,
      required this.jumlah,
      this.deskripsi,
      required this.tanggalProduksi,
      required this.produksiId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_produk'] = Variable<String>(namaProduk);
    map['ukuran'] = Variable<String>(ukuran);
    map['jumlah'] = Variable<int>(jumlah);
    if (!nullToAbsent || deskripsi != null) {
      map['deskripsi'] = Variable<String>(deskripsi);
    }
    map['tanggal_produksi'] = Variable<DateTime>(tanggalProduksi);
    map['produksi_id'] = Variable<int>(produksiId);
    return map;
  }

  ItemProduksiCompanion toCompanion(bool nullToAbsent) {
    return ItemProduksiCompanion(
      id: Value(id),
      namaProduk: Value(namaProduk),
      ukuran: Value(ukuran),
      jumlah: Value(jumlah),
      deskripsi: deskripsi == null && nullToAbsent
          ? const Value.absent()
          : Value(deskripsi),
      tanggalProduksi: Value(tanggalProduksi),
      produksiId: Value(produksiId),
    );
  }

  factory ItemProduksiData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemProduksiData(
      id: serializer.fromJson<int>(json['id']),
      namaProduk: serializer.fromJson<String>(json['namaProduk']),
      ukuran: serializer.fromJson<String>(json['ukuran']),
      jumlah: serializer.fromJson<int>(json['jumlah']),
      deskripsi: serializer.fromJson<String?>(json['deskripsi']),
      tanggalProduksi: serializer.fromJson<DateTime>(json['tanggalProduksi']),
      produksiId: serializer.fromJson<int>(json['produksiId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaProduk': serializer.toJson<String>(namaProduk),
      'ukuran': serializer.toJson<String>(ukuran),
      'jumlah': serializer.toJson<int>(jumlah),
      'deskripsi': serializer.toJson<String?>(deskripsi),
      'tanggalProduksi': serializer.toJson<DateTime>(tanggalProduksi),
      'produksiId': serializer.toJson<int>(produksiId),
    };
  }

  ItemProduksiData copyWith(
          {int? id,
          String? namaProduk,
          String? ukuran,
          int? jumlah,
          Value<String?> deskripsi = const Value.absent(),
          DateTime? tanggalProduksi,
          int? produksiId}) =>
      ItemProduksiData(
        id: id ?? this.id,
        namaProduk: namaProduk ?? this.namaProduk,
        ukuran: ukuran ?? this.ukuran,
        jumlah: jumlah ?? this.jumlah,
        deskripsi: deskripsi.present ? deskripsi.value : this.deskripsi,
        tanggalProduksi: tanggalProduksi ?? this.tanggalProduksi,
        produksiId: produksiId ?? this.produksiId,
      );
  ItemProduksiData copyWithCompanion(ItemProduksiCompanion data) {
    return ItemProduksiData(
      id: data.id.present ? data.id.value : this.id,
      namaProduk:
          data.namaProduk.present ? data.namaProduk.value : this.namaProduk,
      ukuran: data.ukuran.present ? data.ukuran.value : this.ukuran,
      jumlah: data.jumlah.present ? data.jumlah.value : this.jumlah,
      deskripsi: data.deskripsi.present ? data.deskripsi.value : this.deskripsi,
      tanggalProduksi: data.tanggalProduksi.present
          ? data.tanggalProduksi.value
          : this.tanggalProduksi,
      produksiId:
          data.produksiId.present ? data.produksiId.value : this.produksiId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemProduksiData(')
          ..write('id: $id, ')
          ..write('namaProduk: $namaProduk, ')
          ..write('ukuran: $ukuran, ')
          ..write('jumlah: $jumlah, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('tanggalProduksi: $tanggalProduksi, ')
          ..write('produksiId: $produksiId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, namaProduk, ukuran, jumlah, deskripsi, tanggalProduksi, produksiId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemProduksiData &&
          other.id == this.id &&
          other.namaProduk == this.namaProduk &&
          other.ukuran == this.ukuran &&
          other.jumlah == this.jumlah &&
          other.deskripsi == this.deskripsi &&
          other.tanggalProduksi == this.tanggalProduksi &&
          other.produksiId == this.produksiId);
}

class ItemProduksiCompanion extends UpdateCompanion<ItemProduksiData> {
  final Value<int> id;
  final Value<String> namaProduk;
  final Value<String> ukuran;
  final Value<int> jumlah;
  final Value<String?> deskripsi;
  final Value<DateTime> tanggalProduksi;
  final Value<int> produksiId;
  const ItemProduksiCompanion({
    this.id = const Value.absent(),
    this.namaProduk = const Value.absent(),
    this.ukuran = const Value.absent(),
    this.jumlah = const Value.absent(),
    this.deskripsi = const Value.absent(),
    this.tanggalProduksi = const Value.absent(),
    this.produksiId = const Value.absent(),
  });
  ItemProduksiCompanion.insert({
    this.id = const Value.absent(),
    required String namaProduk,
    required String ukuran,
    required int jumlah,
    this.deskripsi = const Value.absent(),
    required DateTime tanggalProduksi,
    required int produksiId,
  })  : namaProduk = Value(namaProduk),
        ukuran = Value(ukuran),
        jumlah = Value(jumlah),
        tanggalProduksi = Value(tanggalProduksi),
        produksiId = Value(produksiId);
  static Insertable<ItemProduksiData> custom({
    Expression<int>? id,
    Expression<String>? namaProduk,
    Expression<String>? ukuran,
    Expression<int>? jumlah,
    Expression<String>? deskripsi,
    Expression<DateTime>? tanggalProduksi,
    Expression<int>? produksiId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaProduk != null) 'nama_produk': namaProduk,
      if (ukuran != null) 'ukuran': ukuran,
      if (jumlah != null) 'jumlah': jumlah,
      if (deskripsi != null) 'deskripsi': deskripsi,
      if (tanggalProduksi != null) 'tanggal_produksi': tanggalProduksi,
      if (produksiId != null) 'produksi_id': produksiId,
    });
  }

  ItemProduksiCompanion copyWith(
      {Value<int>? id,
      Value<String>? namaProduk,
      Value<String>? ukuran,
      Value<int>? jumlah,
      Value<String?>? deskripsi,
      Value<DateTime>? tanggalProduksi,
      Value<int>? produksiId}) {
    return ItemProduksiCompanion(
      id: id ?? this.id,
      namaProduk: namaProduk ?? this.namaProduk,
      ukuran: ukuran ?? this.ukuran,
      jumlah: jumlah ?? this.jumlah,
      deskripsi: deskripsi ?? this.deskripsi,
      tanggalProduksi: tanggalProduksi ?? this.tanggalProduksi,
      produksiId: produksiId ?? this.produksiId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaProduk.present) {
      map['nama_produk'] = Variable<String>(namaProduk.value);
    }
    if (ukuran.present) {
      map['ukuran'] = Variable<String>(ukuran.value);
    }
    if (jumlah.present) {
      map['jumlah'] = Variable<int>(jumlah.value);
    }
    if (deskripsi.present) {
      map['deskripsi'] = Variable<String>(deskripsi.value);
    }
    if (tanggalProduksi.present) {
      map['tanggal_produksi'] = Variable<DateTime>(tanggalProduksi.value);
    }
    if (produksiId.present) {
      map['produksi_id'] = Variable<int>(produksiId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemProduksiCompanion(')
          ..write('id: $id, ')
          ..write('namaProduk: $namaProduk, ')
          ..write('ukuran: $ukuran, ')
          ..write('jumlah: $jumlah, ')
          ..write('deskripsi: $deskripsi, ')
          ..write('tanggalProduksi: $tanggalProduksi, ')
          ..write('produksiId: $produksiId')
          ..write(')'))
        .toString();
  }
}

class $KartuStokTable extends KartuStok
    with TableInfo<$KartuStokTable, KartuStokData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KartuStokTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
      'nama', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gambarPathMeta =
      const VerificationMeta('gambarPath');
  @override
  late final GeneratedColumn<String> gambarPath = GeneratedColumn<String>(
      'gambar_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _jumlahMeta = const VerificationMeta('jumlah');
  @override
  late final GeneratedColumn<int> jumlah = GeneratedColumn<int>(
      'jumlah', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _satuanMeta = const VerificationMeta('satuan');
  @override
  late final GeneratedColumn<String> satuan = GeneratedColumn<String>(
      'satuan', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<StockStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<StockStatus>($KartuStokTable.$converterstatus);
  static const VerificationMeta _jenisMeta = const VerificationMeta('jenis');
  @override
  late final GeneratedColumnWithTypeConverter<JenisBahan, int> jenis =
      GeneratedColumn<int>('jenis', aliasedName, false,
              type: DriftSqlType.int,
              requiredDuringInsert: false,
              defaultValue: const Constant(0))
          .withConverter<JenisBahan>($KartuStokTable.$converterjenis);
  @override
  List<GeneratedColumn> get $columns =>
      [id, nama, gambarPath, jumlah, satuan, status, jenis];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kartu_stok';
  @override
  VerificationContext validateIntegrity(Insertable<KartuStokData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
          _namaMeta, nama.isAcceptableOrUnknown(data['nama']!, _namaMeta));
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('gambar_path')) {
      context.handle(
          _gambarPathMeta,
          gambarPath.isAcceptableOrUnknown(
              data['gambar_path']!, _gambarPathMeta));
    }
    if (data.containsKey('jumlah')) {
      context.handle(_jumlahMeta,
          jumlah.isAcceptableOrUnknown(data['jumlah']!, _jumlahMeta));
    } else if (isInserting) {
      context.missing(_jumlahMeta);
    }
    if (data.containsKey('satuan')) {
      context.handle(_satuanMeta,
          satuan.isAcceptableOrUnknown(data['satuan']!, _satuanMeta));
    } else if (isInserting) {
      context.missing(_satuanMeta);
    }
    context.handle(_statusMeta, const VerificationResult.success());
    context.handle(_jenisMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KartuStokData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KartuStokData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nama: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama'])!,
      gambarPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gambar_path']),
      jumlah: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}jumlah'])!,
      satuan: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}satuan'])!,
      status: $KartuStokTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      jenis: $KartuStokTable.$converterjenis.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}jenis'])!),
    );
  }

  @override
  $KartuStokTable createAlias(String alias) {
    return $KartuStokTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StockStatus, int, int> $converterstatus =
      const EnumIndexConverter<StockStatus>(StockStatus.values);
  static JsonTypeConverter2<JenisBahan, int, int> $converterjenis =
      const EnumIndexConverter<JenisBahan>(JenisBahan.values);
}

class KartuStokData extends DataClass implements Insertable<KartuStokData> {
  final int id;
  final String nama;
  final String? gambarPath;
  final int jumlah;
  final String satuan;
  final StockStatus status;
  final JenisBahan jenis;
  const KartuStokData(
      {required this.id,
      required this.nama,
      this.gambarPath,
      required this.jumlah,
      required this.satuan,
      required this.status,
      required this.jenis});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    if (!nullToAbsent || gambarPath != null) {
      map['gambar_path'] = Variable<String>(gambarPath);
    }
    map['jumlah'] = Variable<int>(jumlah);
    map['satuan'] = Variable<String>(satuan);
    {
      map['status'] =
          Variable<int>($KartuStokTable.$converterstatus.toSql(status));
    }
    {
      map['jenis'] =
          Variable<int>($KartuStokTable.$converterjenis.toSql(jenis));
    }
    return map;
  }

  KartuStokCompanion toCompanion(bool nullToAbsent) {
    return KartuStokCompanion(
      id: Value(id),
      nama: Value(nama),
      gambarPath: gambarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(gambarPath),
      jumlah: Value(jumlah),
      satuan: Value(satuan),
      status: Value(status),
      jenis: Value(jenis),
    );
  }

  factory KartuStokData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KartuStokData(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      gambarPath: serializer.fromJson<String?>(json['gambarPath']),
      jumlah: serializer.fromJson<int>(json['jumlah']),
      satuan: serializer.fromJson<String>(json['satuan']),
      status: $KartuStokTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
      jenis: $KartuStokTable.$converterjenis
          .fromJson(serializer.fromJson<int>(json['jenis'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'gambarPath': serializer.toJson<String?>(gambarPath),
      'jumlah': serializer.toJson<int>(jumlah),
      'satuan': serializer.toJson<String>(satuan),
      'status': serializer
          .toJson<int>($KartuStokTable.$converterstatus.toJson(status)),
      'jenis':
          serializer.toJson<int>($KartuStokTable.$converterjenis.toJson(jenis)),
    };
  }

  KartuStokData copyWith(
          {int? id,
          String? nama,
          Value<String?> gambarPath = const Value.absent(),
          int? jumlah,
          String? satuan,
          StockStatus? status,
          JenisBahan? jenis}) =>
      KartuStokData(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        gambarPath: gambarPath.present ? gambarPath.value : this.gambarPath,
        jumlah: jumlah ?? this.jumlah,
        satuan: satuan ?? this.satuan,
        status: status ?? this.status,
        jenis: jenis ?? this.jenis,
      );
  KartuStokData copyWithCompanion(KartuStokCompanion data) {
    return KartuStokData(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      gambarPath:
          data.gambarPath.present ? data.gambarPath.value : this.gambarPath,
      jumlah: data.jumlah.present ? data.jumlah.value : this.jumlah,
      satuan: data.satuan.present ? data.satuan.value : this.satuan,
      status: data.status.present ? data.status.value : this.status,
      jenis: data.jenis.present ? data.jenis.value : this.jenis,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KartuStokData(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('gambarPath: $gambarPath, ')
          ..write('jumlah: $jumlah, ')
          ..write('satuan: $satuan, ')
          ..write('status: $status, ')
          ..write('jenis: $jenis')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nama, gambarPath, jumlah, satuan, status, jenis);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KartuStokData &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.gambarPath == this.gambarPath &&
          other.jumlah == this.jumlah &&
          other.satuan == this.satuan &&
          other.status == this.status &&
          other.jenis == this.jenis);
}

class KartuStokCompanion extends UpdateCompanion<KartuStokData> {
  final Value<int> id;
  final Value<String> nama;
  final Value<String?> gambarPath;
  final Value<int> jumlah;
  final Value<String> satuan;
  final Value<StockStatus> status;
  final Value<JenisBahan> jenis;
  const KartuStokCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.gambarPath = const Value.absent(),
    this.jumlah = const Value.absent(),
    this.satuan = const Value.absent(),
    this.status = const Value.absent(),
    this.jenis = const Value.absent(),
  });
  KartuStokCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    this.gambarPath = const Value.absent(),
    required int jumlah,
    required String satuan,
    this.status = const Value.absent(),
    this.jenis = const Value.absent(),
  })  : nama = Value(nama),
        jumlah = Value(jumlah),
        satuan = Value(satuan);
  static Insertable<KartuStokData> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<String>? gambarPath,
    Expression<int>? jumlah,
    Expression<String>? satuan,
    Expression<int>? status,
    Expression<int>? jenis,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (gambarPath != null) 'gambar_path': gambarPath,
      if (jumlah != null) 'jumlah': jumlah,
      if (satuan != null) 'satuan': satuan,
      if (status != null) 'status': status,
      if (jenis != null) 'jenis': jenis,
    });
  }

  KartuStokCompanion copyWith(
      {Value<int>? id,
      Value<String>? nama,
      Value<String?>? gambarPath,
      Value<int>? jumlah,
      Value<String>? satuan,
      Value<StockStatus>? status,
      Value<JenisBahan>? jenis}) {
    return KartuStokCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      gambarPath: gambarPath ?? this.gambarPath,
      jumlah: jumlah ?? this.jumlah,
      satuan: satuan ?? this.satuan,
      status: status ?? this.status,
      jenis: jenis ?? this.jenis,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (gambarPath.present) {
      map['gambar_path'] = Variable<String>(gambarPath.value);
    }
    if (jumlah.present) {
      map['jumlah'] = Variable<int>(jumlah.value);
    }
    if (satuan.present) {
      map['satuan'] = Variable<String>(satuan.value);
    }
    if (status.present) {
      map['status'] =
          Variable<int>($KartuStokTable.$converterstatus.toSql(status.value));
    }
    if (jenis.present) {
      map['jenis'] =
          Variable<int>($KartuStokTable.$converterjenis.toSql(jenis.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KartuStokCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('gambarPath: $gambarPath, ')
          ..write('jumlah: $jumlah, ')
          ..write('satuan: $satuan, ')
          ..write('status: $status, ')
          ..write('jenis: $jenis')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProduksiTable produksi = $ProduksiTable(this);
  late final $ItemProduksiTable itemProduksi = $ItemProduksiTable(this);
  late final $KartuStokTable kartuStok = $KartuStokTable(this);
  late final ProduksiDao produksiDao = ProduksiDao(this as AppDatabase);
  late final ItemProduksiDao itemProduksiDao =
      ItemProduksiDao(this as AppDatabase);
  late final KartuStokDao kartuStokDao = KartuStokDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [produksi, itemProduksi, kartuStok];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('produksi',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('item_produksi', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$ProduksiTableCreateCompanionBuilder = ProduksiCompanion Function({
  Value<int> id,
  Value<String?> kodeProduksi,
  required String tujuanPengiriman,
  required DateTime tanggalPengiriman,
  Value<ProduksiStatus> status,
});
typedef $$ProduksiTableUpdateCompanionBuilder = ProduksiCompanion Function({
  Value<int> id,
  Value<String?> kodeProduksi,
  Value<String> tujuanPengiriman,
  Value<DateTime> tanggalPengiriman,
  Value<ProduksiStatus> status,
});

final class $$ProduksiTableReferences
    extends BaseReferences<_$AppDatabase, $ProduksiTable, ProduksiData> {
  $$ProduksiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemProduksiTable, List<ItemProduksiData>>
      _itemProduksiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.itemProduksi,
          aliasName:
              $_aliasNameGenerator(db.produksi.id, db.itemProduksi.produksiId));

  $$ItemProduksiTableProcessedTableManager get itemProduksiRefs {
    final manager = $$ItemProduksiTableTableManager($_db, $_db.itemProduksi)
        .filter((f) => f.produksiId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_itemProduksiRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ProduksiTableFilterComposer
    extends Composer<_$AppDatabase, $ProduksiTable> {
  $$ProduksiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kodeProduksi => $composableBuilder(
      column: $table.kodeProduksi, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tujuanPengiriman => $composableBuilder(
      column: $table.tujuanPengiriman,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get tanggalPengiriman => $composableBuilder(
      column: $table.tanggalPengiriman,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ProduksiStatus, ProduksiStatus, int>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  Expression<bool> itemProduksiRefs(
      Expression<bool> Function($$ItemProduksiTableFilterComposer f) f) {
    final $$ItemProduksiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemProduksi,
        getReferencedColumn: (t) => t.produksiId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemProduksiTableFilterComposer(
              $db: $db,
              $table: $db.itemProduksi,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProduksiTableOrderingComposer
    extends Composer<_$AppDatabase, $ProduksiTable> {
  $$ProduksiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kodeProduksi => $composableBuilder(
      column: $table.kodeProduksi,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tujuanPengiriman => $composableBuilder(
      column: $table.tujuanPengiriman,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get tanggalPengiriman => $composableBuilder(
      column: $table.tanggalPengiriman,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$ProduksiTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProduksiTable> {
  $$ProduksiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kodeProduksi => $composableBuilder(
      column: $table.kodeProduksi, builder: (column) => column);

  GeneratedColumn<String> get tujuanPengiriman => $composableBuilder(
      column: $table.tujuanPengiriman, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggalPengiriman => $composableBuilder(
      column: $table.tanggalPengiriman, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProduksiStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> itemProduksiRefs<T extends Object>(
      Expression<T> Function($$ItemProduksiTableAnnotationComposer a) f) {
    final $$ItemProduksiTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.itemProduksi,
        getReferencedColumn: (t) => t.produksiId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ItemProduksiTableAnnotationComposer(
              $db: $db,
              $table: $db.itemProduksi,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ProduksiTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProduksiTable,
    ProduksiData,
    $$ProduksiTableFilterComposer,
    $$ProduksiTableOrderingComposer,
    $$ProduksiTableAnnotationComposer,
    $$ProduksiTableCreateCompanionBuilder,
    $$ProduksiTableUpdateCompanionBuilder,
    (ProduksiData, $$ProduksiTableReferences),
    ProduksiData,
    PrefetchHooks Function({bool itemProduksiRefs})> {
  $$ProduksiTableTableManager(_$AppDatabase db, $ProduksiTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProduksiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProduksiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProduksiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> kodeProduksi = const Value.absent(),
            Value<String> tujuanPengiriman = const Value.absent(),
            Value<DateTime> tanggalPengiriman = const Value.absent(),
            Value<ProduksiStatus> status = const Value.absent(),
          }) =>
              ProduksiCompanion(
            id: id,
            kodeProduksi: kodeProduksi,
            tujuanPengiriman: tujuanPengiriman,
            tanggalPengiriman: tanggalPengiriman,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> kodeProduksi = const Value.absent(),
            required String tujuanPengiriman,
            required DateTime tanggalPengiriman,
            Value<ProduksiStatus> status = const Value.absent(),
          }) =>
              ProduksiCompanion.insert(
            id: id,
            kodeProduksi: kodeProduksi,
            tujuanPengiriman: tujuanPengiriman,
            tanggalPengiriman: tanggalPengiriman,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ProduksiTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({itemProduksiRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (itemProduksiRefs) db.itemProduksi],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemProduksiRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$ProduksiTableReferences
                            ._itemProduksiRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ProduksiTableReferences(db, table, p0)
                                .itemProduksiRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.produksiId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ProduksiTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProduksiTable,
    ProduksiData,
    $$ProduksiTableFilterComposer,
    $$ProduksiTableOrderingComposer,
    $$ProduksiTableAnnotationComposer,
    $$ProduksiTableCreateCompanionBuilder,
    $$ProduksiTableUpdateCompanionBuilder,
    (ProduksiData, $$ProduksiTableReferences),
    ProduksiData,
    PrefetchHooks Function({bool itemProduksiRefs})>;
typedef $$ItemProduksiTableCreateCompanionBuilder = ItemProduksiCompanion
    Function({
  Value<int> id,
  required String namaProduk,
  required String ukuran,
  required int jumlah,
  Value<String?> deskripsi,
  required DateTime tanggalProduksi,
  required int produksiId,
});
typedef $$ItemProduksiTableUpdateCompanionBuilder = ItemProduksiCompanion
    Function({
  Value<int> id,
  Value<String> namaProduk,
  Value<String> ukuran,
  Value<int> jumlah,
  Value<String?> deskripsi,
  Value<DateTime> tanggalProduksi,
  Value<int> produksiId,
});

final class $$ItemProduksiTableReferences extends BaseReferences<_$AppDatabase,
    $ItemProduksiTable, ItemProduksiData> {
  $$ItemProduksiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProduksiTable _produksiIdTable(_$AppDatabase db) =>
      db.produksi.createAlias(
          $_aliasNameGenerator(db.itemProduksi.produksiId, db.produksi.id));

  $$ProduksiTableProcessedTableManager? get produksiId {
    if ($_item.produksiId == null) return null;
    final manager = $$ProduksiTableTableManager($_db, $_db.produksi)
        .filter((f) => f.id($_item.produksiId!));
    final item = $_typedResult.readTableOrNull(_produksiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ItemProduksiTableFilterComposer
    extends Composer<_$AppDatabase, $ItemProduksiTable> {
  $$ItemProduksiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get namaProduk => $composableBuilder(
      column: $table.namaProduk, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get ukuran => $composableBuilder(
      column: $table.ukuran, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get jumlah => $composableBuilder(
      column: $table.jumlah, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deskripsi => $composableBuilder(
      column: $table.deskripsi, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get tanggalProduksi => $composableBuilder(
      column: $table.tanggalProduksi,
      builder: (column) => ColumnFilters(column));

  $$ProduksiTableFilterComposer get produksiId {
    final $$ProduksiTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produksiId,
        referencedTable: $db.produksi,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProduksiTableFilterComposer(
              $db: $db,
              $table: $db.produksi,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemProduksiTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemProduksiTable> {
  $$ItemProduksiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get namaProduk => $composableBuilder(
      column: $table.namaProduk, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get ukuran => $composableBuilder(
      column: $table.ukuran, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jumlah => $composableBuilder(
      column: $table.jumlah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deskripsi => $composableBuilder(
      column: $table.deskripsi, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get tanggalProduksi => $composableBuilder(
      column: $table.tanggalProduksi,
      builder: (column) => ColumnOrderings(column));

  $$ProduksiTableOrderingComposer get produksiId {
    final $$ProduksiTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produksiId,
        referencedTable: $db.produksi,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProduksiTableOrderingComposer(
              $db: $db,
              $table: $db.produksi,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemProduksiTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemProduksiTable> {
  $$ItemProduksiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaProduk => $composableBuilder(
      column: $table.namaProduk, builder: (column) => column);

  GeneratedColumn<String> get ukuran =>
      $composableBuilder(column: $table.ukuran, builder: (column) => column);

  GeneratedColumn<int> get jumlah =>
      $composableBuilder(column: $table.jumlah, builder: (column) => column);

  GeneratedColumn<String> get deskripsi =>
      $composableBuilder(column: $table.deskripsi, builder: (column) => column);

  GeneratedColumn<DateTime> get tanggalProduksi => $composableBuilder(
      column: $table.tanggalProduksi, builder: (column) => column);

  $$ProduksiTableAnnotationComposer get produksiId {
    final $$ProduksiTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.produksiId,
        referencedTable: $db.produksi,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ProduksiTableAnnotationComposer(
              $db: $db,
              $table: $db.produksi,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ItemProduksiTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ItemProduksiTable,
    ItemProduksiData,
    $$ItemProduksiTableFilterComposer,
    $$ItemProduksiTableOrderingComposer,
    $$ItemProduksiTableAnnotationComposer,
    $$ItemProduksiTableCreateCompanionBuilder,
    $$ItemProduksiTableUpdateCompanionBuilder,
    (ItemProduksiData, $$ItemProduksiTableReferences),
    ItemProduksiData,
    PrefetchHooks Function({bool produksiId})> {
  $$ItemProduksiTableTableManager(_$AppDatabase db, $ItemProduksiTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemProduksiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemProduksiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemProduksiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> namaProduk = const Value.absent(),
            Value<String> ukuran = const Value.absent(),
            Value<int> jumlah = const Value.absent(),
            Value<String?> deskripsi = const Value.absent(),
            Value<DateTime> tanggalProduksi = const Value.absent(),
            Value<int> produksiId = const Value.absent(),
          }) =>
              ItemProduksiCompanion(
            id: id,
            namaProduk: namaProduk,
            ukuran: ukuran,
            jumlah: jumlah,
            deskripsi: deskripsi,
            tanggalProduksi: tanggalProduksi,
            produksiId: produksiId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String namaProduk,
            required String ukuran,
            required int jumlah,
            Value<String?> deskripsi = const Value.absent(),
            required DateTime tanggalProduksi,
            required int produksiId,
          }) =>
              ItemProduksiCompanion.insert(
            id: id,
            namaProduk: namaProduk,
            ukuran: ukuran,
            jumlah: jumlah,
            deskripsi: deskripsi,
            tanggalProduksi: tanggalProduksi,
            produksiId: produksiId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ItemProduksiTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({produksiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (produksiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.produksiId,
                    referencedTable:
                        $$ItemProduksiTableReferences._produksiIdTable(db),
                    referencedColumn:
                        $$ItemProduksiTableReferences._produksiIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ItemProduksiTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ItemProduksiTable,
    ItemProduksiData,
    $$ItemProduksiTableFilterComposer,
    $$ItemProduksiTableOrderingComposer,
    $$ItemProduksiTableAnnotationComposer,
    $$ItemProduksiTableCreateCompanionBuilder,
    $$ItemProduksiTableUpdateCompanionBuilder,
    (ItemProduksiData, $$ItemProduksiTableReferences),
    ItemProduksiData,
    PrefetchHooks Function({bool produksiId})>;
typedef $$KartuStokTableCreateCompanionBuilder = KartuStokCompanion Function({
  Value<int> id,
  required String nama,
  Value<String?> gambarPath,
  required int jumlah,
  required String satuan,
  Value<StockStatus> status,
  Value<JenisBahan> jenis,
});
typedef $$KartuStokTableUpdateCompanionBuilder = KartuStokCompanion Function({
  Value<int> id,
  Value<String> nama,
  Value<String?> gambarPath,
  Value<int> jumlah,
  Value<String> satuan,
  Value<StockStatus> status,
  Value<JenisBahan> jenis,
});

class $$KartuStokTableFilterComposer
    extends Composer<_$AppDatabase, $KartuStokTable> {
  $$KartuStokTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nama => $composableBuilder(
      column: $table.nama, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gambarPath => $composableBuilder(
      column: $table.gambarPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get jumlah => $composableBuilder(
      column: $table.jumlah, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get satuan => $composableBuilder(
      column: $table.satuan, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<StockStatus, StockStatus, int> get status =>
      $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<JenisBahan, JenisBahan, int> get jenis =>
      $composableBuilder(
          column: $table.jenis,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$KartuStokTableOrderingComposer
    extends Composer<_$AppDatabase, $KartuStokTable> {
  $$KartuStokTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nama => $composableBuilder(
      column: $table.nama, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gambarPath => $composableBuilder(
      column: $table.gambarPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jumlah => $composableBuilder(
      column: $table.jumlah, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get satuan => $composableBuilder(
      column: $table.satuan, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jenis => $composableBuilder(
      column: $table.jenis, builder: (column) => ColumnOrderings(column));
}

class $$KartuStokTableAnnotationComposer
    extends Composer<_$AppDatabase, $KartuStokTable> {
  $$KartuStokTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get gambarPath => $composableBuilder(
      column: $table.gambarPath, builder: (column) => column);

  GeneratedColumn<int> get jumlah =>
      $composableBuilder(column: $table.jumlah, builder: (column) => column);

  GeneratedColumn<String> get satuan =>
      $composableBuilder(column: $table.satuan, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StockStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<JenisBahan, int> get jenis =>
      $composableBuilder(column: $table.jenis, builder: (column) => column);
}

class $$KartuStokTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KartuStokTable,
    KartuStokData,
    $$KartuStokTableFilterComposer,
    $$KartuStokTableOrderingComposer,
    $$KartuStokTableAnnotationComposer,
    $$KartuStokTableCreateCompanionBuilder,
    $$KartuStokTableUpdateCompanionBuilder,
    (
      KartuStokData,
      BaseReferences<_$AppDatabase, $KartuStokTable, KartuStokData>
    ),
    KartuStokData,
    PrefetchHooks Function()> {
  $$KartuStokTableTableManager(_$AppDatabase db, $KartuStokTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KartuStokTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KartuStokTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KartuStokTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nama = const Value.absent(),
            Value<String?> gambarPath = const Value.absent(),
            Value<int> jumlah = const Value.absent(),
            Value<String> satuan = const Value.absent(),
            Value<StockStatus> status = const Value.absent(),
            Value<JenisBahan> jenis = const Value.absent(),
          }) =>
              KartuStokCompanion(
            id: id,
            nama: nama,
            gambarPath: gambarPath,
            jumlah: jumlah,
            satuan: satuan,
            status: status,
            jenis: jenis,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nama,
            Value<String?> gambarPath = const Value.absent(),
            required int jumlah,
            required String satuan,
            Value<StockStatus> status = const Value.absent(),
            Value<JenisBahan> jenis = const Value.absent(),
          }) =>
              KartuStokCompanion.insert(
            id: id,
            nama: nama,
            gambarPath: gambarPath,
            jumlah: jumlah,
            satuan: satuan,
            status: status,
            jenis: jenis,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KartuStokTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KartuStokTable,
    KartuStokData,
    $$KartuStokTableFilterComposer,
    $$KartuStokTableOrderingComposer,
    $$KartuStokTableAnnotationComposer,
    $$KartuStokTableCreateCompanionBuilder,
    $$KartuStokTableUpdateCompanionBuilder,
    (
      KartuStokData,
      BaseReferences<_$AppDatabase, $KartuStokTable, KartuStokData>
    ),
    KartuStokData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProduksiTableTableManager get produksi =>
      $$ProduksiTableTableManager(_db, _db.produksi);
  $$ItemProduksiTableTableManager get itemProduksi =>
      $$ItemProduksiTableTableManager(_db, _db.itemProduksi);
  $$KartuStokTableTableManager get kartuStok =>
      $$KartuStokTableTableManager(_db, _db.kartuStok);
}
