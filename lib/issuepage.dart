import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:convert';

class ReportIssuePage extends StatefulWidget {
  const ReportIssuePage({Key? key}) : super(key: key);

  @override
  _ReportIssuePageState createState() => _ReportIssuePageState();
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  String? _selectedIssue;
  String? _selectedPriority;
  File? _imageFile;
  bool _isProcessingImage = false;

  bool _isLoadingLocation = false;
  String _locationMessage = 'Tap "Update" to get location';
  Position? _currentPosition;

  final _supabase = Supabase.instance.client;
  final _descriptionController = TextEditingController();

  final Map<String, Map<String, dynamic>> _puneAreas = {
    'karve_nagar': {
      'name': 'Karve Nagar',
      'keywords': ['karve', 'kothrud', 'warje'],
      'bounds': {'lat': 18.5074, 'lng': 73.8077, 'radius': 2.0}
    },
    'marathwada_mitramandal': {
      'name': 'near Marathwada Mitramandal College',
      'keywords': ['pune university', 'university road', 'ganeshkhind', 'pune univ'],
      'bounds': {'lat': 18.5421, 'lng': 73.8267, 'radius': 1.5}
    },
    'camp': {
      'name': 'Camp Area',
      'keywords': ['camp', 'mg road', 'main guard'],
      'bounds': {'lat': 18.5158, 'lng': 73.8567, 'radius': 1.0}
    },
    'shivajinagar': {
      'name': 'Shivajinagar',
      'keywords': ['shivajinagar', 'jm road', 'deccan'],
      'bounds': {'lat': 18.5304, 'lng': 73.8431, 'radius': 1.5}
    },
    'koregaon_park': {
      'name': 'Koregaon Park',
      'keywords': ['koregaon', 'north main road', 'kalyani nagar'],
      'bounds': {'lat': 18.5362, 'lng': 73.8840, 'radius': 2.0}
    },
    'pimpri': {
      'name': 'Pimpri-Chinchwad',
      'keywords': ['pimpri', 'chinchwad', 'pcmc'],
      'bounds': {'lat': 18.6298, 'lng': 73.7997, 'radius': 3.0}
    }
  };

