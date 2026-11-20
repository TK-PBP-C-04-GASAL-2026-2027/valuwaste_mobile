class MarketItem {
  final String name;
  final String stockInfo;
  final int sellerCount;
  final int pricePerKg;
  final String priceFormatted;
  final String location;

  const MarketItem({
    required this.name,
    required this.stockInfo,
    required this.sellerCount,
    required this.pricePerKg,
    required this.priceFormatted,
    required this.location,
  });
}