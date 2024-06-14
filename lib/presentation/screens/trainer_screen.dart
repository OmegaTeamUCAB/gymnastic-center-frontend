import 'package:flutter/material.dart';
import 'package:gymnastic_center/presentation/widgets/common/brand_back_button.dart';
import 'package:gymnastic_center/presentation/widgets/trainer/trainer_info.dart';

class TrainerScreen extends StatefulWidget {
  final Map trainer;
  const TrainerScreen({super.key, required this.trainer});

  @override
  State<TrainerScreen> createState() => _TrainerScreenState();
}

class _TrainerScreenState extends State<TrainerScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 500) {
      setState(() {
        _showFab = true;
      });
    } else {
      setState(() {
        _showFab = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1623200216581-969d9479cf7d?q=80&w=2340&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            height: 400,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return child;
              }
            },
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          TrainerInfo(
            scrollController: _scrollController,
            trainer: widget.trainer,
          ),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              left: 0,
              right: 0,
              top: _showFab ? 0 : -140,
              child: Container(
                height: 110,
                width: double.infinity,
                color: const Color(0xFF4F14A0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      widget.trainer['name'],
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 60,
              left: 10,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF4F14A0),
                  shape: BoxShape.circle,
                ),
                child: const BrandBackButton(
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
