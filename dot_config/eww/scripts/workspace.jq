# vim: filetype=jq
# passed in args: $workspaces, $clients, $monitors, $apps

### Set variables
# extract app class names from $apps.apps
($apps.apps | group_by(.class) | map({ key: .[0].class, value: (map(del(.class)) | sort_by(.title)) }) | from_entries) as $icons |
# add window class property for each workspace
($workspaces | map(.lastwindow as $last | .lastwindowclass = ($clients | map(select(.address == $last))[0].class))) as $workspaces |
# map client titles to their workspace
($clients | group_by(.workspace.id) | map({ key: (.[0].workspace.id|tostring), value: map(.title) }) | from_entries) as $clientTitles |
# get active workspace
($monitors[] | select(.focused == true) | .activeWorkspace.id ) as $activeId |

## Regex testing func
def matchClassTitle($class; $title):
  .class as $classReg | (.title // "") as $titleReg |
  (($class // "") | test($classReg)) and (($title // "") | test($titleReg));

## Add current workspaces into array
# $apps.workspaces as initial value
reduce $workspaces[] as $work ($apps.workspaces;
  { class: $work.lastwindowclass, title: $work.lastwindowtitle } as $workspaceApp |
  if .[($work.id-1)] == null then
    # add in if not present
    .[($work.id-1)] //= $workspaceApp
  elif .[($work.id-1)].fallback // [] | any(matchClassTitle($workspaceApp.class; $workspaceApp.title)) then
    # replace original when one of the fallbacks matches
    .[($work.id-1)] += $workspaceApp
  else . end
) |

## Set id & remove null values
to_entries | map(
  if .value != null then
    { id: (.key+1), active: (.key+1 == $activeId) } + .value
  else
    empty
  end |

  # set icons
  ({ class, title } as $app |
    last($apps.apps[] | select(matchClassTitle($app.class; $app.title)))) as $icon |
  .icon = ($icon.icon // .id) |
  .color = ($icon.color // "blue") |

  # set clients
  .clients = ($clientTitles[.id|tostring] // [] | join("\n"))

  # cleanup
  #delpaths([["class"], ["title"], ["fallback"]])
)
