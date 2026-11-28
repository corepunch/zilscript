# The Last Door of Battleworld / Последняя дверь Мира битв

An unofficial bilingual family adventure inspired by *Secret Wars*. Pick
Spider-Man, Storm or Iron Man. When a voice orders Earth's heroes to fight,
there are people on this new planet who have other things to ask of you.

## Start a family game

From the **lua-objc** checkout run `make battleworld`. For Russian run
`make battleworld BATTLEWORLD_LANGUAGE=ru`. The first screen offers three
heroes. Use the arrow keys and press Enter. When the menu shows numbers,
enter a number instead. One person can be the voice of the world while
the other decides what the hero tries. Swap jobs when you reach camp.

Read the room aloud, including the exits. If a child has an idea, let them
try it as a command, even if it isn't on the menu. Try `examine` with a
noun, `take` a loose object, or `put` one thing `in` another. A failed roll
leaves another way forward. There is time to go back and try things.

**Для первой партии** запустите `make battleworld BATTLEWORLD_LANGUAGE=ru`
из папки lua-objc. Один игрок читает вслух, другой выбирает действие.
Выбирайте стрелками и нажимайте Enter. Можно также ввести свою команду, например «осмотреть маяк». Если
бросок не удался, оглядитесь: обычно рядом найдётся другой способ помочь.

From the standalone **ZILScript** checkout, use Lua 5.4:

```sh
lua5.4 main.lua --companion books.en.last-door-of-battleworld.last-door-of-battleworld
lua5.4 main.lua --companion books.ru.last-door-of-battleworld.last-door-of-battleworld
```

Use `--text` for a typed-only game. `status` / «статус» shows the hero's
current Health and Karma. This development playtest runs outside the native
app catalog. The two editions share their game state and rules.

[Campaign scope and adaptation notes](../../shared/last-door-of-battleworld/LIMITS.md) contain spoilers.

![The Last Door of Battleworld](cover.jpg)

The family playtest’s black-and-white card and sheet portraits are details from the supplied TSR *Secret Wars* module (MHSP1): Spider-Man from printed page 16, Iron Man from roster page 4, and Storm from roster page 7.
