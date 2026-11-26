# German source provenance

`infocom/zork1-de` is Infocom's German Zork I (release 15). It is reference
material: we study it and play it in tests (`tests/test_german_zork.lua`) to
learn how a German package must work. We do not ship it.

The German parser, syntax, messages, loop, classic globals and verb handlers
in this folder were relocated from that archive and keep their original
notices. They are a working starting point for our own German package, not
its final form: German adventures we publish should run on a package we have
written, using what `docs/LANGUAGE-PACKAGES.md` records about the reference.
Code shared with English in `core/` and `rulesets/classic/common.zil` derives
from the MIT-licensed English Zork I source.
