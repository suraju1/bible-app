class RankUtils {
  static String getRankAsset(int level) {
    if (level >= 100) return 'assets/images/legend.png';
    if (level >= 80) return 'assets/images/champion.png';
    if (level >= 70) return 'assets/images/elite.png';
    if (level >= 60) return 'assets/images/grand_master.png';
    if (level >= 50) return 'assets/images/master.png';
    if (level >= 40) return 'assets/images/dimond.png';
    if (level >= 30) return 'assets/images/platinum.png';
    if (level >= 20) return 'assets/images/gold.png';
    if (level >= 10) return 'assets/images/silver.png';
    return 'assets/images/bronze.png'; // default fallback for lower levels
  }
}
