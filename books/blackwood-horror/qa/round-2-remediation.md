# Blackwood Horror — round 2 remediation

The blind report and VM transcript were frozen in `round-2.md` and `round-2.transcript.txt` before inspecting source. No ending was reached during the blind session; the runtime PRNG snapshot change interrupted it. The parser walkthrough is separate implementation verification, not a claim of a blind success.

## Corrected book defects

- Added the missing ETHER adjective so the authored `ether bottle` link is executable.
- Added recursive search flags to storage shelves and the medical bag. An opened bag on shelves now exposes its actual vial and bandages to the parser without taking the bag first.
- The safe accepts its actual key within an accessible carried open book. A hidden key inside a closed carried book does not bypass the lock.
- Explicit wrong tools no longer silently invoke a different carried tool: shovel cannot cut chains or pry the small clasp; safe, drawer and chapel each reject another key.
- The boiler owns its authored KINDLE action and delegates to one ignition routine. The lantern only handles actions directed at itself, so it cannot consume `turn on boiler with lantern` as an instruction to light the lantern.
- Removed the duplicate fueled Boolean. The coal object's actual location determines whether fuel exists. Removing cold coal prevents ignition; burning coal cannot be carried out of an active firebox.
- Opening a valve before firing the boiler no longer conjures steam. The sealed door requires the open valve and actual boiler heat.
- The medicine cabinet owns SCRAPE; Patient 189 owns INJECT and GREET. These actions can be discovered from object behavior by the shared linked-action interface.
- Linked private notes and the relic at their discovery; made medical-record links unambiguous; corrected unlit-lantern wording, the locker bank's singular description and a duplicate padded-cell exit. Patient 189's greeting now has its own prose and preserves the ending requirements.

## Regression evidence

`test-round-2.zil` first failed on offered `examine ether bottle` with the same parser rejection recorded blind. After that fix it exposed the nested vial scope failure, then passed both. It now covers nested-key access versus hidden-key bypass, fuel removal, actual steam gating, KINDLE and instrument dispatch.

`test-round-2-tools.zil` first failed because `attack chains with shovel` printed successful scalpel cutting while the scalpel was merely carried. The corrected test passes wrong/correct tool pairs for chains, numbered drawer, wall safe, chapel and relic box.

`test-round-2-flame.zil` reproduced the separate shared preaction failure for a lit lantern; it passes after the parent's runtime correction.

Book lint checks passed: 0 critical vocabulary errors, 180 links checked, 59 link targets examined through the parser, and 2050 common object commands played without silence. The full existing parser walkthrough passed after book changes.

One shared issue remains under investigation at this writing: the generated canonical phrase `oil lantern` is rejected although unqualified `lantern` works and OIL is the object's declared adjective. The main new regression intentionally retains canonical commands to detect this before round 3. Final validation results will be appended after the parent's shared correction.
