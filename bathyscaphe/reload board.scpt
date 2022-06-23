property interval : 30

on run
  set msg1 to "スレッド一覧のオートリロードを" & interval & "秒間隔で開始してもよろしいですか？"
  set msg2 to "何も操作をしないと、10秒後に自動的にオートリロードが開始されます。"
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
      if class of eachDoc is browser then reload list eachDoc
    end repeat
  end tell
  return interval
end idle
