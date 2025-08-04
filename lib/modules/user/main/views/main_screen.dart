import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/main_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    // Load main data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainViewModel>().loadMainData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<MainViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${viewModel.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => viewModel.loadMainData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.mainData.length,
            itemBuilder: (context, index) {
              final item = viewModel.mainData[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  title: Text(item.title ?? 'No Title'),
                  subtitle: Text(item.description ?? 'No Description'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to detail screen or perform action
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
} 