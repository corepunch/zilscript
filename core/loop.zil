;"Language-neutral main loop: the M-* handler codes, player and turn globals,
  and MAIN-LOOP, extracted unchanged from the identical English and German
  sources. Each language loop inserts this file first and supplies MAIN-LOOP-1,
  PERFORM and its D-APPLY dispatch.
  (c) Copyright 1983 Infocom, Inc. See LICENSE-ZORK-MIT."

<CONSTANT SERIAL 0>

<GLOBAL PLAYER <>>

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>

<CONSTANT M-HANDLED 1>

<CONSTANT M-NOT-HANDLED <>>

<CONSTANT M-OBJECT <>>

<CONSTANT M-BEG 1>

<CONSTANT M-END 6>

<CONSTANT M-ENTER 2>

<CONSTANT M-LOOK 3>

<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

<ROUTINE MAIN-LOOP ("AUX" TRASH)
	 <REPEAT ()
		 <SET TRASH <MAIN-LOOP-1>>>>

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>
