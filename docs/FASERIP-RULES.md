# Percentile superhero rules and character sheets

The original reference is Jeff Grubb's
[Advanced Players' Book](https://mshgamer.com/wp-content/uploads/2013/03/TSR6871.Advanced.Players.Book_.pdf)
(TSR, 1986): rank ranges and outcome probabilities on the back cover,
intensity and column shifts on printed pp. 14–16, and Karma in chapter 4.
The blank character sheet is on printed p. 64 of the
[Advanced Judge's Book](https://mshgamer.com/wp-content/uploads/2013/03/TSR6871.Advanced.Judge_.Book_.pdf).
This is an independently written implementation of selected mechanics, not a
bundled scan, licensed game engine, or a claim of full rules compatibility.

## In the ruleset

- **Ranks are bands.** A value of 37 already qualifies for Incredible, and
  16–25 use the same Excellent probability column. Health and starting
  Karma are still the sums of the original, unshifted ability values.
- **Column shifts change the lookup, not the character.** Ordinary shifts
  are bounded by Shift 0 and Shift Z. Explicit Class 1000, Class 3000,
  Class 5000 and Beyond bands don't shift; Beyond uses the internal sentinel
  rank 10,000. These sentinel values are implementation choices, not a
  point scale for cosmic characters.
- **Intensity determines what counts as success.** Relative to the effective
  ability band, lower intensity needs green, equal needs yellow and higher
  needs red. A scene can opt into no-roll success for an advantage of more
  than three columns or refuse a task more than one column above the ability.
  The original rules leave these cases to the Judge; here they're author
  choices. They don't roll or spend anything. Ordinary color-gated checks
  still have the existing, generic `CHECK` interface.
- **Karma is never spent by default.** A book can authorize it before a
  particular roll. Our single-player policy then spends enough to reach its
  required color, at least 10 if available (including on an already
  successful roll), never more than the available reserve. It aims for the
  declared target, not the highest color. The final roll is capped at 100.
  This is a solo adaptation of the original declaration and post-roll
  spending choice. The current Meridian book does not enable Karma boosts
  on rolls; its first-aid kit still uses its existing explicit cost.

### Pure ZIL interface

```zil
;"A slippery attempt at an Intensity 20 challenge, down one column."
<FASERIP-FEAT ,HERO ,A-AGILITY 20 -1>

;"At this optional route, impossible and routine cases don't roll."
<FASERIP-FEAT ,HERO ,A-STRENGTH 20 0 T T>

;"Use only after the player commits Karma to this specific attempt."
<FASERIP-FEAT ,HERO ,A-REASON 20 0 <> <> T>
```

Arguments after intensity are optional: signed column shift, allow automatic
success, enforce impossible limits, approved Karma. The result is a ZIL
boolean. `LAST-FEAT-RAW`, `LAST-FEAT-KARMA`, `LAST-FEAT-REQUIRED`, and
`LAST-FEAT-RANK` describe the check; `LAST-ROLL` and `LAST-TIER` describe
the adjusted roll and achieved result. Required tier 0 means automatic,
4 means impossible; both have a zero roll and spend. Future scenes should
decide whether a blow, retreat, clue, or cost follows. The ruleset knows
nothing about rooms or objects.

Meridian's first rescue still requires green for each profile. The guarded
relay console discloses its target before the player tries it: Reason 40 for
Lens needs green (31+), Reason 20 for Arc needs yellow (71+), and Reason 6 for
Bulwark needs red (98+). Fighting the drone stays equally available to every
hero. An unguarded console has no skill check. This distinguishes approaches
without making any profile unable to complete the adventure.

## Sheet export

The existing live name, profile and `SHEET-ROW(label, value, maximum)`
remain usable. The generic kernel accepts an optional row emitter for rulesets
that need a richer sheet. Meridian's emitter appends two optional fields:

- `group`: stable ID, `abilities`, `powers` or `resources`.
- `rankLabel`: localized plain text, attached to rank-based fields only.

The sheet shows seven abilities and Power with both titles and numeric values,
then current and maximum Health and current Karma. Taking a sheet snapshot
doesn't advance time or call the RNG. Other RPGs needn't use the superhero
fields. The companion Adventure Arena change groups the exported rows and
leaves handwritten sections for information the game does not track. The
original artwork and form did not enter the project.

Not implemented: a full combat effects matrix, stunts, manual post-roll
Karma bidding, campaign advancement, Resources/Popularity mechanics or
arbitrary character generation. Add these only when a published scenario
uses them; don't make them mandatory for the shared RPG kernel.

See [module structure and the recommendation for Meridian](FASERIP-ADVENTURE-MODULES.md).
