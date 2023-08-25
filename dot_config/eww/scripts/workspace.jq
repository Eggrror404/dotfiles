# vim: filetype=jq
# passed in args: $workspaces, $clients, $monitors, $apps

### Set variables
# active display
($monitors[] | select(.focused == true)) as $activeDp |
# get active workspace
($activeDp | .activeWorkspace.id) as $activeWs |
# remove negative pid
($clients | map(select(.pid > 0 and .mapped))) as $clients |
# select workspaces in current screen
($workspaces | map(select(.monitor == $activeDp.name)) |
  # add window class property for each workspace
  map(.lastwindow as $last | .lastwindowclass = (($clients[] | select(.address == $last).class) // null))) as $workspaces |

## Regex testing func
# . -> regex; $class, $title -> actual window
def matchClassTitle($class; $title):
  if $class != null then
    .class as $classReg | (.title // "") as $titleReg |
    (($class // "") | test($classReg)) and (($title // "") | test($titleReg))
  else null end;

## Add current workspaces into array
# $apps.workspaces as initial value
reduce $workspaces[] as $work ($apps.workspaces;
  { class: $work.lastwindowclass, title: $work.lastwindowtitle } as $wsWindow |
  ($work.id - $activeDp.id * 10 - 1) as $wsIndex |
  if $work.windows > 0 or .[($wsIndex)] == null then
    .[($wsIndex)] += $wsWindow
  else . end
) |

## Set id & remove null values
to_entries | map(
  if .value != null then
    { id: (.key+1), active: (.key+1 == ($activeWs - $activeDp.id * 10)) } + .value
  else
    empty
  end |

  # set icons
  ({ class, title } as $app |
    last($apps.apps[] | select(matchClassTitle($app.class; $app.title)))) as $icon |
  .icon = ($icon.icon // .id) |
  .color = ($icon.color // "blue") |

  .occupied = ([.id] | inside($clients | map(.workspace.id - $activeDp.id * 10))) |

  # cleanup
  delpaths([ ["class"], ["title"] ])
)
