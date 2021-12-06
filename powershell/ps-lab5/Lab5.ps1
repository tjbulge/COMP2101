param(

[parameter()] [switch]$system,
[parameter()] [switch]$disks,
[parameter()] [switch]$network

)

if ($system -eq $true) {
    OSInformation
    ProcessorInformation
    MemoryInformation
    VideoInformation
}

if ($disks -eq $true) {
    DiskInformation
}

if ($network -eq $true) {
    NetworkInformation
}

