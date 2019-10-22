# encoding is UTF-8, so need to use PowerShell Core
# ショートカットを作成し、リンク先を次のように設定することで
# このショートカットへの DnD で変換が可能になる。
# C:\Users\yuki\scoop\apps\pwsh\current\pwsh.exe -NoProfile -File <このファイルを絶対パスで指定>\mkv-to-mov.ps1

param (
    [Parameter(ValueFromRemainingArguments=$true)]
    $files
)

$files | ForEach-Object {
    $infile = $_
    $outfile = $infile.Substring(0, $infile.LastIndexOf('.')) + ".mov"
    ffmpeg -i $infile -c copy  -map 0 $outfile 
}

'Task end'