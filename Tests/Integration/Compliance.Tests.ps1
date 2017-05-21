$ModuleName = 'PSCodeHealth'
Import-Module "$PSScriptRoot\..\..\$ModuleName\$($ModuleName).psd1" -Force
$CodePath = "$PSScriptRoot\..\TestData\coveralls"

Describe 'Test-PSCodeHealthCompliance' {

    $CoverallsHealthReport = Invoke-PSCodeHealth -Path $CodePath

    Context 'Given code in coveralls module, it returns the expected compliance results' {

        $Result = $CoverallsHealthReport | Test-PSCodeHealthCompliance
        $LinesOfCode = $Result | Where-Object MetricName -eq 'LinesOfCode'
        $ScriptAnalyzerFindings = $Result | Where-Object MetricName -eq 'ScriptAnalyzerFindings'
        $TestCoverage = $Result | Where-Object MetricName -eq 'TestCoverage'
        $Complexity = $Result | Where-Object MetricName -eq 'Complexity'
        $MaximumNestingDepth = $Result | Where-Object MetricName -eq 'MaximumNestingDepth'
        $LinesOfCodeTotal = $Result | Where-Object MetricName -eq 'LinesOfCodeTotal'
        $LinesOfCodeAverage = $Result | Where-Object MetricName -eq 'LinesOfCodeAverage'
        $ScriptAnalyzerFindingsTotal = $Result | Where-Object MetricName -eq 'ScriptAnalyzerFindingsTotal'
        $NumberOfFailedTests = $Result | Where-Object MetricName -eq 'NumberOfFailedTests'
        $TestsPassRate = $Result | Where-Object MetricName -eq 'TestsPassRate'
        $CommandsMissedTotal = $Result | Where-Object MetricName -eq 'CommandsMissedTotal'
        $ComplexityAverage = $Result | Where-Object MetricName -eq 'ComplexityAverage'
        $NestingDepthAverage = $Result | Where-Object MetricName -eq 'NestingDepthAverage'

        It 'Should return correct value for the metric : LinesOfCode' {
            $LinesOfCode.Value | Should Be 39
        }
        It 'Should return correct compliance result for the metric : LinesOfCode' {
            $LinesOfCode.Result | Should Be 'Warning'
        }
        It 'Should return correct value for the metric : ScriptAnalyzerFindings' {
            $ScriptAnalyzerFindings.Value | Should Be 0
        }
        It 'Should return correct compliance result for the metric : ScriptAnalyzerFindings' {
            $ScriptAnalyzerFindings.Result | Should Be 'Pass'
        }
        It 'Should return correct value for the metric : TestCoverage' {
            ($TestCoverage | Where-Object SettingsGroup -eq 'PerFunctionMetrics').Value |
            Should Be 0
        }
        It 'Should return correct compliance result for the metric : TestCoverage' {
            ($TestCoverage | Where-Object SettingsGroup -eq 'PerFunctionMetrics').Result |
            Should Be 'Fail'
        }
        It 'Should return correct value for the metric : Complexity' {
            $Complexity.Value | Should Be 5
        }
        It 'Should return correct compliance result for the metric : Complexity' {
            $Complexity.Result | Should Be 'Pass'
        }
        It 'Should return correct value for the metric : MaximumNestingDepth' {
            $MaximumNestingDepth.Value | Should Be 3
        }
        It 'Should return correct compliance result for the metric : MaximumNestingDepth' {
            $MaximumNestingDepth.Result | Should Be 'Pass'
        }
        It 'Should return correct value for the metric : LinesOfCodeTotal' {
            $LinesOfCodeTotal.Value | Should Be 201
        }
        It 'Should return correct compliance result for the metric : LinesOfCodeTotal' {
            $LinesOfCodeTotal.Result | Should Be 'Pass'
        }
        It 'Should return correct value for the metric : LinesOfCodeAverage' {
            $LinesOfCodeAverage.Value | Should Be 22.33
        }
        It 'Should return correct compliance result for the metric : LinesOfCodeAverage' {
            $LinesOfCodeAverage.Result | Should Be 'Pass'
        }
        It 'Should return correct value for the metric : ScriptAnalyzerFindingsTotal' {
            $ScriptAnalyzerFindingsTotal.Value | Should Be 0
        }
        It 'Should return correct compliance result for the metric : ScriptAnalyzerFindingsTotal' {
            $ScriptAnalyzerFindingsTotal.Result | Should Be 'Pass'
        }
        It 'Should return correct value for the metric : NumberOfFailedTests' {
            $NumberOfFailedTests.Value | Should Be 0
        }
        It 'Should return correct compliance result for the metric : NumberOfFailedTests' {
            $NumberOfFailedTests.Result | Should Be 'Pass'
        }
        It 'Should return correct value for the metric : TestsPassRate' {
            $TestsPassRate.Value | Should Be 100
        }
        It 'Should return correct compliance result for the metric : TestsPassRate' {
            $TestsPassRate.Result | Should Be 'Pass'
        }
        It 'Should return correct value for the metric : TestCoverage' {
            ($TestCoverage | Where-Object SettingsGroup -eq 'OverallMetrics').Value |
            Should Be 21.43
        }
        It 'Should return correct compliance result for the metric : TestCoverage' {
            ($TestCoverage | Where-Object SettingsGroup -eq 'OverallMetrics').Result |
            Should Be 'Fail'
        }
        It 'Should return correct value for the metric : CommandsMissedTotal' {
            $CommandsMissedTotal.Value | Should Be 77
        }
        It 'Should return correct compliance result for the metric : CommandsMissedTotal' {
            $CommandsMissedTotal.Result | Should Be 'Fail'
        }
        It 'Should return correct value for the metric : ComplexityAverage' {
            $ComplexityAverage.Value | Should Be 2
        }
        It 'Should return correct compliance result for the metric : ComplexityAverage' {
            $ComplexityAverage.Result | Should Be 'Pass'
        }
        It 'Should return correct value for the metric : NestingDepthAverage' {
            $NestingDepthAverage.Value | Should Be 1.11
        }
        It 'Should return correct compliance result for the metric : NestingDepthAverage' {
            $NestingDepthAverage.Result | Should Be 'Pass'
        }
    }
    Context 'Given code in coveralls module, it returns the expected compliance summary result' {

        $Result = $CoverallsHealthReport | Test-PSCodeHealthCompliance -Summary
        
        It 'Should return "Fail"' {
            $Result | Should Be 'Fail'
        }
    }
    Context 'Given code in coveralls module and specific metric names, it returns the expected compliance summary result' {

        $Result = $CoverallsHealthReport | Test-PSCodeHealthCompliance -MetricName Complexity,ComplexityAverage,NestingDepthAverage -Summary
        
        It 'Should return "Pass"' {
            $Result | Should Be 'Pass'
        }
    }
}