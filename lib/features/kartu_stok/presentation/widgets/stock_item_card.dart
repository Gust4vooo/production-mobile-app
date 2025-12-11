import 'dart:io';
import 'package:flutter/material.dart';
import 'package:seger/core/database/app.database.dart';
import 'package:seger/features/kartu_stok/domain/kartu_stok_utils.dart';

class StockItemCard extends StatelessWidget {
  final KartuStokData item;
  final VoidCallback? onTap;

  const StockItemCard({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                  ),
                  child: item.gambarPath != null && item.gambarPath!.isNotEmpty
                      ? Image.file(
                          File(item.gambarPath!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image,
                                size: 48, color: Colors.grey);
                          },
                        )
                      : const Icon(Icons.inventory,
                          size: 48, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0), 
                child: Text(
                  item.nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 4.0),
                child: Text(
                  'Jumlah: ${item.jumlah} ${item.satuan}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
                child: Text(
                  'Status: ${KartuStokUtils.getFormattedStatusName(item.status)}',
                  style: TextStyle(
                    color: KartuStokUtils.getStatusColor(item.status),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                height: 16,
                width: double.infinity, 
                color: KartuStokUtils.getStatusColor(item.status),
              ),
            ]),
      ),
    );
  }
}
