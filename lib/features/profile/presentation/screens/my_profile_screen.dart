import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../providers/profile_provider.dart';
import '../widgets/custom_profile_text_field.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyProfileScreen extends ConsumerStatefulWidget {
  const MyProfileScreen({super.key});

  @override
  ConsumerState<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends ConsumerState<MyProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for Personal Details
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _ageController;
  late final TextEditingController _educationalQualificationController;

  // Controllers for Current Address
  late final TextEditingController _cityController;
  late final TextEditingController _pinCodeController;
  late final TextEditingController _addressController;

  // Controllers for Church Details
  late final TextEditingController _churchNameController;
  late final TextEditingController _pastorNameController;
  late final TextEditingController _churchPhoneController;

  // Controllers for Church Address
  late final TextEditingController _churchCityController;
  late final TextEditingController _churchPinCodeController;
  late final TextEditingController _churchAddressController;

  String? _selectedGender;
  String? _selectedOccupation;
  String? _selectedCountry;
  String? _selectedState;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _occupations = ['Business Owner', 'Employee', 'Student', 'Other'];
  final List<String> _countries = ['India', 'USA', 'UK', 'Australia', 'Canada'];
  final List<String> _states = ['Maharashtra', 'Delhi', 'Karnataka', 'Tamil Nadu', 'Gujarat'];

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _ageController = TextEditingController();
    _educationalQualificationController = TextEditingController();

    _cityController = TextEditingController();
    _pinCodeController = TextEditingController();
    _addressController = TextEditingController();

    _churchNameController = TextEditingController();
    _pastorNameController = TextEditingController();
    _churchPhoneController = TextEditingController();

    _churchCityController = TextEditingController();
    _churchPinCodeController = TextEditingController();
    _churchAddressController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _educationalQualificationController.dispose();
    _cityController.dispose();
    _pinCodeController.dispose();
    _addressController.dispose();
    _churchNameController.dispose();
    _pastorNameController.dispose();
    _churchPhoneController.dispose();
    _churchCityController.dispose();
    _churchPinCodeController.dispose();
    _churchAddressController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (_formKey.currentState!.validate()) {
      // Dummy save action
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile details saved successfully!')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Gradient Header matching main Profile Screen
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Gradient.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildAppBar(),
                const SizedBox(height: 10),
                
                profileAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => const Center(child: Text('Error loading profile')),
                  data: (profile) {
                    // Populate initial name if empty
                    if (_fullNameController.text.isEmpty) {
                      _fullNameController.text = profile.name;
                    }
                    return _buildProfileHeader(profile.imageUrl, profile.name);
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Form Container
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionHeader('Personal Details'),
                              CustomProfileTextField(
                                label: 'Full Name',
                                controller: _fullNameController,
                                validator: (val) =>
                                    (val == null || val.trim().isEmpty) ? 'Full name is required' : null,
                              ),
                              CustomProfileTextField(
                                label: 'Email',
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              // Phone with country code prefix
                              CustomProfileTextField(
                                label: 'Phone Number',
                                controller: _phoneController,
                                readOnly: true,
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 12),
                                    const Text(
                                      '91',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ),
                              
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomProfileTextField(
                                      label: 'Age',
                                      controller: _ageController,
                                      keyboardType: TextInputType.number,
                                      // Remove inputFormatters for now or just allow standard numeric
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: CustomProfileDropdownField(
                                      label: 'Gender',
                                      value: _selectedGender,
                                      items: _genders,
                                      onChanged: (val) => setState(() => _selectedGender = val),
                                    ),
                                  ),
                                ],
                              ),
                              
                              CustomProfileDropdownField(
                                label: 'Occupation',
                                value: _selectedOccupation,
                                items: _occupations,
                                onChanged: (val) => setState(() => _selectedOccupation = val),
                              ),
                              
                              CustomProfileTextField(
                                label: 'Educational Qualification',
                                controller: _educationalQualificationController,
                              ),
                              
                              const SizedBox(height: 10),
                              _buildSectionHeader('Current Address'),
                              
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomProfileDropdownField(
                                      label: 'Country',
                                      value: _selectedCountry,
                                      items: _countries,
                                      onChanged: (val) => setState(() => _selectedCountry = val),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: CustomProfileDropdownField(
                                      label: 'State',
                                      value: _selectedState,
                                      items: _states,
                                      onChanged: (val) => setState(() => _selectedState = val),
                                    ),
                                  ),
                                ],
                              ),
                              
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomProfileTextField(
                                      label: 'City',
                                      controller: _cityController,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: CustomProfileTextField(
                                      label: 'PIN Code',
                                      controller: _pinCodeController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              
                              CustomProfileTextField(
                                label: 'Address',
                                controller: _addressController,
                              ),
                              
                              const SizedBox(height: 10),
                              _buildSectionHeader('Church Details'),
                              
                              CustomProfileTextField(
                                label: 'Church Name',
                                controller: _churchNameController,
                              ),
                              
                              CustomProfileTextField(
                                label: 'Father Name / Pastor Name',
                                controller: _pastorNameController,
                              ),
                              
                              CustomProfileTextField(
                                label: 'Phone Number',
                                controller: _churchPhoneController,
                                keyboardType: TextInputType.phone,
                                prefixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(width: 12),
                                    const Text(
                                      '91',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                    ),
                                    const Icon(Icons.keyboard_arrow_down, size: 20, color: Colors.grey),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: CustomProfileTextField(
                                      label: 'City',
                                      controller: _churchCityController,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: CustomProfileTextField(
                                      label: 'PIN Code',
                                      controller: _churchPinCodeController,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              
                              CustomProfileTextField(
                                label: 'Church Address',
                                controller: _churchAddressController,
                              ),
                              
                              const SizedBox(height: 30),
                              
                              // Save Details Button
                              GestureDetector(
                                onTap: _onSave,
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColors.primary,
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Save Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              
                              const SizedBox(height: 40),
                            ].animate(interval: 50.ms).fade(duration: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.05, end: 0.0, curve: Curves.easeOutCubic),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'My Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 32), // Balance for centering
        ],
      ),
    );
  }

  Widget _buildProfileHeader(String imageUrl, String name) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                radius: 40,
                
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // TODO: Pick Image
                },
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: AppColors.primary, size: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