  double _calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    return Geolocator.distanceBetween(lat1, lng1, lat2, lng2) / 1000;
  }

  String _identifyLandmarkArea(Position position, List<Placemark> placemarks) {
    double lat = position.latitude;
    double lng = position.longitude;

    for (var area in _puneAreas.entries) {
      double distance = _calculateDistance(
          lat, lng,
          area.value['bounds']['lat'],
          area.value['bounds']['lng']
      );
      if (distance <= area.value['bounds']['radius']) {
        return area.value['name'];
      }
    }

    if (placemarks.isNotEmpty) {
      String fullAddress = placemarks.map((p) =>
      '${p.street ?? ''} ${p.locality ?? ''} ${p.subLocality ?? ''} ${p.administrativeArea ?? ''}'
      ).join(' ').toLowerCase();

      for (var area in _puneAreas.entries) {
        for (String keyword in area.value['keywords']) {
          if (fullAddress.contains(keyword.toLowerCase())) {
            return area.value['name'];
          }
        }
      }
    }
    return '';
  }

  Future<void> _getCurrentLocationGPS() async {
    setState(() {
      _isLoadingLocation = true;
      _locationMessage = 'Getting precise location...';
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationMessage = 'Location services disabled. Please enable GPS.';
          _isLoadingLocation = false;
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationMessage = 'Location permission denied.';
            _isLoadingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationMessage = 'Location permission permanently denied. Please enable in settings.';
          _isLoadingLocation = false;
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        timeLimit: const Duration(seconds: 15),
      );

      _currentPosition = position;
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      String landmark = _identifyLandmarkArea(position, placemarks);

      String locationText = '';
      if (landmark.isNotEmpty) {
        locationText = landmark;
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks[0];
          String street = place.street ?? '';
          if (street.isNotEmpty && !landmark.toLowerCase().contains(street.toLowerCase())) {
            locationText = '$street, $landmark';
          }
        }
      } else if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        List<String> addressParts = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea
        ].where((part) => part != null && part.isNotEmpty).cast<String>().toList();

        locationText = addressParts.take(3).join(', ');
      } else {
        locationText = 'Lat: ${position.latitude.toStringAsFixed(4)}, Lng: ${position.longitude.toStringAsFixed(4)}';
      }

      setState(() {
        _locationMessage = locationText;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Location detected with ${position.accuracy.round()}m accuracy'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      setState(() {
        _locationMessage = 'Error getting location: ${e.toString()}';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to get location. Try IP-based location instead.'),
          backgroundColor: Colors.orange,
          action: SnackBarAction(
            label: 'Try Again',
            onPressed: _getCurrentLocationIP,
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  Future<void> _getCurrentLocationIP() async {
    setState(() {
      _isLoadingLocation = true;
      _locationMessage = 'Getting approximate location...';
    });
    try {
      final response = await http.get(
        Uri.parse('http://ip-api.com/json?fields=status,city,regionName,country,lat,lon'),
        headers: {'Accept': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          String city = data['city'] ?? '';
          String region = data['regionName'] ?? '';
          String country = data['country'] ?? '';
          double lat = data['lat']?.toDouble() ?? 0.0;
          double lng = data['lon']?.toDouble() ?? 0.0;
          Position dummyPosition = Position(
            latitude: lat,
            longitude: lng,
            timestamp: DateTime.now(),
            accuracy: 1000.0,
            altitude: 0.0,
            altitudeAccuracy: 0.0,
            heading: 0.0,
            headingAccuracy: 0.0,
            speed: 0.0,
            speedAccuracy: 0.0,
          );
          String landmark = '';
          if (city.toLowerCase().contains('pune') || region.toLowerCase().contains('maharashtra')) {
            landmark = _identifyLandmarkArea(dummyPosition, []);
          }
          String locationText = landmark.isNotEmpty
              ? '$landmark, $city (Approximate)'
              : '$city, $region, $country (Approximate)';
          setState(() {
            _locationMessage = locationText;
          });
        } else {
          setState(() {
            _locationMessage = 'Could not determine location from IP.';
          });
        }
      } else {
        setState(() {
          _locationMessage = 'Network error. Check internet connection.';
        });
      }
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _showLocationOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Location Method', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'We can detect landmarks like "near Marathwada Mitramandal College" or "Karve Nagar" for better location accuracy.',
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.blue.shade800),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.gps_fixed, color: Colors.green),
                title: Text('Precise GPS Location', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                subtitle: const Text('Best accuracy, detects nearby landmarks'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getCurrentLocationGPS();
                },
              ),
              ListTile(
                leading: const Icon(Icons.wifi, color: Colors.orange),
                title: Text('Approximate Location', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                subtitle: const Text('Based on internet connection'),
                onTap: () {
                  Navigator.of(context).pop();
                  _getCurrentLocationIP();
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_location, color: Colors.blue),
                title: Text('Enter Manually', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                subtitle: const Text('Type your location or landmark'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showManualLocationDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showManualLocationDialog() {
    TextEditingController locationController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Location', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: locationController,
                decoration: InputDecoration(
                  hintText: 'e.g., near Marathwada Mitramandal College, Karve Nagar, FC Road',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  prefixIcon: const Icon(Icons.location_on),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              Text('Popular areas:', style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 12)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _puneAreas.values.map((area) {
                  return GestureDetector(
                    onTap: () {
                      locationController.text = area['name'];
                    },
                    child: Chip(
                      label: Text(area['name'], style: GoogleFonts.poppins(fontSize: 10)),
                      backgroundColor: Colors.blue.shade100,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (locationController.text.isNotEmpty) {
                  setState(() {
                    _locationMessage = locationController.text.trim();
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    try {
      setState(() {
        _isProcessingImage = true;
      });
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
        maxWidth: 1200,
        maxHeight: 1200,
        preferredCameraDevice: CameraDevice.rear,
      );
      if (pickedFile == null) {
        setState(() {
          _isProcessingImage = false;
        });
        return;
      }
      final imageFile = File(pickedFile.path);
      setState(() {
        _imageFile = imageFile;
        _isProcessingImage = false;
      });
      final fileSize = await imageFile.length();
      final fileSizeKB = (fileSize / 1024).round();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image captured and optimized! Size: ${fileSizeKB}KB'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      setState(() {
        _isProcessingImage = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error capturing image: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _submitReport() async {
    // Validate form fields first
    if (_selectedIssue == null || _selectedPriority == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an issue, priority, and provide a description.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    String? imageUrl;
    try {
      if (_imageFile != null) {
        final imageExtension = _imageFile!.path.split('.').last;
        // Generate a unique path without a user ID
        final imagePath = 'anonymous/${DateTime.now().toIso8601String()}.$imageExtension';

        await _supabase.storage
            .from('issue-images')
            .upload(imagePath, _imageFile!, fileOptions: const FileOptions(cacheControl: '3600', upsert: false));

        imageUrl = _supabase.storage.from('issue-images').getPublicUrl(imagePath);
      }

      final data = {
        'issue_type': _selectedIssue,
        'description': _descriptionController.text,
        'priority': _selectedPriority,
        'location_text': _locationMessage,
        'latitude': _currentPosition?.latitude,
        'longitude': _currentPosition?.longitude,
        'image_url': imageUrl,
      };

      await _supabase.from('issues').insert(data);

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Issue reported successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }

    } on PostgrestException catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting report: ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Report Issue', style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('What type of issue?'),
            _buildIssueTypeSelector(),
            const SizedBox(height: 24),
            _buildSectionTitle('Add Photos'),
            _buildAddPhotos(),
            const SizedBox(height: 24),
            _buildSectionTitle('Location'),
            _buildLocationCard(),
            const SizedBox(height: 24),
            _buildSectionTitle('Description'),
            _buildDescriptionField(),
            const SizedBox(height: 24),
            _buildSectionTitle('Priority Level'),
            _buildPrioritySelector(),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReport,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Submit Report',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _currentPosition != null ? Colors.green : Colors.green.shade200,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _currentPosition != null ? Colors.green : Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _currentPosition != null ? Icons.location_on : Icons.location_off,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentPosition != null ? 'GPS Location Detected' : 'Location',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: _currentPosition != null ? Colors.green.shade800 : Colors.orange.shade800,
                        fontSize: 16,
                      ),
                    ),
                    if (_isLoadingLocation)
                      Row(
                        children: [
                          const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: 8),
                          Text('Loading...', style: GoogleFonts.poppins(fontSize: 12)),
                        ],
                      )
                    else
                      Text(
                        _locationMessage,
                        style: GoogleFonts.poppins(fontSize: 14),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _isLoadingLocation ? null : _showLocationOptions,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text('Update', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
          if (_currentPosition != null)
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, size: 16, color: Colors.green.shade700),
                  const SizedBox(width: 4),
                  Text(
                    'Accuracy: ±${_currentPosition!.accuracy.round()}m',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddPhotos() {
    return GestureDetector(
      onTap: _isProcessingImage ? null : _pickImageFromCamera,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [6, 6],
        color: _imageFile != null ? Colors.green : Colors.grey,
        strokeWidth: 2,
        child: Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _imageFile != null ? Colors.green.shade50 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: _isProcessingImage
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: Colors.blue),
              const SizedBox(height: 12),
              Text(
                'Processing image...',
                style: GoogleFonts.poppins(color: Colors.blue, fontWeight: FontWeight.w500),
              ),
            ],
          )
              : _imageFile == null
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.camera_alt_outlined, color: Colors.grey, size: 48),
              const SizedBox(height: 12),
              Text(
                'Tap to add photos',
                style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Images will be automatically optimized',
                style: GoogleFonts.poppins(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          )
              : Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _imageFile = null;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Retake',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Help Improve Your City', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('Report issues and make your community better for everyone', style: GoogleFonts.poppins()),
              ],
            ),
          ),
          const Icon(Icons.lightbulb_circle, color: Colors.blue, size: 36),
        ],
      ),
    );
  }

  Widget _buildIssueTypeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildSelectableCard('Garbage Issue', Icons.delete_outline, 'Garbage Issue'),
        _buildSelectableCard('Pothole', Icons.construction, 'Pothole'),
        _buildSelectableCard('Streetlight', Icons.lightbulb_outline, 'Streetlight'),
      ],
    );
  }

  Widget _buildSelectableCard(String title, IconData icon, String value) {
    final bool isSelected = _selectedIssue == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedIssue = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade200),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? Colors.blue.shade800 : Colors.grey.shade700),
              const SizedBox(height: 8),
              Text(title, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: _descriptionController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Describe the issue in detail. What exactly is the problem? When did you notice it?',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildPrioritySelector() {
    return Row(
      children: [
        _buildPriorityChip('Low', 'Low', Colors.green),
        _buildPriorityChip('Medium', 'Medium', Colors.orange),
        _buildPriorityChip('High', 'High', Colors.red),
      ],
    );
  }

  Widget _buildPriorityChip(String label, String value, Color color) {
    final bool isSelected = _selectedPriority == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedPriority = value),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? color : Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
              const SizedBox(width: 8),
              Text(label, style: GoogleFonts.poppins(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            ],
          ),
        ),
      ),
    );
  }
}