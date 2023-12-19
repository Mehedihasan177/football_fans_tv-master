// ignore_for_file: file_names

class CheckVpnConnection {
  ///Returns true if device has VPN connection
  static Future<bool> isVpnActive() async {
    return false;
    // bool isVpnActive;
    // List<NetworkInterface> interfaces = await NetworkInterface.list(
    //     includeLoopback: false, type: InternetAddressType.any);
    // interfaces.isNotEmpty
    //     ? isVpnActive = interfaces.any((interface) =>
    //         interface.name.contains("tun") ||
    //         interface.name.contains("ppp") ||
    //         interface.name.contains("pptp"))
    //     : isVpnActive = false;
    // return isVpnActive;
  }
}
