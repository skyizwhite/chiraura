property interval : 15

on run
  set msg1 to "開いているすべてのスレッドを" & interval & "秒間隔で自動更新します。"
  set msg2 to "自動更新を終了するには、このアプリケーションを終了してください。この画面は、何も操作しないと 10 秒後に自動的に閉じ、自動更新が開始されます。"
  try
    display alert msg1 message msg2 buttons {"キャンセル", "開始"} default button 2 cancel button 1 giving up after 10
  on error errMsg number errNum
    if errNum = -128 then
      if (id of current application) is not "com.apple.ScriptEditor2" then
        quit
      end if
    end if
  end try
end run

on idle
  tell application "BathyScaphe"
    repeat with eachDoc in documents
      if class of document is not reply document then
        try
          reload thread eachDoc
        end try
      end if
    end repeat
  end tell
  return interval
end idle
