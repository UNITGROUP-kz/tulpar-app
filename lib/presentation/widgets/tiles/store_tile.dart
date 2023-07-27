import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/models/auth/store_model.dart';

class StoreTile extends StatelessWidget {

  final StoreModel store;

  const StoreTile({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          ClipOval(
            child: Container(
              color: Colors.grey.shade300,
              width: 75,
              height: 75,
              child: CachedNetworkImage(
                imageUrl: store.image ?? '',
                placeholder: (context, String val) => CupertinoActivityIndicator(),
                errorWidget: (context, String val, err) => Icon(Icons.person, size: 40, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(store.name ?? 'Неизвестно'),
                Row(
                  children: [
                    Icon(Icons.star_rounded),
                    Text(store.rating.toString() ?? '0.0'),
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

}