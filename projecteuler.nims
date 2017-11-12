import os

## Testing tasks
proc run(name: string) =
  if not dirExists "bin":
    mkDir "bin"
  if not dirExists "nimcache":
    mkDir "nimcache"
  --run
  --nimcache: "nimcache"
  switch("out", ("./bin/" & name))
  setCommand "c", "src/" & name & ".nim"


task launch, "Run specific project":
  if paramCount()>0:
    run parseStr(paramStr(1)) ## Cannot 'importc' variable at compile time :/
  else:
    echo "Please choose a pjeuler project to run like pjeuler001"