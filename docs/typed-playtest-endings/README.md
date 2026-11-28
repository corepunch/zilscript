# Blind typed playtest of uncovered endings

Fresh Terra players explored the remaining authored outcomes in the 20
catalog editions. They began on Zilscript
`56b458bf7be7d99451a328382434d164e53c725e` and used only commands typed into
the game and the responses it produced. They could replay their own commands
or change the starting seed. The Wondertown entries marked *repaired*
were played on the repaired build using its in-game prompts.

The previous [catalog playtest](../typed-playtest/README.md) and
[alternate-route playtest](../typed-playtest-alternates/README.md) supply
the other endings. The inventory counts distinct authored finale scenes,
including the Battleworld methods that share an ending title and the
Blackwood resolutions that share a score. The two Wondertown dawn scenes
are variations of one outcome. Score ranks and generic engine exits such
as QUIT are outside that inventory.

All 13 previously uncovered endings reached a terminal state.
All 43 transcripts were reproduced on the builds on which the
players recorded them and checked on the repaired build. For sessions
that branched from earlier commands, the transcript includes the replayed
opening and the recorded continuation.

## Newly covered endings

| Edition | Seed | Outcome and transcript | Build |
| --- | ---: | --- | --- |
| `de/blackout-at-meridian` | 18 | [Aus dem Sturm getragen](de-blackout-at-meridian-aus-dem-sturm-getragen.txt) | starting commit |
| `en/blackout-at-meridian` | 18 | [Carried from the Storm](en-blackout-at-meridian-carried-from-the-storm.txt) | starting commit |
| `en/blackwood-horror` | 1 | [Cold exposure](en-blackwood-horror-cold-exposure.txt) | starting commit |
| `en/blackwood-horror` | 1 | [Patient 189 recognizes the player](en-blackwood-horror-recognition.txt) | starting commit |
| `en/blackwood-horror` | 1 | [Patient 189 becomes whole](en-blackwood-horror-reunification.txt) | starting commit |
| `en/blackwood-horror` | 1 | [The experiment repeated](en-blackwood-horror-self-injection.txt) | starting commit |
| `en/last-door-of-battleworld` | 97 | [The Last Door Stays Open · emergency power](en-last-door-of-battleworld-emergency-power.txt) | starting commit |
| `en/limehouse-killings` | 1 | [The Limehouse Killings — Unsolved](en-limehouse-killings-unsolved.txt) | starting commit |
| `en/wondertown` | 1 | [Morning has come, and the toys are sleeping](en-wondertown-dawn-before-winding.txt) | *repaired* |
| `en/wondertown` | 1 | [Pip has saved what he could of Wrenfold](en-wondertown-partial.txt) | *repaired* |
| `ru/blackout-at-meridian` | 18 | [Спасение из бури](ru-blackout-at-meridian-rescued-from-the-storm.txt) | starting commit |
| `ru/last-door-of-battleworld` | 97 | [Сделка Дума](ru-last-door-of-battleworld-dooms-bargain.txt) | starting commit |
| `ru/last-door-of-battleworld` | 97 | [Последняя дверь открыта · Worldship converter](ru-last-door-of-battleworld-worldship-converter.txt) | starting commit |

## Findings and fixes

| Edition | Finding | Fix |
| --- | --- | --- |
| Wondertown | The partial rewind had ending prose, but the only caller required three companions and always selected full restoration. The optional dawn countdown was also hard to discover. Its expiry said the heart had never been wound even if it was already turning. | The heart now offers an explicit `FINISH REWIND` choice after at least one companion joins. Continuing to add companions still reaches full restoration. The opening names the optional countdown, and dawn prose follows the heart’s state. The Terra player reached the partial ending and both dawn variations through typed commands. |
| The Last Door of Battleworld | The Russian invite to hear Doom’s offer prompted `выслушать предложение`, which failed. The visible door, workshop schematic and inflected references to Kang also rejected reasonable commands. [Offer](ru-last-door-of-battleworld-dooms-bargain.txt) · [Tower and workshop](ru-last-door-of-battleworld-worldship-converter.txt) | The offer accepts the spoken verb and tells players how to read it before deciding. The door gives an answer in both editions, and the Russian schematic and Kang’s name resolve in their scenes. Reading the schematic leaves the workshop and Worldship puzzle prerequisites in place. |
| Blackwood Horror | The syringe was described as empty even while carrying the vial. The fill probe was rejected, and the eventual self-injection appeared to administer a dose from an empty syringe. [Adverse ending](en-blackwood-horror-self-injection.txt) | Examining the syringe with the vial at hand explains that the dose is drawn on use. The ending describes drawing it and retains the check that requires the vial. |

