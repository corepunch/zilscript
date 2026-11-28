# Meridian and Wondertown playtest, 2026-11-28

These are code-informed replay sessions, not independent blind playtests. The
existing scripted walkthroughs supply the commands; all games ran with
Lua 5.5.1. No claim of exhaustive coverage follows from a completed route.

## Meridian: English, German, Russian

- English and German: the walkthrough plays each of the three hero
  profiles with fixed seeds 98–100, retries failed rescue and relay checks,
  and reaches FINISH. It also follows the first companion card for six seeds.
- Russian: the typed-command walkthrough covers all three
  profiles, both endings, failed rolls, repeat rescue and kit actions,
  pre-registration commands, long UTF-8 input, and 480 adversarial commands.
- Finding: at the relay, the choice between attacking the drone and reaching
  past it was mechanically consequential but the examination did not explain
  either danger or the relevant check. In all three editions the console now
  names both approaches and their risks. After a failed tram rescue the text
  now makes the passenger's immediate danger tangible and tells the player
  that another attempt is possible. The winning scene brings back the boy
  rescued on the bridge in all three editions. These changes do not promise that a
  failed roll is harmless: health loss and the terminal loss still apply.
- Result: all three walkthroughs passed after editing. This replay does not
  establish blind discoverability of every alternative command.

## Wondertown: English

- Seed 97: an existing 57-step walkthrough reached the best
  ending. The timed ending regression also passed.
- Adversarial reproduction: start the game, issue `easy`, then `wait` until
  sunrise. Before the fix the last warning was at turn 174, with 25 ticks
  remaining: “first grey hint of approaching dawn”. The next warning was
  scheduled too late, and sunrise ended the story at turn 200 without a
  later warning. The more urgent authored warnings existed but were skipped.
- Fix: after the grey-sky threshold the warning reschedules every five turns
  instead of 25. The full-countdown regression asserts that an urgent warning
  actually appears after the grey-sky warning and before sunrise. The
  countdown remains opt-in; the opening also gives the distant toys a personal
  stake in Pip's errand. The full ending now responds to each offering at the
  heart: a music box, tin soldier, doll arm, or button earns its own image.
  The walkthrough verified the music box and soldier payoffs.
- Result: the full-countdown regression, timed-ending regression, and 57-step
  best-ending reader walkthrough passed. This does not exercise every object
  interaction or every possible timer toggle sequence.
