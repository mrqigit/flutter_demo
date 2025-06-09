import 'package:flutter/material.dart';

import '../view_model/cut_view_model.dart';
import 'cut_item_view.dart';

class CutScreen extends StatelessWidget {
  CutScreen({super.key});

  final CutViewModel viewModel = CutViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 25,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: viewModel.splitImages.length,
                  itemBuilder: (context, index) {
                    if (index > viewModel.splitImages.length - 1) {
                      return AspectRatio(
                        aspectRatio: 1,
                        child: ColoredBox(color: Colors.red, child: SizedBox()),
                      );
                    }
                    return ImageItem(image: viewModel.splitImages[index]);
                  },
                ),
              ),
              const SizedBox(height: 30),
              LinearProgressIndicator(value: viewModel.progress),
              const SizedBox(height: 30),
              SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: viewModel.getOriginalImage.run,
                      child: const Text("Load"),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.getSplitImage.run,
                      child: const Text("Cut"),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.uploadImage.run,
                      child: const Text("Upload"),
                    ),

                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Delete"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
