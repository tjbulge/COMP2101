function SysInformation{
    write-output "
    ******System Info******"

    $sysinfo = get-ciminstance win32_computersystem
    new-object -typename psobject -property @{"Name"=$sysinfo.name
                                            "Vendor"=$sysinfo.Manufacturer
                                            "Model"=$sysinfo.Model } | 
                                            format-list
}


function OSInformation {
    write-output "
    ******OS Info******"

    $osinfo = get-ciminstance win32_operatingsystem
    new-object -typename psobject -property @{"Operating System"=$osinfo.name
                                            "Version #"=$osinfo.version} |
                                            format-list
}

function ProcessorInformation {
    write-output "
    
    ******Processor Info******"

    $processor = get-ciminstance win32_processor
    $processor | 
    select-object Description,
                @{Name="Speed"; E={if ($_.MaxClockSpeed) {$_.MaxClockSpeed} else{"Data Unavailable"}}},
                @{Name="Number of Cores" ; E={if ($_.numberofcores) {$_.numberofcores} else {"Data Unvailable"}}},
                @{Name="L1 Cache Size" ; E={if ($_.l1cachesize) {$_.l1cachesize} else {"Data Unvailable"}}},
                @{Name="L2 Cache Size" ; E={if ($_.l2cachesize) {$_.l2cachesize} else {"Data Unvailable"}}},
                @{Name="L3 Cache Size" ; E={if ($_.l3cachesize) {$_.l3cachesize} else {"Data Unvailable"}}} |
    format-list

}

function MemoryInformation {
    write-output "
    ******Memory Info******"

    $MemoryDIMMS = get-ciminstance win32_physicalmemory
    $memory = foreach ($stick in $MemoryDIMMS) { $stick | 
        select-object @{Name="Vendor"; E={$_.Manufacturer}},
                    Description,
                    @{Name="Size(GB)"; E={$_.formfactor}},
                    @{Name="Bank"; E={$_.BankLabel}},
                    @{Name="Slot"; E={$_.devicelocator}}
    }
    $memory | format-table
}

function DiskInformation{
    write-output "
    ******Disk Info******"

    $diskdrives = Get-CIMInstance CIM_diskdrive

    $diskinfo = foreach ($disk in $diskdrives) {
        $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
        foreach ($partition in $partitions) {
                $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
                foreach ($logicaldisk in $logicaldisks) {
                        new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                                Location=$partition.deviceid
                                                                Drive=$logicaldisk.deviceid
                                                                "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                                } 
            } 
        }
    } 

    $diskinfo | format-table
}

function NetworkInformation{
    write-output "
    ******Network Info******"

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
}

function VideoInformation {
    write-output "
    ******Video Card Info******"

    $videocard = get-ciminstance win32_videocontroller

    $videocard | 
    select-object @{name="Vendor"; E={ if ($_.adaptercompatibility) {$_.adaptercompatibility} else {"Data Unavailable"}}},
                Description,
                @{name="Resolution"; E={ if ($_.videomodedescription) {$_.videomodedescription} else {"Data Unavailable"}}} |
    format-list
}
