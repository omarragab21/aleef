import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/animals_view_model.dart';
import '../models/animal_model.dart';

class AnimalsScreen extends StatefulWidget {
  const AnimalsScreen({super.key});

  @override
  State<AnimalsScreen> createState() => _AnimalsScreenState();
}

class _AnimalsScreenState extends State<AnimalsScreen> {
  @override
  void initState() {
    super.initState();
    // Load animals when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AnimalsViewModel>().loadAnimals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Animals'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to add animal screen
            },
          ),
        ],
      ),
      body: Consumer<AnimalsViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
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
                    onPressed: () => viewModel.loadAnimals(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.animals.isEmpty) {
            return const Center(
              child: Text('No animals found. Add your first pet!'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.animals.length,
            itemBuilder: (context, index) {
              final animal = viewModel.animals[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: animal.imageUrl != null
                        ? NetworkImage(animal.imageUrl!)
                        : null,
                    child: animal.imageUrl == null
                        ? const Icon(Icons.pets)
                        : null,
                  ),
                  title: Text(animal.name ?? 'Unnamed'),
                  subtitle: Text(
                    '${animal.breed ?? 'Unknown breed'} • ${animal.age ?? 'Unknown age'}',
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('Edit')),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        // Navigate to edit animal screen
                      } else if (value == 'delete') {
                        _showDeleteDialog(context, animal);
                      }
                    },
                  ),
                  onTap: () {
                    // Navigate to animal detail screen
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, AnimalModel animal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Animal'),
        content: Text('Are you sure you want to delete ${animal.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AnimalsViewModel>().deleteAnimal(animal.id!);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
