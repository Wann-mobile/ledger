class AppConstants {
  static const String appName = 'Expense Tracker';
  static const String baseUrl =
      'http://localhost:5000/api/v1'; // Change for production

  // Supported mobile money providers
  static const List<String> supportedProviders = [
    'mtn',
    'telecel',
    'airteltigo',
  ];

  // Transaction categories
  static const List<String> transactionCategories = [
    'utilities',
    'groceries',
    'transportation',
    'entertainment',
    'healthcare',
    'other',
  ];

  // Budget timeframes
  static const List<String> budgetTimeframes = ['weekly', 'monthly', 'yearly'];

  // SMS parsing keywords for each provider
  static const Map<String, List<String>> providerKeywords = {
    'mtn': ['MTN', 'MoMo', 'Mobile Money'],
    'telecel': ['Vodafone', 'Cash'],
    'airteltigo': ['AirtelTigo', 'Money'],
  };

  // Colors
  static const Map<String, int> providerColors = {
    'mtn': 0xFFFFD700, // Gold
    'telecel': 0xFFE60000, // Red
    'airteltigo': 0xFF0066CC, // Blue
  };
}
