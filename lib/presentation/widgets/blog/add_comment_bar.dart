import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_gradient.dart';

class AddCommentBar extends StatelessWidget {
  const AddCommentBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        top: 15.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 15.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Add a comment...',
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 56, // Estos valores son los tamaños predeterminados de un FloatingActionButton
            height: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: brandGradient,
            ),
            child: FloatingActionButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              shape: const CircleBorder(),
              backgroundColor: Colors.transparent, // Hacer el color de fondo transparente
              elevation: 0,
              child: const Icon(Icons.send, color: Colors.white), 
            ),
          ),
        ],
      ),
    );
  }
}