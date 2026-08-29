# WireGuard Topology
| Shape | Mermaid syntax | Meaning |
|-------|----------------|---------|
| Rounded rectangle | `( )` | host |
| Hexagon | `{{ }}` | router/firewall |
| Circle | `(( ))` | uncontrolled access |
| Solid edge | `---` | physical link |
| Dashed edge | `-.->` | WireGuard tunnel |

| Keyword | Meaning |
|---------|---------|
| `IP` | WireGuard addresses 10.100.0.0/16 |
| `server` | the WireGuard server/hub every peer connects to |
| `full` | AllowedIPs `0.0.0.0/0` all traffic routed through home |
| `split` | AllowedIPs `10.100.0.0/24` + `192.168.0.0/24` only |

```mermaid
%%{init: {"flowchart": {"wrappingWidth": 300}}}%%
flowchart RL
    internet@{ shape: cloud, label: "internet" }

    subgraph server_site["server site - 192.168.0.0/24"]
        server("<b>server</b><br/>IP: 10.100.0.1 (server)")
        isp_router{{"<b>router (ISP)</b><br/>DDNS: server.zzzealed.com<br/>NAT-forward: udp/51820, tcp/2267"}}
    end

    subgraph apartment["apartment - 192.168.8.0/24"]
        desktop("<b>desktop</b><br/>IP: 10.100.0.2 (full)")
        pi("<b>pi</b><br/>IP: 10.100.0.3 (split)")
        own_router{{"<b>router (own)</b><br/>DDNS: pi.zzzealed.com<br/>NAT-forward: tcp/2267"}}
    end

    subgraph cloud["Oracle cloud - 10.0.0.0/24"]
        vps("<b>vps</b><br/>IP: 10.100.0.4 (split)")
        vcn{{"<b>Oracle VCN+IGW</b><br/>DDNS: vps.zzzealed.com<br/>security lists: tcp/2267"}}
    end

    phone("<b>phone</b><br/>IP: 10.100.0.6 (full)")
    laptop("<b>laptop</b><br/>IP: 10.100.0.5 (full)")
    cell(("cell tower"))
    wifi(("public WiFi"))

    server --- isp_router
    isp_router --- internet

    desktop --- own_router
    pi --- own_router
    own_router --- internet

    vps --- vcn
    vcn --- internet

    phone --- cell
    cell --- internet
    laptop --- wifi
    wifi --- internet

    server -. "wireguard" .-> desktop
    server -. "wireguard" .-> pi
    server -. "wireguard" .-> vps
    server -. "wireguard" .-> phone
    server -. "wireguard" .-> laptop  
```
