Function Public () {
<#
.SYNOPSIS
    This cmdlet configures nothing and does it remarkably well.

.DESCRIPTION
    This cmdlet configures nothing and does it remarkably well.
    It takes objects as input and it sets nothing to 42.
#>
    
    Function Nested ($InputObject) {
        Get-Item $InputObject
    }
}

Function Private ($InputObject) {
    # A simple line of comment
    Get-Item $InputObject
}
