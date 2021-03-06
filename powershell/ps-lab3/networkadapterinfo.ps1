
$enabledadapters = get-ciminstance win32_networkadapterconfiguration | Where-Object ipenabled -match true 

$enabledadapters |
select-object @{n="Name";e={$_.description}},
               Index,
               IpAddress,
               @{n="SubnetMsk";e={$_.IPSubnet}},
               DNSDomain,
               DNSHostname,
               @{n="DNSServer";e={$_.DNSserversearchorder}} |
format-table