## Additional runs

| Edition | Seed | Outcome and transcript | Build |
| --- | ---: | --- | --- |
| `en/blackout-at-meridian` | 1 | [Lights of Meridian · defeated the drone](en-blackout-at-meridian-combat-victory.txt) | starting commit |
| `en/blackout-at-meridian` | 2 | [Lights of Meridian · directly disabled the console](en-blackout-at-meridian-console-victory.txt) | starting commit |
| `en/blackwood-horror` | 1 | [The experiment repeated](en-blackwood-horror-self-injection-repeat.txt) | starting commit |
| `en/blackwood-horror` | 1 | [Patient 189 released without recognition](en-blackwood-horror-unrecognized-release.txt) | starting commit |
| `en/wondertown` | 1 | [Morning has come, and the toys are sleeping · heart already turning](en-wondertown-dawn-after-winding.txt) | *repaired* |
| `en/wondertown` | 1 | [Pip has restored the heart of Wrenfold](en-wondertown-full-restoration.txt) | starting commit |

## Meridian seed trials

- [de/blackout-at-meridian, seed 2](de-blackout-at-meridian-seed-trial-de2.txt) · in progress
- [de/blackout-at-meridian, seed 3](de-blackout-at-meridian-seed-trial-de3.txt) · in progress
- [en/blackout-at-meridian, seed 3](en-blackout-at-meridian-seed-trial-en3.txt) · in progress
- [ru/blackout-at-meridian, seed 2](ru-blackout-at-meridian-seed-trial-ru2.txt) · in progress
- [ru/blackout-at-meridian, seed 3](ru-blackout-at-meridian-seed-trial-ru3.txt) · in progress
- [en/blackout-at-meridian, seed 10](en-blackout-at-meridian-seed-trial-seek10.txt) · in progress
- [en/blackout-at-meridian, seed 11](en-blackout-at-meridian-seed-trial-seek11.txt) · in progress
- [en/blackout-at-meridian, seed 12](en-blackout-at-meridian-seed-trial-seek12.txt) · in progress
- [en/blackout-at-meridian, seed 13](en-blackout-at-meridian-seed-trial-seek13.txt) · in progress
- [en/blackout-at-meridian, seed 14](en-blackout-at-meridian-seed-trial-seek14.txt) · in progress
- [en/blackout-at-meridian, seed 15](en-blackout-at-meridian-seed-trial-seek15.txt) · in progress
- [en/blackout-at-meridian, seed 16](en-blackout-at-meridian-seed-trial-seek16.txt) · in progress
- [en/blackout-at-meridian, seed 17](en-blackout-at-meridian-seed-trial-seek17.txt) · in progress
- [en/blackout-at-meridian, seed 19](en-blackout-at-meridian-seed-trial-seek19.txt) · in progress
- [en/blackout-at-meridian, seed 20](en-blackout-at-meridian-seed-trial-seek20.txt) · in progress
- [en/blackout-at-meridian, seed 21](en-blackout-at-meridian-seed-trial-seek21.txt) · in progress
- [en/blackout-at-meridian, seed 22](en-blackout-at-meridian-seed-trial-seek22.txt) · in progress
- [en/blackout-at-meridian, seed 23](en-blackout-at-meridian-seed-trial-seek23.txt) · in progress
- [en/blackout-at-meridian, seed 4](en-blackout-at-meridian-seed-trial-seek4.txt) · in progress
- [en/blackout-at-meridian, seed 5](en-blackout-at-meridian-seed-trial-seek5.txt) · in progress
- [en/blackout-at-meridian, seed 6](en-blackout-at-meridian-seed-trial-seek6.txt) · in progress
- [en/blackout-at-meridian, seed 7](en-blackout-at-meridian-seed-trial-seek7.txt) · in progress
- [en/blackout-at-meridian, seed 8](en-blackout-at-meridian-seed-trial-seek8.txt) · in progress
- [en/blackout-at-meridian, seed 9](en-blackout-at-meridian-seed-trial-seek9.txt) · in progress
