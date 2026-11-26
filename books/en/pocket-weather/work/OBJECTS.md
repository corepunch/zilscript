# Stage 2-3 parser registry
Each row is one physical instance. Implementation dungeon.zil is authoritative flag/location inventory.

Bell (Dispatch, fixed): bell; ring/pull; immediate reward and dispatch ritual.
Card (Dispatch, TAKEBIT): card, forecast-card; draft/approved data, identity token; no global noun CARD.
Mica (Dispatch then Broadcast, ACTORBIT): mica/postmaster; forecast/promise/pause topics; mentor learning responsibility.
Vane (Vane deck, TURNBIT): vane/weathercock; wind observation and rook counterweight.
Rook (Rookery then Vane, ACTORBIT): rook/bird/aster; trade and optional joke.
Apron (Laundry, fixed): apron/pocket; SEARCH reveals button and ribbon, both INVISIBLE until found.
Button (Laundry hidden then PLAYER then ROOK, TAKEBIT): button/brass-button; trade and hand-me-down memory.
Ribbon (Laundry hidden then PLAYER then CHIME, TAKEBIT): ribbon; tie/untie; quiet and tactile kindness.
Pip (Kitchen, ACTORBIT): pip/baker; kettle/report/promise dialogue.
Spoon (Kitchen, TAKEBIT TOOLBIT): spoon; gutter tool, baking measure.
Kettle (Kitchen, fixed): kettle/steam; report warming and Pip joke.
Weatherbox (Archive, CONTBIT SEARCHBIT closed): weatherbox/box; OPEN reveals report, LOOK IN native.
Report (weatherbox, TAKEBIT): report/fold; physical softening and historical evidence.
Flower (Archive hidden then accessible after report read, TAKEBIT): flower/blossom; optional tender detail, show to cloud.
Gutter (Garden, fixed): gutter/channel; DIG/CLEAR WITH SPOON; practical route and listening to roots.
Seedlings (Garden, fixed): seedlings/plants/roots; thirst evidence; inspect after preparation.
Shed chart (Shed, fixed): chart; READ teaches downwind rain route; optional pictorial clue, noun chart distinct from card/report.
Chime (Arch, CONTBIT OPENBIT): chime/clapper; TIE/UNTIE and LISTEN; ribbon physically attached.
Cloud (Hollow then Terrace, ACTORBIT): cloud/nimbus; LISTEN/SHOW/TELL; weather partner, not captive.
Slot (Broadcast, CONTBIT OPENBIT): slot/broadcast; PUT approved card, public result.
Topics (GLOBAL-OBJECTS, NDESCBIT): forecast, promise, pause, yesterday, joke. All available in conversation rooms; no overlap with portable head nouns.

Object verb matrix and scope checks: hidden apron contents excluded from prose until SEARCH. Weatherbox starts closed. Report's pressed flower INVISIBLE and not named until READ. All permanent scenery introduced by room action and NDESCBIT; portable objects use FDESC or native listing. Tools use HELD? plus ACCESSIBLE? in explicit handlers. Default TAKE/DROP untouched on portable objects.

# Authored binary menus
Every one of the 25 objects declares ordinary `INTERACTIONS` data. Binary partner lists are intentionally narrow; unary examination, take/drop, reading and native controls keep their normal behavior. The parser still accepts experiments beyond the suggested menu.

- Rook/button: the real trade and its showing preview; rook topics forecast, promise and joke.
- Report: steam over kettle, or the understandable wrong spoon; show to Pip, Nimbus or Mica.
- Gutter: spoon and ribbon remain real contrasting tool attempts.
- Chime/ribbon: both offered tie orientations and untying remain available.
- Nimbus: forecast, yesterday, pause, promise, report and flower.
- Mica/card: written review, showing and approved publication to the slot; no unrelated container partners.
- Pip: forecast, yesterday, promise and pause, plus the historical report.
- Other objects: no meaningful binary relationship, so an empty property suppresses irrelevant pair multiplication.

All secondary objects remain subject to actual scope and discovery. The pressed flower is still hidden until the softened report is read; no menu can expose it early. Global conversation topics must first appear as prose links. No secondary item needed for completion is available only by inspecting hidden source.
