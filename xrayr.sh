bash <(curl -Ls https://raw.githubusercontent.com/XrayR-project/XrayR-release/master/install.sh)
clear
read -p " NODE ID : " node_id1
  [ -z "${node_id1}" ] && node_id1=0
rm -rf /etc/XrayR/ngocvinh4g.crt
rm -rf /etc/XrayR/ngocvinh4g.key
openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes -out /etc/XrayR/ngocvinh4g.crt -keyout /etc/XrayR/ngocvinh4g.key -subj "/C=JP/ST=Tokyo/L=Chiyoda-ku/O=Google Trust Services LLC/CN=google.com"
cd /etc/XrayR
cat >config.yml <<EOF
Log:
  Level: none 
  AccessPath: # /etc/XrayR/access.Log
  ErrorPath: # /etc/XrayR/error.log
DnsConfigPath: # /etc/XrayR/dns.json
InboundConfigPath: # /etc/XrayR/custom_inbound.json
RouteConfigPath: # /etc/XrayR/route.json
OutboundConfigPath: # /etc/XrayR/custom_outbound.json
ConnetionConfig:
  Handshake: 4 
  ConnIdle: 30 
  UplinkOnly: 2 
  DownlinkOnly: 4 
  BufferSize: 64 
Nodes:
  -
    PanelType: "V2board" 
    ApiConfig:
      ApiHost: "https://ngocvinh4g.net"
      ApiKey: "vuvietdung06082000"
      NodeID1: 1
      NodeType: V2ray 
      Timeout: 30 
      EnableVless: false 
      EnableXTLS: false 
      SpeedLimit: 0 
      DeviceLimit: 0
      RuleListPath: # /etc/XrayR/rulelist
    ControllerConfig:
      DisableSniffing: True
      ListenIP: 0.0.0.0 
      SendIP: 0.0.0.0 
      UpdatePeriodic: 60 
      EnableDNS: false 
      DNSType: AsIs 
      EnableProxyProtocol: false 
      EnableFallback: false 
      FallBackConfigs:  
        -
          SNI: 
          Path: 
          Dest: 80 
          ProxyProtocolVer: 0 
      CertConfig:
        CertMode: file 
        CertDomain: "vn.sieutocdo.net" 
        CertFile: /etc/XrayR/sieutocdo.crt
        KeyFile: /etc/XrayR/sieutocdo.key
        Provider: cloudflare 
        Email: test@me.com
        DNSEnv: 
          CLOUDFLARE_EMAIL:
          CLOUDFLARE_API_KEY:
EOF
sed -i "s|NodeID1:.*|NodeID: ${node_id1}|" ./config.yml
cd /root && xrayr restart && clear && echo -e "   Cài Đặt Hoàn Tất!"
