import 'package:flutter/material.dart';
import 'package:saltandglitz/core/utils/color_resources.dart';

class PopScreen extends StatelessWidget {
  const PopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Return Policy',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: ColorResources.buttonColor,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introduction
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Text(
                  'At Salt & Glitz, we prioritize customer satisfaction and strive to offer a seamless return process. Our 30-Day Return Policy ensures that you have the flexibility to return eligible products under the following terms and conditions:',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Return Period Section
              _buildSectionHeader('Return Period'),
              _buildSubSection(
                '1. Full Refund:',
                [
                  'Returns initiated within 7 days of delivery are eligible for a full refund to the original payment method.',
                ],
              ),
              _buildSubSection(
                '2. Salt Cash Credit (Wallet Refund):',
                [
                  'Returns initiated after 7 days but within 30 days of delivery will be refunded as Salt Cash, credited to your Salt Wallet.',
                  'Salt Cash Terms:',
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSubListItem(
                        'Must be used within 180 days of issuance.'),
                    _buildSubListItem(
                        'Can be used only for purchases on the Salt & Glitz website or app.'),
                  ],
                ),
              ),

              // Return Eligibility Section
              _buildSectionHeader('Return Eligibility'),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'To be eligible for a return, the following conditions must be met:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              _buildSubSection(
                '1. Product Condition:',
                [
                  'The item must be in its original condition with no alterations or damages.',
                  'Items with broken tags, damaged boxes will not be accepted.',
                ],
              ),
              _buildSubSection(
                '2. Documentation and Packaging:',
                [
                  'The original box, invoice, and certificates of authenticity must be included with the return.',
                  'Missing certificates will result in the return being rejected.',
                ],
              ),
              _buildSubSection(
                '3. Exclusions:',
                [
                  'Customized or personalized items are not eligible for return.',
                  'Products purchased via EMI plans or valued above ₹2,00,000 are not eligible for return.',
                  'Jewelry purchased outside the official Salt & Glitz website or app will not be accepted for returns.',
                ],
              ),
              _buildSubSection(
                '4. Ineligible Items:',
                [
                  'Items containing loose, baguette, or tapered diamonds, Polki, pearls, or colored stones are not eligible for return.',
                ],
              ),

              // Refund Processing Section
              _buildSectionHeader('Refund Processing'),
              _buildNumberedItem(
                '1.',
                'Refunds will be processed within 3 working days excluding bank holiday from the date of return approval.',
              ),
              _buildNumberedItem(
                '2.',
                'For returns within 7 days, the refund will be credited to the original payment method.',
              ),
              _buildNumberedItem(
                '3.',
                'For returns after 7 days, the refund will be credited as Salt Cash.',
              ),

              const SizedBox(height: 24),

              // Footer
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: ColorResources.buttonColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: ColorResources.buttonColor.withOpacity(0.3)),
                ),
                child: Text(
                  'We are committed to maintaining the highest quality standards in all our products. If you have any questions or need further assistance, please contact our support team.',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: ColorResources.buttonColor,
        ),
      ),
    );
  }

  Widget _buildSubSection(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => _buildListItem(item)),
        ],
      ),
    );
  }

  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6.0, right: 8.0),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: ColorResources.buttonColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubListItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6.0, right: 8.0),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberedItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: ColorResources.buttonColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                height: 1.4,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
