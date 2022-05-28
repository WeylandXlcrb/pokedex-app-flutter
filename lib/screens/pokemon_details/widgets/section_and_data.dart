import 'package:flutter/material.dart';

import 'package:pokedex_app/constants.dart';

class DataSection extends StatelessWidget {
  /// Heading text
  final String title;

  /// Section's heading color
  final Color color;

  /// List of widgets inside of a section
  final List<Widget> children;

  /// Optional subtitle for section
  final String? subtitle;

  const DataSection({
    Key? key,
    required this.title,
    required this.color,
    required this.children,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingDefault * 2),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _DataHeading(
              text: title,
              color: color,
            ),
            if (subtitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: DataTextValue(text: subtitle!),
              ),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _DataHeading extends StatelessWidget {
  final String text;
  final Color color;

  const _DataHeading({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
    );
  }
}

class PokeDataRow extends StatelessWidget {
  final String labelText;
  final Widget child;

  const PokeDataRow({
    Key? key,
    required this.labelText,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              labelText,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          const SizedBox(width: 4.0),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class DataTextValue extends StatelessWidget {
  final String text;

  const DataTextValue({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: Color(0xFF666666)),
    );
  }
}
