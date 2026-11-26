# Blackout at Meridian — prototype

Original setting, characters and prose; no licensed superhero identities.

## Architecture

The independent adventure packages supply rooms, inventory, commands, visibility and prose links. The book explicitly imports rulesets.superhero.en; no historical game directory is required. The classic composition is still shared until semantic action policies are extracted. A separate ZIL module, `rulesets/superhero/percentile.zil`, owns numerical character state, checks, damage and resource accounting. Books import it explicitly; other rulesets can use the same pattern without changing the compiler. The module does not know any room or story object.

Historical references: TSR Marvel Super Heroes (1984), seven attributes, Health and Karma sums, and percentile checks with four outcome tiers. See https://index.rpg.net/display-generalinfo.phtml?key=system&match=precise&value=Marvel+Super+Heroes . DC Heroes (1985) is a future candidate, not implemented. No source text, characters, artwork or original table graphic copied. Standard-rank percentile thresholds are derived from the historical cumulative probabilities documented at https://www.darkshire.net/~jhkim/rpg/systemdesign/dice-msh.html ; intermediate ranks round down and the extreme shift ranks are not separately modeled. The recovery rule, encounter difficulty and combat loop are independent prototype choices. This is not a complete implementation of the original Karma, FEAT intensity, column-shift or combat rules; do not claim full compatibility.

## Play

Choose Bulwark, Arc or Lens via their linked profiles. Use NAME SHEET to enter an alias (ASCII, stored lowercase by READ, up to 32 characters). Use the sheet to inspect attributes. Rescue the passengers, then defeat the drone or bypass its control system. Defeat is terminal; failures consume health; the kit can be used once.

Adventure Arena's command replay saves can reproduce the entered name and random sequence. The CLI binary-snapshot mode resumes at the normal parser boundary; its optional name prompt must be validated separately before claiming compatibility.

## Validation

Run `lua5.4 run-zil-test.lua tests/test-superhero-rules` for the rules and `lua5.4 books/blackout-at-meridian/test/test_walkthrough_rules.lua` for a seeded typed walkthrough (profile, sheet, rescue, drone, ending); `make test-book-walkthroughs` runs it. The CLI plays it with `lua5.4 llm.lua --new-game --game blackout-at-meridian`. The native build and the iOS reader have not been verified.
