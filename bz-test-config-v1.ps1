configuration MyConfig03 {
    param (
        [String[]]$Server=$env:COMPUTERNAME
    )
    
    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'
	Import-DscResource -ModuleName 'xWinEventLog'

    # Just some test bits...
    # more bits...

    Node $Server {
        Registry SetRegistry
        {
            Ensure = 'Present'
            Key = 'HKLM:\SOFTWARE\BZ'
            ValueName = 'test'
            ValueData = 'Dude!'
            ValueType = 'String'
        }

        Log MyLog
        {
            Message = 'Here is a boring log message from bz'
            DependsOn = '[Registry]SetRegistry'
        }
		
		xWinEventLog WMILogAnalytic
        {
            LogName            = "Microsoft-Windows-DSC/Analytic"
            IsEnabled          = $true
        }
		
		xWinEventLog WMILogDebug
        {
            LogName            = "Microsoft-Windows-DSC/Debug"
            IsEnabled          = $true
        }
	}
}
