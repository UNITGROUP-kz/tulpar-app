import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garage/data/models/auth/store_model.dart';

import '../../widgets/navigation/header.dart';
import '../../widgets/screen_templates/screen_default_template.dart';
import '../../widgets/tiles/data_tile.dart';

@RoutePage()
class StoreScreen extends StatelessWidget {
  final StoreModel store;

  const StoreScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return ScreenDefaultTemplate(
      children: [
        Header(title: 'Магазин'),
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  color: Colors.grey.shade200,
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.width * 0.35,
                  child: CachedNetworkImage(
                    imageUrl: store.image ?? '',
                    placeholder: (context, String val) => CupertinoActivityIndicator(),
                    errorWidget: (context, String val, err) => Icon(Icons.person, size: MediaQuery.of(context).size.width * 0.2, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(height: 20),
              DataTile(title: 'Название магазина', data: store.name),
              DataTile(title: 'Номер телефона', data: store.phone),
              if(store.city != null) ...[
                DataTile(title: 'Город магазина', data: store.city!.name),
              ],
              if(store.address != null) ...[
                DataTile(title: 'Адрес', data: store.address),
              ],
              if(store.description != null) ...[
                Text('Описание', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                Text(store.description!, style: TextStyle(fontSize: 17),),
              ],
            ],
          ),
        )
      ],
    );
  }

}