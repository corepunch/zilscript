# Blind typed playtest of uncovered endings

Fresh Terra players explored remaining authored outcomes. They began on Zilscript
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

The transcripts were reproduced on the builds on which players recorded
them and checked on the repaired build. For sessions
that branched from earlier commands, the transcript includes the replayed
opening and the recorded continuation.

## Newly covered endings

| Book | Seed | Outcome and transcript | Build |
| --- | ---: | --- | --- |
| `blackout-at-meridian` | 18 | [Carried from the Storm](blackout-at-meridian-carried-from-the-storm.txt) | starting commit |
| `blackwood-horror` | 1 | [Cold exposure](blackwood-horror-cold-exposure.txt) | starting commit |
| `blackwood-horror` | 1 | [Patient 189 recognizes the player](blackwood-horror-recognition.txt) | starting commit |
| `blackwood-horror` | 1 | [Patient 189 becomes whole](blackwood-horror-reunification.txt) | starting commit |
| `blackwood-horror` | 1 | [The experiment repeated](blackwood-horror-self-injection.txt) | starting commit |
| `last-door-of-battleworld` | 97 | [The Last Door Stays Open · emergency power](last-door-of-battleworld-emergency-power.txt) | starting commit |
| `limehouse-killings` | 1 | [The Limehouse Killings — Unsolved](limehouse-killings-unsolved.txt) | starting commit |
| `wondertown` | 1 | [Morning has come, and the toys are sleeping](wondertown-dawn-before-winding.txt) | *repaired* |
| `wondertown` | 1 | [Pip has saved what he could of Wrenfold](wondertown-partial.txt) | *repaired* |

## Findings and fixes

| Book | Finding | Fix |
| --- | --- | --- |
| Wondertown | The partial rewind had ending prose, but the only caller required three companions and always selected full restoration. The optional dawn countdown was also hard to discover. Its expiry said the heart had never been wound even if it was already turning. | The heart now offers an explicit `FINISH REWIND` choice after at least one companion joins. Continuing to add companions still reaches full restoration. The opening names the optional countdown, and dawn prose follows the heart’s state. The Terra player reached the partial ending and both dawn variations through typed commands. |
| Blackwood Horror | The syringe was described as empty even while carrying the vial. The fill probe was rejected, and the eventual self-injection appeared to administer a dose from an empty syringe. [Adverse ending](blackwood-horror-self-injection.txt) | Examining the syringe with the vial at hand explains that the dose is drawn on use. The ending describes drawing it and retains the check that requires the vial. |

In Battleworld, the visible tower door now answers examination.

## Additional runs

| Book | Seed | Outcome and transcript | Build |
| --- | ---: | --- | --- |
| `blackout-at-meridian` | 1 | [Lights of Meridian · defeated the drone](blackout-at-meridian-combat-victory.txt) | starting commit |
| `blackout-at-meridian` | 2 | [Lights of Meridian · directly disabled the console](blackout-at-meridian-console-victory.txt) | starting commit |
| `blackwood-horror` | 1 | [The experiment repeated](blackwood-horror-self-injection-repeat.txt) | starting commit |
| `blackwood-horror` | 1 | [Patient 189 released without recognition](blackwood-horror-unrecognized-release.txt) | starting commit |
| `wondertown` | 1 | [Morning has come, and the toys are sleeping · heart already turning](wondertown-dawn-after-winding.txt) | *repaired* |
| `wondertown` | 1 | [Pip has restored the heart of Wrenfold](wondertown-full-restoration.txt) | starting commit |

## Meridian seed trials

- [blackout-at-meridian, seed 3](blackout-at-meridian-seed-trial-3.txt) · in progress
- [blackout-at-meridian, seed 10](blackout-at-meridian-seed-trial-seek10.txt) · in progress
- [blackout-at-meridian, seed 11](blackout-at-meridian-seed-trial-seek11.txt) · in progress
- [blackout-at-meridian, seed 12](blackout-at-meridian-seed-trial-seek12.txt) · in progress
- [blackout-at-meridian, seed 13](blackout-at-meridian-seed-trial-seek13.txt) · in progress
- [blackout-at-meridian, seed 14](blackout-at-meridian-seed-trial-seek14.txt) · in progress
- [blackout-at-meridian, seed 15](blackout-at-meridian-seed-trial-seek15.txt) · in progress
- [blackout-at-meridian, seed 16](blackout-at-meridian-seed-trial-seek16.txt) · in progress
- [blackout-at-meridian, seed 17](blackout-at-meridian-seed-trial-seek17.txt) · in progress
- [blackout-at-meridian, seed 19](blackout-at-meridian-seed-trial-seek19.txt) · in progress
- [blackout-at-meridian, seed 20](blackout-at-meridian-seed-trial-seek20.txt) · in progress
- [blackout-at-meridian, seed 21](blackout-at-meridian-seed-trial-seek21.txt) · in progress
- [blackout-at-meridian, seed 22](blackout-at-meridian-seed-trial-seek22.txt) · in progress
- [blackout-at-meridian, seed 23](blackout-at-meridian-seed-trial-seek23.txt) · in progress
- [blackout-at-meridian, seed 4](blackout-at-meridian-seed-trial-seek4.txt) · in progress
- [blackout-at-meridian, seed 5](blackout-at-meridian-seed-trial-seek5.txt) · in progress
- [blackout-at-meridian, seed 6](blackout-at-meridian-seed-trial-seek6.txt) · in progress
- [blackout-at-meridian, seed 7](blackout-at-meridian-seed-trial-seek7.txt) · in progress
- [blackout-at-meridian, seed 8](blackout-at-meridian-seed-trial-seek8.txt) · in progress
- [blackout-at-meridian, seed 9](blackout-at-meridian-seed-trial-seek9.txt) · in progress
