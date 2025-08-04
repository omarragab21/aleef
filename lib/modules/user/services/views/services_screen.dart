import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_models/services_view_model.dart';
import '../models/service_model.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load services when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServicesViewModel>().loadServices();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search services...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (query) {
                if (query.isNotEmpty) {
                  context.read<ServicesViewModel>().searchServices(query);
                } else {
                  context.read<ServicesViewModel>().loadServices();
                }
              },
            ),
          ),
          // Category Filter
          Consumer<ServicesViewModel>(
            builder: (context, viewModel, child) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: viewModel.selectedCategory == null,
                      onSelected: (selected) {
                        if (selected) {
                          viewModel.loadServices();
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Veterinary'),
                      selected: viewModel.selectedCategory == 'veterinary',
                      onSelected: (selected) {
                        if (selected) {
                          viewModel.loadServices(category: 'veterinary');
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Grooming'),
                      selected: viewModel.selectedCategory == 'grooming',
                      onSelected: (selected) {
                        if (selected) {
                          viewModel.loadServices(category: 'grooming');
                        }
                      },
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: const Text('Training'),
                      selected: viewModel.selectedCategory == 'training',
                      onSelected: (selected) {
                        if (selected) {
                          viewModel.loadServices(category: 'training');
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          // Services List
          Expanded(
            child: Consumer<ServicesViewModel>(
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
                          onPressed: () => viewModel.loadServices(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (viewModel.services.isEmpty) {
                  return const Center(
                    child: Text('No services found.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: viewModel.services.length,
                  itemBuilder: (context, index) {
                    final service = viewModel.services[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: service.imageUrl != null 
                              ? NetworkImage(service.imageUrl!)
                              : null,
                          child: service.imageUrl == null 
                              ? const Icon(Icons.pets)
                              : null,
                        ),
                        title: Text(service.name ?? 'Unnamed Service'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(service.description ?? 'No description'),
                            const SizedBox(height: 4),
                            Text(
                              '${service.providerName ?? 'Unknown'} • \$${service.price?.toStringAsFixed(2) ?? '0.00'}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: service.isAvailable == true
                              ? () => _bookService(context, service)
                              : null,
                          child: const Text('Book'),
                        ),
                        onTap: () {
                          // Navigate to service detail screen
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _bookService(BuildContext context, ServiceModel service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Book Service'),
        content: Text('Are you sure you want to book ${service.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<ServicesViewModel>().bookService(service.id!);
            },
            child: const Text('Book'),
          ),
        ],
      ),
    );
  }
} 