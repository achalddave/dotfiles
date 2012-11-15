Function get-com-objects {
  gci HKLM:\Software\Classes -ea 0| ? {$_.PSChildName -match '^\w+\.\w+$' -and (gp "$($_.PSPath)\CLSID" -ea 0)}
}

# example use of above
# get-com-objects | where {$_.pschildname -like '*word*'} | ft pschildname

Function grep ($pattern) {
  gci -r -i *.* | select-string -pattern $pattern
}
