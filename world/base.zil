;"Everything an adventure needs, whatever its rules: the parser and
  main loop, vocabulary and messages, the shared world model, and
  the world verbs (look, take, open, walk, talk, save). A ruleset composes
  its own rules over this file: rulesets/classic/init.zil, rulesets/superhero/init.zil.
  Keep declaration order."
<INSERT-FILE "world.loop">
<INSERT-FILE "core.clock">
<INSERT-FILE "world.parser">
<INSERT-FILE "world.syntax">
<INSERT-FILE "world.macros">
<INSERT-FILE "core.objects">
<INSERT-FILE "core.world">
<INSERT-FILE "world.verbs">
<INSERT-FILE "world.globals">
