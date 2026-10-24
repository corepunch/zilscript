"""Source-informed numeric-only CLI proof; not blind QA. Run from zilscript/."""
import json, pathlib, subprocess, sys
book = pathlib.Path('books/pocket-weather/test')
save = '/tmp/pocket-weather-menu-proof.sav'
base = ['/tmp/lua5.4', 'llm.lua', '--game', 'pocket-weather', '--save', save]
def call(*args):
    process = subprocess.run(base + list(args), capture_output=True, text=True)
    if process.returncode:
        raise RuntimeError(process.stderr or process.stdout)
    return json.loads(process.stdout)
state = call('--new-game', '--links')
steps = []
def choose(command):
    global state
    matches = [(i+1,a) for i,a in enumerate(state['actions']) if a[1].lower() == command]
    if not matches:
        print('MISSING:', command)
        print(json.dumps(state, indent=2))
        raise SystemExit(1)
    index, action = matches[0]
    state = call('--choose', str(index))
    steps.append({'number': index, 'command': action[1], 'room': state['room'], 'output': state['output']})
    print(len(steps), index, action[1], '->', state['room'])
commands = [
'examine forecast', 'take weather card', 'west', 'take narrow spoon', 'west',
'examine laundry apron', 'take brass button', 'take soft ribbon', 'north',
'give brass button to aster rook', 'east', 'spin weather vane', 'down', 'east',
'dig garden gutter with narrow spoon', 'east', 'read rain chart', 'west', 'west', 'south', 'south',
'open weatherbox', 'take folded report', 'north', 'west',
'inventory', 'steam folded report over steaming kettle', 'read folded report', 'east', 'north', 'north',
'tie wind chime to soft ribbon', 'east', 'listen to nimbus cloud',
'show folded report to nimbus cloud', 'tell nimbus cloud about pause rule',
 'tell nimbus cloud about promise', 'west', 'south', 'south', 'inventory',
 'write weather card', 'give weather card to postmaster mica', 'east',
 'put weather card in broadcast slot', 'west', 'north', 'drizzle nimbus cloud']
for command in commands:
    choose(command)
book.joinpath('menu-walkthrough.json').write_text(json.dumps(steps, indent=2)+'\n')
assert not state['running'], 'Ending must be terminal'
assert 'A FORECAST YOU CAN KEEP' in state['output']
print('Numeric-only route complete:', len(steps), 'choices; terminal ending.')
