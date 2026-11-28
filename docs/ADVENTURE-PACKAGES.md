# Adventure packages

```
books/<book>/            book entry, rooms, objects, prose and actions
  rulesets/<rules>/      classic actions or a tabletop system
    world/base.zil       parser, loop, vocabulary and common verbs
      core/              runtime state and shared ZIL routines
```

A story imports a ruleset using its qualified name:

```zil
<INSERT-FILE "rulesets.classic.init">
<INSERT-FILE "dungeon">
<INSERT-FILE "actions">
```

`world/base.zil` composes the parser, its syntax and global objects, and the
common verbs such as LOOK, TAKE, OPEN and WALK. It builds on `core/`, which
defines parser state, the main loop, the clock, object traversal and movement.
The order in the base file keeps these dependencies available during loading.

`rulesets/classic/init.zil` adds the combat, magic, treasure and puzzle verbs.
`rulesets/horror/init.zil` uses those verbs and adds the exposure routine.
`rulesets/superhero/init.zil` and `rulesets/investigator/init.zil` load the
RPG kernel, its actions, and their own system. See [RPG systems](RPG-SYSTEMS.md).

Keep story-specific names and `ZORK-NUMBER` branches in the story. Zork I
defines its own object responses and replaces a few world routines in
`infocom/zork1/actions.zil`. A later ROUTINE replaces an earlier one, but an
object's ACTION is bound when the object is defined. Where syntax for a verb
comes from both the world and a ruleset, its syntax block grows as the files
load.

Plural nouns carry `PLURALBIT`. The `A` and `CA` tokens print "some", and
`AGREE` chooses the matching form for a reply.

Run `make test-adventure-packages` to check the dependency graph and load
original stories with access to imported game files blocked. Run
`make test-pure-zil` for parser and walkthrough coverage.

The shared world derives from the MIT-licensed November 2025 Zork I release.
Keep the notices shipped with the sources.
