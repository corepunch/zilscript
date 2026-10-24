#!/usr/bin/env python3
"""Source-informed author verification. Every executed action is --choose N.
The expected route is a test oracle, not evidence of blind play.
Run from zilscript/: python3 books/last-broadcast/test/menu_cli.py
"""
from pathlib import Path
import json
import re
import subprocess

book = Path('books/last-broadcast')
route = json.loads((book / 'test/route.json').read_text())
route = [c for c in route if c not in ('take ledger', 'take chart', 'take receipt')]
route = [c.replace('use spanner on hatch', 'use hatch with spanner')
          .replace('use stylus on gramophone', 'use gramophone with stylus') for c in route]
final_index = route.index('reconstruct casebook')
route[final_index:final_index] = ['show disc to ada', 'show boots to ada', 'show counterweight to ada']
source = (book / 'test/test_last_broadcast_links.lua').read_text()
pairs = re.findall(r'\{ "([^"]+)", "([^"]+)" \}', source[source.index('local names ='):source.index('local function canonical')])

def canonical(command):
    command = re.sub(r'^ask ', 'tell ', command)
    for before, after in pairs:
        command = command.replace(before, after)
    return command

save = '/tmp/last-broadcast-numeric-cli.sav'

def invoke(*arguments):
    process = subprocess.run(['/tmp/lua5.4', 'llm.lua', '--game', 'last-broadcast',
                              '--save', save, *arguments], text=True, capture_output=True)
    assert process.returncode == 0, process.stderr + process.stdout
    return json.loads(process.stdout)

state = invoke('--new-game', '--links', '--seed', '97')
transcript = ['SOURCE-INFORMED AUTHOR CHECK; NOT BLIND QA\n', state['output']]
selections = []

def choose(number):
    global state
    action = state['actions'][number - 1]
    state = invoke('--choose', str(number))
    selections.append({'number': number, 'label': action[0], 'command': action[1],
                       'room': state['room'], 'running': state['running']})
    transcript.append(f'\nCHOOSE {number}: {action[0]} [{action[1]}]\n' + state['output'])

for step, wanted in enumerate(route, 1):
    index = None
    for attempt in range(3):
        index = next((i for i, action in enumerate(state['actions'], 1)
                      if canonical(action[1]) == canonical(wanted)), None)
        if index is not None:
            break
        if attempt < 2:
            choose(2 if attempt == 0 else 1)
    assert index is not None, f'Step {step}: missing {wanted}\n{state["actions"]}'
    choose(index)
assert not state['running'], 'Ending must be terminal in persisted reader state'
assert 'CASE SOLVED' in state['output'], 'Actual solved ending required'
assert not invoke('--links')['running'], 'A restored ending must remain terminal'
(book / 'test/numeric-transcript.txt').write_text(''.join(transcript))
(book / 'test/numeric-route.json').write_text(json.dumps(selections, indent=2) + '\n')
print(f'{len(selections)} source-informed --choose invocations reach persisted FINISH')
