Public Function ConvertToCSV(ByVal strFullPath As String, ByVal strWorkbookName As String, ByVal strCVSName As String) As Boolean

Dim iFile As Long, myPath As String
Dim myArr() As Variant, outStr As String
Dim iLoop As Long, jLoop As Long
Dim wb As Excel.Workbook
Dim ws As Excel.Worksheet

Application.Workbooks.Open Filename:=strFullPath
Set wb = Workbooks(strWorkbookName & ".xlsx")
wb.Activate
myPath = Application.ActiveWorkbook.Path
iFile = FreeFile
Open myPath & "\" & strWorkbookName & ".csv" For Output Lock Write As #iFile
Set ws = wb.Sheets("Sheet1")
myArr = ws.UsedRange
For iLoop = LBound(myArr, 1) To UBound(myArr, 1)
    outStr = ""
    'If iLoop = 5943 Then
    '    Stop
    'End If
    For jLoop = LBound(myArr, 2) To UBound(myArr, 2) - 1
        'If jLoop = 22 Then
        '    Stop
        'End If
        If InStr(1, Replace(Replace(Replace(myArr(iLoop, jLoop), ";", ""), """", ""), vbLf, ""), ";") Then
            outStr = outStr & """" & Replace(Replace(Replace(myArr(iLoop, jLoop), ";", ""), vbLf, ""), """", "") & """" & ";"
        Else
            outStr = outStr & Replace(Replace(Replace(myArr(iLoop, jLoop), ";", ""), vbLf, ""), """", "") & ";"
        End If
    Next jLoop
    If InStr(1, Replace(Replace(Replace(myArr(iLoop, jLoop), ";", ""), """", ""), vbLf, ""), ";") Then
            outStr = outStr & """" & Replace(Replace(Replace(myArr(iLoop, UBound(myArr, 2)), ";", ""), vbLf, ""), """", "") & """"
        Else
            outStr = outStr & Replace(Replace(Replace(myArr(iLoop, UBound(myArr, 2)), ";", ""), vbLf, ""), """", "")
    End If
    Print #iFile, outStr
Next iLoop

Close iFile
Erase myArr

wb.Close False

Set wb = Nothing
Set ws = Nothing

ConvertToCSV = True



End Function