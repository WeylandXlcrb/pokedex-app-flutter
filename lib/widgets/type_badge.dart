import 'package:flutter/material.dart';

import 'package:pokedex_app/extensions/string.dart';
import 'package:pokedex_app/models/pokemon/type_parser.dart';

class TypeBadge extends StatelessWidget {
  final TypeParser type;

  const TypeBadge({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: type.color,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 1.0,
          ),
        ],
      ),
      child: Text(
        type.name.capitalize(),
        style: const TextStyle(
          fontSize: 12.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
