$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if(!$isAdmin) {
  Read-Host "Please execute with administrator. Please press any key..."
  exit
}

$path = "HKLM:\SYSTEM\CurrentControlSet\services\i8042prt\Parameters"

$in = Read-Host "Plese enter if ja->en 1, elseif en->ja 2"
switch($in) {
  1 {
    # change to en
    Set-ItemProperty $path -name "LayerDriver JPN" -value "kbd101.dll"
    Set-ItemProperty $path -name "OverrideKeyboardIdentifier" -value "PCAT_101KEY"
    Set-ItemProperty $path -name "OverrideKeyboardSubtype" -value "0"
  }
  2 {
    # change to ja
    Set-ItemProperty $path -name "LayerDriver JPN" -value "kbd106.dll"
    Set-ItemProperty $path -name "OverrideKeyboardIdentifier" -value "PCAT_106KEY"
    Set-ItemProperty $path -name "OverrideKeyboardSubtype" -value "2"
  }
  default {
    Read-Host "Canceled the processing. Please press any key..."
    exit
  }
}

$in = Read-Host "Done! Can I restart computer?(y/n)"
switch ($in) {
  "y" { Restart-Computer }
  "n" { exit }
}
