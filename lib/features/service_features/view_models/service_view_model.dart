import 'package:fluent_ui/fluent_ui.dart';

import '../models/service_model.dart';

class ServiceViewModel extends ChangeNotifier {

  // List of services
  List<ServiceModel> _services =  [
    ServiceModel(
      id: 1,
      title: 'Service 1',
      description: 'Description for Service 1',
      count: 10,
    ),
    ServiceModel(
      id: 2,
      title: 'Service 2',
      description: 'Description for Service 2',
      count: 5,
    ),
    ServiceModel(
      id: 3,
      title: 'Service 3',
      description: 'Description for Service 3',
      count: 20,
    ),
  ];
  bool _isLoading = false;

  // Getter for services
  List<ServiceModel> get services => _services;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Method to fetch services (mock implementation)
  Future<void> fetchServices() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    // Mock data

    _isLoading = false;
    notifyListeners();
  }

  // Method to add a service (mock implementation)
  void addService(ServiceModel service) {
    _services.add(service);
    notifyListeners();
  }

  // Method to delete a service (mock implementation)
  void deleteService(ServiceModel service) {
    _services.remove(service);
    notifyListeners();
  }
}