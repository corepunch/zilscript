<SYNTAX TURN OBJECT = V-SPIN>

; === ACTION ROUTINES ===

; --- Evidence Object Actions ---

<ROUTINE TELEGRAM-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "Lady Ashworth's message reads: “Begin with what the locked room could not hide. Ashworth marked every private mechanism with the name of the person it concerned.” Beneath it she has added, “Hudson has put the kettle on; he insists detection is impossible while cold.”" CR>
           <RTRUE>)>>

<ROUTINE DEAD-LETTER-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "The letter reads: “My dear [[Dr. Moriarty->moriarty]], I know what you did. If you do not confess by Friday, I will expose you to Scotland Yard. - Lord Ashworth”" CR>
           <COND (<NOT ,DEAD-LETTER-FOUND>
                  <SETG DEAD-LETTER-FOUND T>
                  <SETG EVIDENCE-FOUND <+ ,EVIDENCE-FOUND 1>>
                  <SCORE-UPD 10>
                  <CHECK-CASE-PROGRESS>)>
           <RTRUE>)>>

<ROUTINE BLOOD-STAINED-KNIFE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Dried blood darkens the narrow blade. This is a surgeon's knife, much finer than dinner cutlery; the handle bears a small engraved M." CR>
           <COND (<NOT ,KNIFE-FOUND>
                  <SETG KNIFE-FOUND T>
                  <SETG EVIDENCE-FOUND <+ ,EVIDENCE-FOUND 1>>
                  <SCORE-UPD 10>
                  <CHECK-CASE-PROGRESS>)>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the knife carefully. This could be important." CR>
           <MOVE ,BLOOD-STAINED-KNIFE ,WINNER>
           <FCLEAR ,BLOOD-STAINED-KNIFE ,NDESCBIT>
           <FSET ,BLOOD-STAINED-KNIFE ,TOUCHBIT>
           <COND (<NOT ,KNIFE-FOUND>
                  <SETG KNIFE-FOUND T>
                  <SETG EVIDENCE-FOUND <+ ,EVIDENCE-FOUND 1>>
                  <SCORE-UPD 10>
                  <CHECK-CASE-PROGRESS>)>
           <RTRUE>)>>

<ROUTINE LOCKED-BOX-F ()
    <COND (<VERB? SPIN>
           <COND (,LOCKED-BOX-OPENED <TELL "The dial already rests at MORIARTY. The box stands open." CR>)
                 (T <TELL "The dial clicks from name to name. Which will you turn it to: [[Lady Ashworth->ashworth]], [[Mr. Hudson->hudson]], or [[Dr. Moriarty->moriarty]]?" CR>)>)
          (<VERB? EXAMINE READ>
           <COND (,LOCKED-BOX-OPENED
                  <TELL "The box stands open, its dial resting at MORIARTY between the engraved letter, flower, and columns of debt.">
                  <COND (<IN? ,BANK-STATEMENT ,LOCKED-BOX> <TELL " A [[bank statement->statement]] lies inside.">)>
                  <CRLF>
                  <RTRUE>)>
           <TELL "The box has no keyhole. A lettered name dial is ringed by tiny engravings: a sealed letter, a purple flower, and columns of debt. The dial can be aligned to any of three names: [[Lady Ashworth->ashworth]], [[Mr. Hudson->hudson]], or [[Dr. Moriarty->moriarty]]. Only the name that connects all three engravings will open it." CR>
           <SETG BOX-CLUE-SEEN T>
           <RTRUE>)
          (<VERB? TURN ALIGN>
           <COND (,LOCKED-BOX-OPENED
                  <TELL "The box is already open; the dial has done its work." CR>
                  <RTRUE>)
                 (<OR <EQUAL? ,PRSI ,DR-MORIARTY>
                      <EQUAL? ,PRSI ,MORIARTY-TOPIC>>
                  <COND (<AND ,DEAD-LETTER-FOUND
                              ,POISON-IDENTIFIED
                              ,SECRET-LEDGER-FOUND>
                         <TELL "You align the dial to MORIARTY. Letter, wolfsbane, and debt: the three engravings click beneath your fingers. The box opens, revealing a [[bank statement->statement]]." CR>
                         <SETG LOCKED-BOX-OPENED T>
                         <FSET ,LOCKED-BOX ,OPENBIT>
                         <MOVE ,BANK-STATEMENT ,LOCKED-BOX>
                         <FSET ,BANK-STATEMENT ,NDESCBIT>)
                        (<NOT ,DEAD-LETTER-FOUND>
                         <TELL "The dial resists at the sealed-letter engraving. Search Ashworth's desk and read his correspondence." CR>)
                        (<NOT ,POISON-IDENTIFIED>
                         <TELL "The dial resists at the purple-flower engraving. Compare the poison bottle with the labeled greenhouse plants to connect the substance to its source." CR>)
                        (T
                         <TELL "The dial resists at the columns of debt. Read the ledger in the library." CR>)>
                  <RTRUE>)
                 (T
                  <TELL "The dial turns back to blank. That name does not connect the box's three engravings." CR>
                  <RTRUE>)>)
          (<VERB? OPEN UNLOCK>
           <COND (,LOCKED-BOX-OPENED
                  <TELL "The box is already open." CR>
                  <RTRUE>)
                 (T
                  <TELL "There is no keyhole to pick. The name dial is the lock: examine the box, then align its dial to one of the names." CR>
                  <RTRUE>)>)>>

<ROUTINE POISON-BOTTLE-F ()
    <COND (<AND <VERB? USE-ON> <EQUAL? ,PRSI ,PLANTS>>
		<IDENTIFY-POISON>
		<RTRUE>)
	(<VERB? EXAMINE READ>
           <TELL "The bottle is labeled: “Aconitum - Wolfsbane. Highly poisonous.”" CR>
            <COND (<NOT ,POISON-BOTTLE-FOUND>
                   <SETG POISON-BOTTLE-FOUND T>
                   <SETG EVIDENCE-FOUND <+ ,EVIDENCE-FOUND 1>>
                   <SCORE-UPD 10>
                   <CHECK-CASE-PROGRESS>)>
           <RTRUE>)
           (<VERB? TASTE>
            <TELL "A bitter trace touches your tongue. Your vision swims and your pulse stumbles; perhaps that wasn't wise." CR>
           <SETG PLAYER-HEALTH <- ,PLAYER-HEALTH 1>>
           <COND (<==? ,PLAYER-HEALTH 0>
                  <TELL "You collapse. Everything goes dark." CR>
                  <SETG GAME-LOST T>
                  <SETG GAME-ENDED T>
                  <FINISH>)>
           <RTRUE>)>>

<ROUTINE SECRET-LEDGER-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "Ashworth has entered a loan of £500 against [[Dr. Moriarty->moriarty]]'s name. The due date was Friday; beneath it, in a heavier hand, he has written UNPAID." CR>
            <COND (<NOT ,SECRET-LEDGER-FOUND>
                   <SETG SECRET-LEDGER-FOUND T>
                   <SETG EVIDENCE-FOUND <+ ,EVIDENCE-FOUND 1>>
                   <SCORE-UPD 10>
                   <CHECK-CASE-PROGRESS>)>
           <RTRUE>)>>

; --- Tool Object Actions ---

<ROUTINE MAGNIFYING-GLASS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A brass magnifying glass, its lens clear and strong." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the magnifying glass." CR>
           <MOVE ,MAGNIFYING-GLASS ,WINNER>
           <FSET ,MAGNIFYING-GLASS ,TOUCHBIT>
           <FCLEAR ,MAGNIFYING-GLASS ,NDESCBIT>
           <RTRUE>)
          (<VERB? USE>
		<COND (<OR <HELD? ,FOOTPRINT-CAST> <IN? ,FOOTPRINT-CAST ,HERE>>
			<TELL "The lens needs a subject. The heel of the [[footprint cast]] has a fine edge worth examining under magnification." CR>)
			(T <TELL "Held over your palm, the lens sharpens each crease. It will be useful on a small mark too fine for the unaided eye." CR>)>
           <RTRUE>)
          (<AND <VERB? USE-ON>
                <EQUAL? ,PRSI ,FOOTPRINT-CAST>>
           <SETG FOOTPRINT-DETAIL-FOUND T>
           <TELL "Under the lens, the plaster preserves more than a size: the outside edge of the right heel has a crescent-shaped nick. It is a defect distinctive enough to compare with a suspect's boot." CR>
           <RTRUE>)
          (<AND <VERB? USE-ON> <EQUAL? ,PRSO ,MAGNIFYING-GLASS>>
           <TELL "The lens shows you nothing there that your unaided eye had missed." CR>
           <RTRUE>)>>

<ROUTINE LOCKPICK-SET-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The leather roll holds fine steel picks. Their thin tips can ease a seized window catch, but will not turn the deep wards of the study lock." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the lockpick set." CR>
           <MOVE ,LOCKPICK-SET ,WINNER>
           <FSET ,LOCKPICK-SET ,TOUCHBIT>
           <RTRUE>)
          (<VERB? USE>
           <TELL "These are fine picks for a seized catch, not a substitute for Hudson's study key. The seized catch of the study window is the place to try them." CR>
           <RTRUE>)
		(<VERB? USE-ON>
		<COND (<EQUAL? ,PRSI ,WINDOW>
			<PERFORM ,V?OPEN ,WINDOW ,LOCKPICK-SET>)
			(<EQUAL? ,PRSI ,STUDY-DOOR>
			<TELL "The fine picks cannot turn this warded lock. Hudson has the study key." CR>)
			(T <TELL "The fine picks are made for the seized window catch." CR>)>
		<RTRUE>)>>

<ROUTINE LANTERN-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The lantern glass is clean, its reservoir full. Several sets of initials are scratched beneath the base; the oldest are worn almost smooth by hands lifting it." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the lantern." CR>
           <MOVE ,LANTERN ,WINNER>
           <FSET ,LANTERN ,TOUCHBIT>
           <FCLEAR ,LANTERN ,NDESCBIT>
           <RTRUE>)
          (<VERB? USE>
           <TELL "You light the lantern. It casts a warm glow." CR>
           <FSET ,LANTERN ,ONBIT>
           <RTRUE>)>>

<ROUTINE KEYRING-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Hudson has tied a paper tag to one long, warded key: STUDY. The smaller keys belong to household cupboards outside this inquiry." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <COND (<IN? ,KEYRING ,WINNER>
                  <TELL "You already have the keyring." CR>)
                 (,HUDSON-KEY-GIVEN
                  <TELL "You take the keyring." CR>
                  <MOVE ,KEYRING ,WINNER>
                  <FSET ,KEYRING ,TOUCHBIT>)
                 (T
                  <TELL "The keyring is not yours. Ask [[Hudson]] about the [[key]] first." CR>)>
           <RTRUE>)>>

; --- Clue Object Actions ---

<ROUTINE TORN-PAGE-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "The page reads: “Among the marked books, follow the rainbow order: red, yellow, green, blue. Only then will the way open.”" CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the torn page." CR>
           <MOVE ,TORN-PAGE ,WINNER>
           <FSET ,TORN-PAGE ,TOUCHBIT>
           <FCLEAR ,TORN-PAGE ,NDESCBIT>
           <RTRUE>)>>

<ROUTINE COLORED-MARKERS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Four ribbons mark books set slightly proud of their neighbors: the [[red book]] on shelf 1, the [[blue book]] on shelf 3, the [[green book]] on shelf 4, and the [[yellow book]] on shelf 2. Each yields a little under your finger." CR>
           <RTRUE>)>>

<ROUTINE CIPHER-BOOK-F ()
    <COND (<VERB? MOVE>
           <COND (,CIPHER-SOLVED <TELL "The book stays on its runners. The passage is already open." CR>)
                 (T <TELL "The book catches against a stop. Its spine gives a little when you press it inward." CR>)>)
          (<VERB? EXAMINE>
		   <TELL "A colored ribbon marks this book. Its spine projects just far enough to press.">
		   <COND (,CIPHER-SOLVED <TELL " The mechanism behind it has already released.">)>
		   <CRLF>
		   <RTRUE>)
		  (<VERB? PUSH>
           <COND (,CIPHER-SOLVED
                  <TELL "The book has done its work; the secret passage already stands open." CR>)
                 (<AND <EQUAL? ,PRSO ,RED-BOOK> <==? ,CIPHER-STAGE 0>>
                  <SETG CIPHER-STAGE 1>
                  <TELL "The red-marked book clicks into place." CR>)
                 (<AND <EQUAL? ,PRSO ,YELLOW-BOOK> <==? ,CIPHER-STAGE 1>>
                  <SETG CIPHER-STAGE 2>
                  <TELL "The yellow-marked book clicks into place." CR>)
                 (<AND <EQUAL? ,PRSO ,GREEN-BOOK> <==? ,CIPHER-STAGE 2>>
                  <SETG CIPHER-STAGE 3>
                  <TELL "The green-marked book clicks into place." CR>)
                 (<AND <EQUAL? ,PRSO ,BLUE-BOOK> <==? ,CIPHER-STAGE 3>>
                  <SOLVE-CIPHER>)
                 (T
                  <SETG CIPHER-STAGE 0>
                  <TELL "The book springs back. The sequence resets." CR>)>
           <RTRUE>)>>

<ROUTINE FOOTPRINT-CAST-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The cast shows a size 10 boot print, too large for Lady Ashworth and narrower than Hudson's work boots.">
           <COND (,FOOTPRINT-DETAIL-FOUND
                  <TELL " Through the magnifying glass you found a crescent-shaped nick on the outside of its right heel.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the footprint cast." CR>
           <MOVE ,FOOTPRINT-CAST ,WINNER>
           <FSET ,FOOTPRINT-CAST ,TOUCHBIT>
           <FCLEAR ,FOOTPRINT-CAST ,NDESCBIT>
           <RTRUE>)
          (<AND <VERB? USE-ON>
                <EQUAL? ,PRSO ,MAGNIFYING-GLASS>>
           <SETG FOOTPRINT-DETAIL-FOUND T>
           <TELL "Under the lens, the plaster preserves more than a size: the outside edge of the right heel has a crescent-shaped nick. It is a defect distinctive enough to compare with a suspect's boot." CR>
           <RTRUE>)>>

<ROUTINE WAX-SEAL-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "A narrow M is pressed into the wax. A broken thread crosses the back: this sealed a small parcel, not an envelope." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the wax seal." CR>
           <MOVE ,WAX-SEAL ,WINNER>
           <FSET ,WAX-SEAL ,TOUCHBIT>
           <FCLEAR ,WAX-SEAL ,NDESCBIT>
           <RTRUE>)>>

<ROUTINE BANK-STATEMENT-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "The statement shows Dr. Moriarty's account is overdrawn. He recently withdrew £500 for “experimental supplies.”" CR>
            <COND (<NOT ,BANK-STATEMENT-FOUND>
                   <SETG BANK-STATEMENT-FOUND T>
                   <SETG EVIDENCE-FOUND <+ ,EVIDENCE-FOUND 1>>
                   <SCORE-UPD 10>
                   <CHECK-CASE-PROGRESS>)>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the bank statement." CR>
           <MOVE ,BANK-STATEMENT ,WINNER>
           <FCLEAR ,BANK-STATEMENT ,NDESCBIT>
           <FSET ,BANK-STATEMENT ,TOUCHBIT>
           <RTRUE>)>>

; --- Furniture/Scenery Actions ---

"The unsent letter lies INVISIBLE among the desk papers until the desk is
examined or searched."

<ROUTINE DESK-F ()
    <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE READ>
           <TELL "The mahogany desk is scarred with use; its three drawers are empty, and papers lie heaped across its top.">
           <COND (<AND <FSET? ,DEAD-LETTER ,INVISIBLE> <IN? ,DEAD-LETTER ,STUDY>>
                  <FCLEAR ,DEAD-LETTER ,INVISIBLE>
                  <THIS-IS-IT ,DEAD-LETTER>
                  <TELL " Among them you turn up a yellowed [[envelope->letter]], addressed in a shaking hand.">)>
           <CRLF>
           <RTRUE>)>>

<ROUTINE FIREPLACE-F ()
    <COND (<VERB? EXAMINE>
           <COND (<EQUAL? ,HERE ,LIBRARY>
                  <TELL "The library grate is swept and cold; no fire has been laid here tonight." CR>)
                 (T
                  <TELL "A small [[box]] sits in the cold ashes of the study fireplace.">
                  <COND (<AND <IN? ,POISON-BOTTLE ,STUDY> <NOT <FSET? ,POISON-BOTTLE ,TOUCHBIT>>>
                         <TELL " A glass [[bottle]] stands on the mantelpiece, its paper label curling at one corner.">)>
                  <COND (,CIPHER-SOLVED
                         <TELL " A panel in the chimney breast stands open on the hidden stair [[down]].">)>
                  <CRLF>)>
           <RTRUE>)>>

<ROUTINE WINDOW-F ()
	<COND (<VERB? EXAMINE>
		<COND (<FSET? ,WINDOW ,OPENBIT>
			<TELL "The window is open. Rust crumbles beneath its raised catch; the garden lies [[southwest]]." CR>)
			(T <TELL "Rust has seized the window catch. A fine pick could lift its tongue; a key will not fit. Beyond the glass, the garden lies to the southwest." CR>)>
		<RTRUE>)
		(<VERB? OPEN UNLOCK>
		<COND (<FSET? ,WINDOW ,OPENBIT>
			<TELL "The window is already open; the garden lies [[southwest]]." CR>)
			(<NOT ,PRSI>
			<TELL "The rusted catch will not move for fingers alone. It needs a fine pick slipped beneath its tongue." CR>)
			(<AND <EQUAL? ,PRSI ,LOCKPICK-SET> <HELD? ,LOCKPICK-SET> <ACCESSIBLE? ,LOCKPICK-SET>>
			<FSET ,WINDOW ,OPENBIT>
			<TELL "You ease a fine pick under the catch. It clicks open; the garden lies [[southwest]]." CR>)
			(T <TELL "That does not fit beneath the window catch." CR>)>
		<RTRUE>)>>

<ROUTINE STUDY-DOOR-F ()
    <COND (<VERB? EXAMINE>
           <COND (<FSET? ,STUDY-DOOR ,OPENBIT>
                  <TELL "The solid oak study door stands open. A fresh scrape on the keep shows where the bolt slid back." CR>)
                 (,STUDY-UNLOCKED
                  <TELL "The solid oak study door is closed but unlocked. The handle turns without catching." CR>)
                 (<==? ,HERE ,STUDY>
                  <TELL "The solid oak study door is closed, its heavy bolt shot home on this side. Opening the door will draw it back." CR>)
                 (T
                  <TELL "The solid oak study door is closed and locked. The keyhole faces the hall, but the bolt is on the study side." CR>)>
           <RTRUE>)
          (<VERB? OPEN>
           <COND (<FSET? ,STUDY-DOOR ,OPENBIT>
                  <TELL "The study door is already open." CR>)
                 (<AND <==? ,HERE ,STUDY> <NOT ,STUDY-UNLOCKED>>
                  <SETG STUDY-UNLOCKED T>
                  <FSET ,STUDY-DOOR ,OPENBIT>
                  <TELL "You draw back the interior bolt and open the study door onto the hall to the [[south]]." CR>)
                 (<AND <NOT ,STUDY-UNLOCKED> <IN? ,KEYRING ,WINNER>>
                  <SETG STUDY-UNLOCKED T>
                  <FSET ,STUDY-DOOR ,OPENBIT>
                  <TELL "The long warded key on Hudson's ring turns smoothly in the lock. You open the study door; the study lies [[north]]." CR>)
                 (<==? ,PRSI ,LOCKPICK-SET>
                  <TELL "The fine picks cannot turn this warded lock. Hudson has the study key." CR>)
                 (<NOT ,STUDY-UNLOCKED>
                  <TELL "The study door is locked. You'll need the study key; its deep wards are beyond any pick." CR>)
                 (T
                  <FSET ,STUDY-DOOR ,OPENBIT>
                  <TELL "You open the study door. The study lies [[north]]." CR>)>
           <RTRUE>)
          (<VERB? UNLOCK>
           <COND (,STUDY-UNLOCKED
                  <TELL "The study door is already unlocked." CR>)
                 (<AND <==? ,HERE ,STUDY> <NOT ,PRSI>>
                  <SETG STUDY-UNLOCKED T>
                  <TELL "You draw back the interior bolt. The study door is now unlocked." CR>)
                 (<==? ,PRSI ,KEYRING>
                  <SETG STUDY-UNLOCKED T>
                  <TELL "The study key turns smoothly in the lock. The study door is now unlocked." CR>)
                 (<==? ,PRSI ,LOCKPICK-SET>
                  <TELL "The fine picks cannot turn this warded lock. Hudson has the study key." CR>)
                 (T
                  <TELL "That does not fit the study door's lock." CR>)>
           <RTRUE>)
          (<VERB? BREAK ATTACK>
           <TELL "The door is solid oak. You'd need a battering ram." CR>
           <RTRUE>)>>

<ROUTINE BOOKSHELF-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Most books stand flush with the shelves. Four project a little: a [[red book]], a [[blue book]], a [[green book]], and a [[yellow book]], each marked with a ribbon." CR>
           <RTRUE>)
          (<VERB? PUSH>
           <COND (,CIPHER-SOLVED
                  <TELL "The shelves have already swung aside; the passage stands open to the [[east]]." CR>
                  <RTRUE>)
                 (T
                  <TELL "You push a book. Nothing happens. Perhaps there's an order to follow." CR>
                  <RTRUE>)>)>>

<ROUTINE READING-DESK-F ()
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "Loose papers cover the reading desk.">
           <COND (<AND <IN? ,TORN-PAGE ,LIBRARY> <NOT <FSET? ,TORN-PAGE ,TOUCHBIT>>> <TELL " A torn [[page]] is covered in handwritten notes.">)
                 (T <TELL " A clean rectangle shows where a page once lay.">)>
           <COND (<AND <IN? ,SECRET-LEDGER ,LIBRARY> <NOT <FSET? ,SECRET-LEDGER ,TOUCHBIT>>> <TELL " A leather-bound [[ledger]] lies open beside the papers.">)>
           <CRLF>
           <RTRUE>)>>

<ROUTINE TABLE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The dining table is set for two, but only one place was used. A skin has formed on Lady Ashworth's soup. Her untouched [[cutlery]] lies exactly parallel to her plate.">
           <COND (<AND <IN? ,WAX-SEAL ,HERE> <NOT <FSET? ,WAX-SEAL ,TOUCHBIT>>>
                  <TELL " A crimson [[wax seal->seal]] lies near the empty plate.">)>
           <TELL CR>
           <RTRUE>)>>

<ROUTINE WINE-CABINET-F ()
    <COND (<VERB? EXAMINE>
           <SETG CABINET-CLUE-SEEN T>
           <TELL "The cabinet is unlatched. Dust outlines a missing squat bottle on the medicinal-wine shelf; beside the gap, a handwritten [[inventory entry]] reads “tincture, private laboratory.” Someone removed the delivery bottle without disturbing the dinner wines." CR>
           <RTRUE>)
          (<VERB? OPEN>
           <FSET ,WINE-CABINET ,OPENBIT>
           <SETG CABINET-CLUE-SEEN T>
           <TELL "The glass door opens freely. The missing medicinal bottle's clean dust-shadow and the words “private laboratory” are easier to see, but the shelf holds nothing else relevant." CR>
           <RTRUE>)
          (<VERB? CLOSE>
           <COND (<FSET? ,WINE-CABINET ,OPENBIT>
                  <FCLEAR ,WINE-CABINET ,OPENBIT>
                  <TELL "You close the wine cabinet's glass door." CR>)
                 (T
                  <TELL "The wine cabinet is already closed." CR>)>
           <RTRUE>)
          (<VERB? UNLOCK>
           <TELL "There is no lock to solve; the glass door is merely closed." CR>
           <RTRUE>)>>

<ROUTINE POTS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Copper pots hang from the ceiling, tarnished with age." CR>
           <RTRUE>)>>

<ROUTINE HEARTH-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Soot darkens the lintel. Yesterday's ashes have settled into a pale crust." CR>
           <RTRUE>)>>

<ROUTINE SERVANT-BELL-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A servant bell hangs from the wall. A rope leads up to the servant's quarters." CR>
           <RTRUE>)
          (<VERB? MOVE USE>
           <TELL "You pull the bell rope. A distant bell rings upstairs." CR>
           <RTRUE>)>>

<ROUTINE KETTLE-F ()
    <COND (<VERB? DRINK DRINK-FROM>
		<TELL "A little strong tea warms your mouth and hands. Hudson has put in too much sugar. For a moment, no one in the house is asking you to prove anything." CR>
		<RTRUE>)
	(<VERB? EXAMINE READ>
           <TELL "The blue enamel kettle is still warm. Hudson has tied on a [[card->tea card]]: TEA FIRST. THEORIES AFTER. A little tea remains; you may drink it." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "The kettle belongs on the range; its warmth is more useful here than in your pocket." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Steam carries the clean tannic scent of strong black tea." CR>
           <RTRUE>)>>

<ROUTINE BELL-WIRE-F ()
    <COND (<VERB? EXAMINE>
           <COND (,BELL-WIRE-PULLED
                  <TELL "The servant-bell wire hangs slightly crooked after your tug. From below comes the faint clink of Hudson setting down a teacup." CR>)
                 (<==? ,CASE-ACT 1>
                  <TELL "The servant-bell wire is still beside the study door." CR>)
                 (T
                  <TELL "The servant-bell wire trembles where the hidden wall's movement disturbed it, a small physical echo of the secret route." CR>)>
           <RTRUE>)
          (<VERB? MOVE USE PULL>
           <SETG BELL-WIRE-PULLED T>
           <TELL "You tug the wire. From below comes one bright kitchen bell, followed by Hudson's dry voice: “The kettle remains where I left it.”" CR>
           <RTRUE>)>>

<ROUTINE DRAWER-F ()
    <COND (<VERB? EXAMINE>
           <COND (<NOT <FSET? ,DRAWER ,OPENBIT>> <TELL "The drawer is closed. A thumb-sized hollow under the lip serves as its handle." CR>)
                 (<IN? ,LEATHER-ROLL ,DRAWER> <TELL "A [[leather roll->roll]] fits snugly between the worn wooden runners." CR>)
                 (T <TELL "Two dark lines on the runners show where the leather roll used to rest." CR>)>
           <RTRUE>)
          (<AND <VERB? OPEN> <FSET? ,DRAWER ,OPENBIT>>
           <TELL "The drawer is already open." CR>
           <RTRUE>)
          (<VERB? OPEN>
           <TELL "You open the drawer.">
		   <COND (<IN? ,LEATHER-ROLL ,DRAWER>
				  <TELL " Inside is a [[leather roll->roll]].">)
				 (T <TELL " The wooden runners show where the leather roll rested.">)>
		   <CRLF>
           <FSET ,DRAWER ,OPENBIT>
           <RTRUE>)>>

<ROUTINE FOUNTAIN-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The fountain is dry, with tarnished [[coins]] at the bottom">
           <COND (<AND <IN? ,FOOTPRINT-CAST ,GARDEN> <NOT <FSET? ,FOOTPRINT-CAST ,TOUCHBIT>>>
                  <TELL ". A plaster [[cast->footprint cast]] rests on the rim">)>
           <TELL "." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "The empty basin smells of rainwater, old copper, and wet stone." CR>
           <RTRUE>)>>

"The knife waits INVISIBLE in the hedge until the hedge is examined, as Zork I
hides the grating under the leaves; the garden shows only a glint."

<ROUTINE HEDGES-F ()
    <COND (<VERB? EXAMINE SEARCH LOOK-INSIDE>
           <TELL "A single white [[rose]] has survived the rain in these overgrown branches">
           <COND (<AND <FSET? ,BLOOD-STAINED-KNIFE ,INVISIBLE> <IN? ,BLOOD-STAINED-KNIFE ,GARDEN>>
                  <FCLEAR ,BLOOD-STAINED-KNIFE ,INVISIBLE>
                  <THIS-IS-IT ,BLOOD-STAINED-KNIFE>
                  <TELL ". Deep in the branches something glints: a [[knife]], its blade dark with dried blood">)
                 (<IN? ,BLOOD-STAINED-KNIFE ,GARDEN>
                  <TELL ". The knife still hangs in its branches">)
                 (T
                  <TELL "; one cut branch still shows where the knife was lodged">)>
           <TELL "." CR>
           <RTRUE>)>>

<ROUTINE PLANTS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Exotic plants fill the greenhouse. One plant has distinctive purple flowers - wolfsbane." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Damp loam and bruised leaves nearly mask the peppery, numbing scent of the purple wolfsbane." CR>
           <RTRUE>)
          (<AND <VERB? USE-ON>
                <EQUAL? ,PRSO ,POISON-BOTTLE>>
           <IDENTIFY-POISON>
           <RTRUE>)>>

<ROUTINE LABELS-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "The curled labels on the [[purple flowers->flowers]] read “Aconitum - Wolfsbane.” A watering date in Hudson's handwriting is underlined twice." CR>
           ;"Reading the label with the bottle in hand is the comparison."
           <COND (<AND <NOT ,POISON-IDENTIFIED> <IN? ,POISON-BOTTLE ,WINNER>>
                  <IDENTIFY-POISON>)>
           <RTRUE>)>>

<ROUTINE BENCH-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Dry rings mark the potting bench where pots stood. Freshly cut purple stems lie in a shallow groove; the cut ends are clean, not torn." CR>
           <RTRUE>)>>

<ROUTINE BEDS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Clean linen covers each empty bed. The cloth is thin at the folds, but every tear has been mended." CR>
           <RTRUE>)>>

"The trunk keeps its note until it is opened or first looked into; once the
player has had the lid up, a closed trunk stays closed to a glance."

<ROUTINE TRUNK-F ()
    <COND (<AND <VERB? EXAMINE SEARCH LOOK-INSIDE OPEN> <IN? ,LANTERN ,SERVANTS-QUARTERS> <NOT <FSET? ,LANTERN ,TOUCHBIT>>>
           <TELL "An oil [[lantern]] hangs from one of the trunk handles. ">)>
    <COND (<AND <VERB? EXAMINE SEARCH LOOK-INSIDE>
                <NOT <FSET? ,TRUNK ,TOUCHBIT>>>
           <FSET ,TRUNK ,OPENBIT>
           <FSET ,TRUNK ,TOUCHBIT>
           <TELL "You lift the heavy lid. ">
           <RFALSE>)
          (<VERB? OPEN>
           <FSET ,TRUNK ,TOUCHBIT>
           <RFALSE>)>>

<ROUTINE TRUNK-LETTER-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "The letter is addressed to Mr. Hudson from an unknown sender. It reads:" CR>
           <TELL "The master's experiments have gone too far. If anything happens to me, the evidence is in the study. Burn this after reading." CR>
           <TELL "The signature is illegible." CR>
           <RTRUE>)>>

<ROUTINE UNIFORMS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Servant uniforms, their fabric worn from use." CR>
           <RTRUE>)>>

<ROUTINE SHELVES-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The shelves hold preserves and spices">
           <COND (<AND <IN? ,FOXGLOVE ,PANTRY> <NOT <FSET? ,FOXGLOVE ,TOUCHBIT>>>
                  <TELL ", dried [[foxglove]] with a poison warning">)>
           <COND (<AND <IN? ,CHARCOAL ,PANTRY> <NOT <FSET? ,CHARCOAL ,TOUCHBIT>>>
                  <TELL ", and powdered [[charcoal]] labeled for swallowed poisons">)>
           <TELL "." CR>
           <RTRUE>)>>

<ROUTINE FOXGLOVE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The foxglove label names digitalis and gives a narrow medicinal dose, followed by a skull: medicine at one dose, a stopped heart at another." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the foxglove." CR>
           <MOVE ,FOXGLOVE ,WINNER>
           <FSET ,FOXGLOVE ,TOUCHBIT>
           <FCLEAR ,FOXGLOVE ,NDESCBIT>
           <RTRUE>)
          (<VERB? USE TASTE>
           <TELL "The dosage warning is precise and the skull more persuasive. Experimenting on yourself would compound one poison with another." CR>
           <RTRUE>)>>

<ROUTINE CHARCOAL-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The powdered charcoal is labeled for immediate use after swallowed poisons. It can limit harm, not identify a culprit." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the charcoal." CR>
           <MOVE ,CHARCOAL ,WINNER>
           <FSET ,CHARCOAL ,TOUCHBIT>
           <FCLEAR ,CHARCOAL ,NDESCBIT>
           <RTRUE>)
          (<VERB? USE>
           <COND (<==? ,PLAYER-HEALTH 3>
                  <TELL "You have swallowed no poison. Save the charcoal for an actual emergency." CR>)
                 (T
                  <SETG PLAYER-HEALTH <+ ,PLAYER-HEALTH 1>>
                  <TELL "You swallow a measured spoonful with water. It tastes of soot, but the dizziness recedes and your pulse steadies." CR>)>
           <RTRUE>)>>

; --- Room Action Routines (Dynamic Descriptions) ---

<ROUTINE GATE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (<IN? ,TELEGRAM ,ASHWORTH-MANOR-GATE>
                   <TELL "Beyond the iron [[gates]], [[Ashworth Manor]] slips in and out of the [[fog]] at the end of the [[path]] [[north]]." CR>)
                  (T
                   <TELL "Beyond the open [[gate]], the wet [[path]] leads [[north]] to [[Ashworth Manor]]." CR>)>)>>

<ROUTINE STUDY-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "A chalk [[outline]] stretches from the [[fireplace]]">
           <COND (,LOCKED-BOX-OPENED <TELL ", where the name-dial [[box]] lies open among the cold [[ashes]]">
                  <COND (<AND <IN? ,BANK-STATEMENT ,LOCKED-BOX> <FSET? ,BANK-STATEMENT ,NDESCBIT>>
                         <TELL " with a [[bank statement->statement]] inside">)>
                  <TELL ",">)>
           <TELL " to the mahogany [[desk]]">
           <COND (<AND <FSET? ,DEAD-LETTER ,INVISIBLE> <IN? ,DEAD-LETTER ,STUDY>>
                  <TELL ", heaped with [[papers]].">)
                 (<AND <IN? ,DEAD-LETTER ,STUDY> <FSET? ,DEAD-LETTER ,NDESCBIT>>
                  <TELL ", where a yellowed [[envelope->letter]] lies uncovered.">)
                 (T <TELL ", its [[papers]] scattered.">)>
           <COND (<FSET? ,WINDOW ,OPENBIT>
                  <TELL " The garden [[window]] stands open [[southwest]]">)
                 (T
                  <TELL " The garden [[window]] to the southwest sticks shut">)>
           <COND (,CIPHER-SOLVED
		<TELL ", the fireplace passage leads [[down]]">)>
           <COND (<FSET? ,STUDY-DOOR ,OPENBIT>
                  <TELL ", and the hall [[door]] stands open [[south]].">)
                 (,STUDY-UNLOCKED
                  <TELL ", and the south [[door]] is closed but unlocked.">)
                 (T
                  <TELL ", and the south [[door]] is bolted.">)>
           <CRLF>)>>

<ROUTINE LIBRARY-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Lamplight catches the gilt [[titles]] on the [[bookshelves->bookshelf]] above the [[reading desk]]">
           <COND (<IN? ,DR-MORIARTY ,LIBRARY> <TELL " as [[Moriarty]] taps one [[spine]]">)>
           <TELL ".">
           <COND (,CIPHER-SOLVED
                  <TELL " Between the hall [[west]] and the passage [[east]], the bookcase stands open.">)
                 (T
                  <TELL " Colored [[ribbons]] mark the shelves nearest the hall [[west]].">)>
           <CRLF>)>>

<ROUTINE KITCHEN-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "A blue [[kettle]] steams beside the cold [[hearth]],">
           <COND (<FSET? ,DRAWER ,OPENBIT>
                  <TELL " the counter [[drawer]] open.">)
                 (T
                  <TELL " the counter [[drawer]] shut.">)>
           <TELL " The hall lies [[up]], the garden [[west]]." CR>)>>

<ROUTINE GARDEN-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (<AND <FSET? ,BLOOD-STAINED-KNIFE ,INVISIBLE> <IN? ,BLOOD-STAINED-KNIFE ,GARDEN>>
                  <TELL "Something glints deep in the [[hedges]] beside the dry [[fountain]].">)
                 (<AND <IN? ,BLOOD-STAINED-KNIFE ,GARDEN> <FSET? ,BLOOD-STAINED-KNIFE ,NDESCBIT>>
                  <TELL "A [[knife]] hangs in the parted [[hedges]] beside the dry [[fountain]].">)
                 (T <TELL "Rain beads on the overgrown [[hedges]] beside the dry [[fountain]].">)>
           <TELL " Paths lead [[east]] to the kitchen, [[north]] to the greenhouse and [[south]] to the servants' quarters">
           <COND (<FSET? ,WINDOW ,OPENBIT> <TELL ", with a way [[northeast]] through the open [[study window]]">)>
           <TELL "." CR>)>>

<ROUTINE DINING-ROOM-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (<EQUAL? ,CASE-ACT 3> <TELL "Lady [[Ashworth]] listens at the [[table]], her [[black ribbon]] beside her [[plate]].">)
                 (,LADY-CONFRONTED <TELL "Lady [[Ashworth]] sits at the [[table]], her [[wedding ring]] on the wood beside her [[plate]].">)
                 (T <TELL "Lady [[Ashworth]] sits alone at a [[table]] set for two.">)>
           <COND (,CABINET-CLUE-SEEN <TELL " Past the gap in the wine [[cabinet]]">)
                 (T <TELL " Past the wine [[cabinet]]">)>
           <TELL ", doors lead [[east]] to the hall and [[north]] to the pantry." CR>)>>

<ROUTINE GREENHOUSE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (,POISON-IDENTIFIED <TELL "On the potting [[bench]], the [[labels]] confirm your match for the purple [[flowers]].">)
                 (T <TELL "Damp [[labels]] curl beside purple [[flowers]] on the potting [[bench]].">)>
           <TELL " The garden lies [[south]]." CR>)>>

<ROUTINE SERVANTS-QUARTERS-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "Between the narrow [[beds]] and the [[trunk]],">
           <COND (<==? ,CASE-ACT 3>
                  <TELL " [[Hudson]] waits with his [[carpetbag]] packed.">)
                 (,HUDSON-CONFRONTED
                  <TELL " [[Hudson]] has set his polishing cloth aside.">)
                 (T
                  <TELL " [[Hudson]] keeps polishing the same [[spoon]].">)>
           <TELL " The garden lies [[north]]." CR>)>>

<ROUTINE SECRET-PASSAGE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "[[Cobwebs]] hang from damp [[stone walls]].">
           <COND (<AND <IN? ,LANTERN ,WINNER> <FSET? ,LANTERN ,ONBIT>>
                  <TELL " Your lantern picks out fresh [[heel marks->dust]] in the [[dust]]">)
                 (T <TELL " One [[trail->dust]] cuts the [[dust]]">)>
           <TELL " between the library [[west]] and the [[study steps]] [[up]].">
           <CRLF>)>>

<ROUTINE PANTRY-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "The [[shelves]] smell of [[apples]] and [[charcoal dust]]. The dining room lies [[south]]." CR>)>>

<ROUTINE ENTRANCE-HALL-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <COND (<EQUAL? ,CASE-ACT 2> <TELL "A [[bell wire]] quivers over the [[hall table]] beneath the [[chandelier]]">)
                 (T <TELL "The [[hall table]] gleams under the [[chandelier]]">)>
           <TELL " between the library [[east]], dining room [[west]], kitchen [[stairs]] [[down]] and gate [[south]].">
           <COND (<FSET? ,STUDY-DOOR ,OPENBIT>
                  <TELL " The study [[door]] stands open [[north]]">)
                 (,STUDY-UNLOCKED
                  <TELL " The north study [[door]] is closed but unlocked">)
                 (T
                  <TELL " The north study [[door]] is closed and locked">)>
           <COND (<AND ,INSPECTOR-PRESENT <IN? ,INSPECTOR ,ASHWORTH-ENTRANCE-HALL>>
                  <TELL " and [[Inspector Lestrade->lestrade]] has arrived">
                  <COND (<IN? ,DR-MORIARTY ,ASHWORTH-ENTRANCE-HALL> <TELL " and stands beside [[Moriarty]]">)>
                  <TELL ".">)
                 (<IN? ,DR-MORIARTY ,ASHWORTH-ENTRANCE-HALL> <TELL " while [[Moriarty]] waits at the front door.">)
                 (T <TELL ".">)>
           <CRLF>)>>

; --- Global Object Actions ---

<ROUTINE FOG-F ()
    <COND (<VERB? EXAMINE>
           <TELL "You hold a hand in the fog. Tiny drops gather on the hairs of your wrist before you feel them on your skin." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "The fog smells of river mud, coal smoke, and rain on iron." CR>
           <RTRUE>)>>

<ROUTINE GATES-F ()
    <COND (<VERB? OPEN RAISE> <TELL "The latch is rusted fast in its raised position. You can walk straight through the gates to the [[north]]." CR>)
          (<VERB? EXAMINE>
           <TELL "The iron gates bear the [[Ashworth crest->Ashworth crest]]. Their [[latch->iron gates]] has rusted in the raised position." CR>
           <RTRUE>)>>

<ROUTINE PATH-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The gravel path has been raked into [[fans->rake marks]]. One fan has been kicked flat outside the front door." CR>
           <RTRUE>)>>

<ROUTINE HALL-TABLE-F ()
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "Someone has polished the wood right down to the little key scratches.">
           <COND (<AND <IN? ,MAGNIFYING-GLASS ,ASHWORTH-ENTRANCE-HALL> <NOT <FSET? ,MAGNIFYING-GLASS ,TOUCHBIT>>>
                  <TELL " A brass [[magnifying glass->glass]] lies in a ring of dust at the back.">)>
           <CRLF>
           <RTRUE>)>>

<ROUTINE CHANDELIER-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A single [[clean crystal]] throws a fleck of light onto the hall table. The others wear little caps of dust." CR>
           <RTRUE>)>>

<ROUTINE PORTRAITS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Portraits of the Ashworth family line the walls. Their expressions are disapproving." CR>
           <RTRUE>)>>

<ROUTINE RUG-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A Persian rug covers the floor, its patterns faded but still elegant." CR>
           <RTRUE>)>>

<ROUTINE CHALK-OUTLINE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The chalk follows a body fallen face down. Three blood drops begin behind the shoulders. A chair leg has dragged a short [[furrow]] through the carpet toward the [[fireplace]].">
           <COND (<AND <IN? ,POISON-BOTTLE ,STUDY> <NOT <FSET? ,POISON-BOTTLE ,TOUCHBIT>>>
                  <TELL " Nothing in the outline explains the [[bottle]] on the mantelpiece.">)>
           <CRLF>
           <RTRUE>)>>

; === NPC ACTIONS ===

<ROUTINE MR-HUDSON-F ()
    <COND (<VERB? ACCUSE> <V-ACCUSE>)
          (<VERB? EXAMINE>
           <COND (<==? ,CASE-ACT 3>
                  <TELL "Mr. Hudson stands beside a packed carpetbag, coat buttoned wrong in his haste. He looks relieved to see that you noticed." CR>)
                 (,HUDSON-CONFRONTED
                  <TELL "Mr. Hudson has stopped polishing the same spoon. His hands are steady now, though he keeps the incriminating letter at arm's length." CR>)
                 (T
                  <TELL "Mr. Hudson polishes one silver spoon over and over; the cloth squeaks each time his hand tightens." CR>)>
           <RTRUE>)
          (<VERB? TELL>
           <COND (<NOT ,PRSI>
                  <TELL "Hudson folds his polishing cloth. “The [[master]], my [[alibi]], the study [[key]], or Dr. [[Moriarty]]? Ask what you need, sir.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,MASTER-TOPIC>
                  <TELL "Lord Ashworth had enemies, sir. Dr. Moriarty visited often, and their arguments grew worse." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,ALIBI-TOPIC>
                   <TELL "I was in the servants' quarters all evening. The other staff can confirm it." CR>
                   <COND (<NOT ,HUDSON-INTERVIEWED>
                          <SETG HUDSON-INTERVIEWED T>
                          <SETG SUSPECTS-INTERVIEWED <+ ,SUSPECTS-INTERVIEWED 1>>
                          <SCORE-UPD 5>
                          <CHECK-CASE-PROGRESS>)>
                   <RTRUE>)
                 (<EQUAL? ,PRSI ,KEY-TOPIC>
                  <COND (,HUDSON-KEY-GIVEN
				  <TELL "“The study key is on the [[keyring]] I gave you, sir.”" CR>)
				 (T
				  <TELL "“You'll need the study key, sir.” He hands you the [[keyring]]." CR>
				  <SETG HUDSON-KEY-GIVEN T>
				  <MOVE ,KEYRING ,WINNER>
				  <FSET ,KEYRING ,TOUCHBIT>)>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,MORIARTY-TOPIC>
                  <TELL "Dr. Moriarty visited often. He and the master had serious disagreements." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,CASE-TOPIC>
                  <TELL "“His lordship called it a private quarrel,” Hudson says. “Private quarrels do not usually leave poison bottles and policemen in the hall.”" CR>
                  <RTRUE>)
                 (<OR <IN? ,PRSI ,INTQUOTE> <IN? ,PRSI ,QUOTE>>
                  <TELL "I'm not sure what you mean." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,ROOMS>
                  <TELL "I'm in the servants' quarters." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,MR-HUDSON>
                  <TELL "Yes? What is it?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,LADY-ASHWORTH>
                  <TELL "Lady Ashworth? She was in the drawing room, I believe." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,DR-MORIARTY>
                  <TELL "Dr. Moriarty? He visited often. He and the master had... disagreements." CR>
                   <RTRUE>)
                 (<EQUAL? ,PRSI ,DEAD-LETTER>
                  <TELL "A letter? I know nothing of such things." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,BLOOD-STAINED-KNIFE>
                  <TELL "A knife? I don't recognize it." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,POISON-BOTTLE>
                  <TELL "Poison? I would never touch such things." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,KEYRING>
                  <COND (,HUDSON-KEY-GIVEN
                         <TELL "“The study key is the long one on that ring, sir. It is yours for as long as the inquiry needs it.”" CR>)
                        (T
                         <SETG HUDSON-KEY-GIVEN T>
                         <MOVE ,KEYRING ,WINNER>
                         <FSET ,KEYRING ,TOUCHBIT>
                         <TELL "“The keyring? I suppose you'll need this, sir.” He hands you the [[keyring]]." CR>)>
                  <RTRUE>)
                 (T
                  <TELL "“I don't know anything about that, sir,” says Hudson." CR>
                  <RTRUE>)>)
          (<VERB? SHOW GIVE>
           <COND (<EQUAL? ,PRSO ,DEAD-LETTER>
                  <COND (,HUDSON-CONFRONTED
                         <TELL "Hudson does not touch the letter again. “I remember the hour, sir. Nine twenty. And Moriarty on the stair behind me.”" CR>)
                        (T
                         <SETG HUDSON-CONFRONTED T>
                         <TELL "Mr. Hudson's polishing cloth goes still. “I carried that letter to the study,” he says. “Moriarty followed me upstairs. I kept silent because I feared I had delivered Lord Ashworth's death.”" CR>)>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,BLOOD-STAINED-KNIFE>
                  <TELL "Mr. Hudson recoils. “I've never seen that before.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,POISON-BOTTLE>
                  <TELL "Mr. Hudson's eyes widen. “Poison? I know nothing of poison.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,FOOTPRINT-CAST>
                  <TELL "Hudson sets his broad work boot beside the cast without being asked. “Not mine, sir. And the doctor's right heel always catches on the stair carpet.”" CR>
                  <RTRUE>)
                 (T
                  <TELL "Mr. Hudson examines the item. “I don't see how that's relevant.”" CR>
                  <RTRUE>)>)>>

<ROUTINE LADY-ASHWORTH-F ()
    <COND (<VERB? ACCUSE> <V-ACCUSE>)
          (<VERB? EXAMINE>
           <COND (<==? ,CASE-ACT 3>
                  <TELL "Lady Ashworth has removed the black ribbon from her throat and laid it beside the empty plate. She watches the hall, listening for Lestrade's boots." CR>)
                 (,LADY-CONFRONTED
                  <TELL "Lady Ashworth's untouched place setting has been pushed aside. One hand grips her wedding ring; the other is open on the table, no longer hiding its tremor." CR>)
                 (T
                  <TELL "Lady Ashworth sits before two place settings. Her soup has filmed over, and her untouched dinner [[cutlery]] remains precisely parallel to the plate." CR>)>
           <RTRUE>)
          (<VERB? TELL>
           <COND (<NOT ,PRSI>
                  <TELL "Lady Ashworth looks up. “My [[marriage]], my [[alibi]], or the [[murder->case]]? You may ask. I cannot promise you will like the answers.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,MARRIAGE-TOPIC>
                  <TELL "Our marriage was difficult, but I did not kill my husband." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,ALIBI-TOPIC>
                   <TELL "I was in the drawing room all evening. The servants saw me there." CR>
                   <SETG LADY-ALIBI-CLAIMED T>
                   <COND (<NOT ,LADY-INTERVIEWED>
                          <SETG LADY-INTERVIEWED T>
                          <SETG SUSPECTS-INTERVIEWED <+ ,SUSPECTS-INTERVIEWED 1>>
                          <SCORE-UPD 5>
                          <CHECK-CASE-PROGRESS>)>
                   <RTRUE>)
                 (<EQUAL? ,PRSI ,CASE-TOPIC>
                  <TELL "“Call it a case if that helps you keep your distance,” Lady Ashworth says. “To me it is my husband's murder. Find who crossed that locked door.”" CR>
                  <RTRUE>)
                 (<OR <IN? ,PRSI ,INTQUOTE> <IN? ,PRSI ,QUOTE>>
                  <TELL "I'm not sure what you mean." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,ROOMS>
                  <TELL "I was in the drawing room all evening." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,LADY-ASHWORTH>
                  <TELL "Yes? What is it?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,DR-MORIARTY>
                  <TELL "Dr. Moriarty was a frequent guest. My husband owed him money." CR>
                   <RTRUE>)
                 (<EQUAL? ,PRSI ,MR-HUDSON>
                  <TELL "Mr. Hudson? He's been with the household for years. Loyal, but nervous." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,DEAD-LETTER>
                  <TELL "A letter? Where did you get that?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,BLOOD-STAINED-KNIFE>
                  <TELL "A knife? I don't know anything about it." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,POISON-BOTTLE>
                  <TELL "Poison? I know nothing of such things." CR>
                  <RTRUE>)
                 (T
                  <TELL "“I don't know anything about that,” Lady Ashworth says." CR>
                  <RTRUE>)>)
          (<VERB? SHOW GIVE>
           <COND (<EQUAL? ,PRSO ,DEAD-LETTER>
                  <COND (,LADY-CONFRONTED
                         <TELL "Lady Ashworth presses one finger to the old fold. “The first draft named the laboratory account as well. I remember the sum: five hundred pounds.”" CR>)
                        (T
                         <SETG LADY-CONFRONTED T>
                         <TELL "Lady Ashworth reads the threat twice. The paper rattles against her ring. “My husband meant to expose Moriarty tonight,” she says. “I burned the first draft. I could not burn this one.”" CR>)>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,BLOOD-STAINED-KNIFE>
                  <TELL "Lady Ashworth recoils. “I've never seen that before.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,POISON-BOTTLE>
                  <TELL "Lady Ashworth's eyes widen. “Poison? I know nothing of poison.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,WAX-SEAL>
                  <TELL "Lady Ashworth turns the seal toward the light. “Moriarty sealed every private delivery with that mark. My husband hated the theatricality of it.”" CR>
                  <RTRUE>)
                 (T
                  <TELL "Lady Ashworth examines the item. “I don't see how that's relevant.”" CR>
                  <RTRUE>)>)>>

<ROUTINE DR-MORIARTY-F ()
    <COND (<VERB? ACCUSE> <V-ACCUSE>)
          (<VERB? EXAMINE>
          <COND (<==? ,CASE-ACT 3>
                  <COND (,FOOTPRINT-DETAIL-FOUND
                         <TELL "Dr. Moriarty has abandoned the library for the front door. Mud freckles his polished boots; the crescent nick in his right heel matches the detail you found in the garden cast." CR>)
                        (T
                         <TELL "Dr. Moriarty has abandoned the library for the front door. Mud freckles his polished size-ten boots, and he keeps the right heel turned away from you." CR>)>)
                 (,MORIARTY-CONFRONTED
                  <TELL "A crescent of sweat darkens Dr. Moriarty's collar. His gloved right hand stays in his coat pocket while his eyes count the doors." CR>)
                 (T
                  <TELL "Dr. Moriarty stands by the scientific folios, one immaculate fingernail tapping a steady four-beat rhythm." CR>)>
           <RTRUE>)
          (<VERB? TELL>
           <COND (<NOT ,PRSI>
                  <TELL "Moriarty closes the folio. “My [[experiments]]? Or have you come to ask about [[poison]]?” The second word comes rather more sharply." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,EXPERIMENTS-TOPIC>
                  <TELL "My experiments concern medicinal plants. Lord Ashworth financed some of the work." CR>
                  <RTRUE>)
                 (<OR <EQUAL? ,PRSI ,POISON-TOPIC>
                      <EQUAL? ,PRSI ,POISON-BOTTLE>>
                   <TELL "Wolfsbane? Aconitum? I keep some for research. That proves nothing." CR>
                   <COND (<IN? ,DR-MORIARTY ,LIBRARY>
                          <TELL "He shuts the folio, sets it square on its shelf, and walks out to the entrance hall, where he stands with one eye on the front door." CR>)>
                   <SETG MORIARTY-POISON-KNOWN T>
                   <SETG MORIARTY-CONFRONTED T>
                   <COND (<NOT ,MORIARTY-INTERVIEWED>
                          <SETG MORIARTY-INTERVIEWED T>
                          <SETG SUSPECTS-INTERVIEWED <+ ,SUSPECTS-INTERVIEWED 1>>
                          <SCORE-UPD 5>
                          <CHECK-CASE-PROGRESS>)>
                  <MOVE ,DR-MORIARTY ,ASHWORTH-ENTRANCE-HALL>
                  <RTRUE>)
                 (<OR <IN? ,PRSI ,INTQUOTE> <IN? ,PRSI ,QUOTE>>
                  <TELL "I'm not sure what you mean." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,ROOMS>
                  <TELL "I was at my laboratory all evening. Ask my assistant." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,DR-MORIARTY>
                  <TELL "Yes? What is it?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,LADY-ASHWORTH>
                  <TELL "Lady Ashworth? She's a fine woman, trapped in a difficult marriage." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,MR-HUDSON>
                  <TELL "Mr. Hudson? He's a servant. What about him?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,DEAD-LETTER>
                  <TELL "A letter? I don't know anything about it." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,BLOOD-STAINED-KNIFE>
                  <TELL "A knife? I use surgical tools in my work. That's not one of them." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,POISON-BOTTLE>
                  <TELL "Wolfsbane? Aconitum? I have some in my greenhouse. For research." CR>
                   <SETG MORIARTY-POISON-KNOWN T>
                   <RTRUE>)
                 (<EQUAL? ,PRSI ,SECRET-LEDGER>
                  <TELL "A ledger? I don't know what you're talking about." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,BANK-STATEMENT>
                  <TELL "A bank statement? That's private information." CR>
                  <RTRUE>)
                 (T
                  <TELL "“I don't know anything about that,” says Moriarty, with thin patience." CR>
                  <RTRUE>)>)
          (<VERB? SHOW GIVE>
           <COND (<EQUAL? ,PRSO ,DEAD-LETTER>
                  <COND (,MORIARTY-CONFRONTED
                         <TELL "Moriarty refuses the letter. “You have already performed that trick.” His eyes still return to the signature." CR>)
                        (T
                         <SETG MORIARTY-CONFRONTED T>
                         <TELL "Dr. Moriarty reads only the first line before folding the letter along its old crease. “Blackmail,” he says too quickly, before asking where you found it." CR>)>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,BLOOD-STAINED-KNIFE>
                  <TELL "Dr. Moriarty recoils. “I've never seen that before.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,POISON-BOTTLE>
                  <TELL "Dr. Moriarty's eyes widen. “That's my research. How did you get it?”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,SECRET-LEDGER>
                  <TELL "Dr. Moriarty reads the ledger. “Where did you find that?”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,BANK-STATEMENT>
                  <TELL "Dr. Moriarty reads the statement. “That's private information!”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,FOOTPRINT-CAST>
                  <COND (,FOOTPRINT-DETAIL-FOUND
                         <TELL "Moriarty glances at the crescent nick in the cast, then slides his right boot behind the left. “Plaster shrinks,” he says. You had not mentioned the defect." CR>)
                        (T
                         <TELL "Moriarty looks from the size-ten cast to his own polished boots. “A common size,” he says, keeping his right heel flat to the floor." CR>)>
                  <RTRUE>)
                 (T
                  <TELL "Dr. Moriarty examines the item. “I don't see how that's relevant.”" CR>
                  <RTRUE>)>)>>

<ROUTINE INSPECTOR-F ()
    <COND (<VERB? EXAMINE>
           <COND (<AND ,LETTER-PRESENTED ,POISON-PRESENTED ,MOTIVE-PRESENTED>
                  <TELL "Inspector Lestrade has filled three pages of his notebook. His pencil now rests beneath the words THREAT, METHOD, and MOTIVE." CR>)
                 (<OR ,LETTER-PRESENTED ,POISON-PRESENTED ,MOTIVE-PRESENTED>
                  <TELL "Inspector Lestrade has begun a chain of evidence across one notebook page, leaving deliberate gaps for what you have not yet proved." CR>)
                 (T
                  <TELL "Inspector Lestrade stands beneath the chandelier with rain silvering his shoulders. His notebook is open to a clean page." CR>)>
           <RTRUE>)
          (<VERB? TELL>
           <COND (<NOT ,PRSI>
                  <TELL "“Ask me about the [[case]],” says Lestrade. “Then show me what you can prove.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,CASE-TOPIC>
                  <TELL "Give me the case as a chain, not a sack of objects: show me the threat, the method, and the motive. Then accuse your suspect and choose which proof leads the charge." CR>
                  <RTRUE>)
                 (<OR <IN? ,PRSI ,INTQUOTE> <IN? ,PRSI ,QUOTE>>
                  <TELL "I'm not sure what you mean." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,ROOMS>
                  <TELL "What have you found, detective?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,INSPECTOR>
                  <TELL "Yes? What is it?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,DR-MORIARTY>
                  <TELL "Dr. Moriarty? A respected scientist. You'll need strong evidence." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,LADY-ASHWORTH>
                  <TELL "Lady Ashworth? She has an alibi. What evidence do you have?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,MR-HUDSON>
                  <TELL "Mr. Hudson? He was in the servants' quarters. What evidence do you have?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,DEAD-LETTER>
                  <TELL "A letter? Let me see it." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,BLOOD-STAINED-KNIFE>
                  <TELL "A knife? Let me see it." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,POISON-BOTTLE ,POISON-TOPIC>
                  <TELL "Poison? Let me see it." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,SECRET-LEDGER>
                  <TELL "A ledger? Let me see it." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,BANK-STATEMENT>
                  <TELL "A bank statement? Let me see it." CR>
                  <RTRUE>)
                 (T
                  <TELL "“I don't know anything about that,” says Lestrade. “Show me what you can prove.”" CR>
                  <RTRUE>)>)
          (<VERB? SHOW GIVE>
           <COND (<EQUAL? ,PRSO ,DEAD-LETTER>
                  <SETG LETTER-PRESENTED T>
                  <TELL "The inspector reads Ashworth's threat and underlines Moriarty's name. “Intent and opportunity to silence him. That is the first link.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,BLOOD-STAINED-KNIFE>
                  <TELL "The inspector examines the knife. “The surgeon's blade fits the wound. The engraved M is a lead, but a monogram alone will not secure a conviction.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,POISON-BOTTLE>
                  <SETG POISON-PRESENTED T>
                  <TELL "The inspector compares the wolfsbane label with your greenhouse notes. “Wolfsbane, which he admits keeping. It could have weakened Ashworth before the blade struck; the secret stair explains access without the hall door. The second link.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,SECRET-LEDGER>
                  <TELL "The inspector reads the ledger. “The ledger establishes the debt. Now connect it to the threat and the poison.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,BANK-STATEMENT>
                  <SETG MOTIVE-PRESENTED T>
                  <TELL "The inspector lays the statement beside the secret ledger. “The same five hundred pounds in both records. Debt and blackmail: motive. The chain is complete.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSO ,FOOTPRINT-CAST>
                  <COND (,FOOTPRINT-DETAIL-FOUND
                         <TELL "Lestrade compares the cast with Moriarty's right boot. The two crescent nicks meet edge for edge. “Route evidence,” he says, drawing a line from GARDEN to STUDY." CR>)
                        (T
                         <TELL "Lestrade measures the cast. “Size ten narrows matters, but inspect the wear before you call it individual evidence.”" CR>)>
                  <RTRUE>)
                 (T
                  <TELL "The inspector examines the item. “I don't see how that's relevant.”" CR>
                  <RTRUE>)>)>>

; === VERB ACTIONS ===

<ROUTINE V-TAKE ()
    <COND (<FSET? ,PRSO ,TAKEBIT>
           <MOVE ,PRSO ,WINNER>
           <FCLEAR ,PRSO ,NDESCBIT>
           <FSET ,PRSO ,TOUCHBIT>
           <TELL "You take the " D ,PRSO "." CR>
           <RTRUE>)
          (T
           <TELL "You can't take that." CR>
           <RTRUE>)>>

<ROUTINE V-DROP ()
    <COND (<IN? ,PRSO ,WINNER>
           <MOVE ,PRSO ,HERE>
           <TELL "You drop the " D ,PRSO "." CR>
           <RTRUE>)
          (T
           <TELL "You don't have that." CR>
           <RTRUE>)>>

<ROUTINE V-USE ()
    <TELL "You can't use that here." CR>
    <RTRUE>>

<ROUTINE V-USE-ON ()
    <TELL "You try it, but nothing useful comes of it." CR>
    <RTRUE>>

<ROUTINE V-EAT ()
    <COND (<EQUAL? ,PRSO ,POISON-BOTTLE>
           <TELL "A bitter trace touches your tongue. Your vision swims and your pulse stumbles; perhaps that wasn't wise." CR>
           <SETG PLAYER-HEALTH <- ,PLAYER-HEALTH 1>>
           <COND (<==? ,PLAYER-HEALTH 0>
                  <TELL "You collapse. Everything goes dark." CR>
                  <SETG GAME-LOST T>
                  <SETG GAME-ENDED T>
                  <FINISH>)>
           <RTRUE>)
          (T
           <TELL "Tasting the " D ,PRSO " would tell you nothing useful." CR>
           <RTRUE>)>>

<ROUTINE V-SHOW ()
    <TELL "The " D ,PRSI " doesn't seem interested." CR>
    <RTRUE>>

<ROUTINE V-OPEN ()
    <COND (<OR <FSET? ,PRSO ,CONTBIT>
               <FSET? ,PRSO ,DOORBIT>>
           <COND (<FSET? ,PRSO ,OPENBIT>
                  <TELL "The " D ,PRSO " is already open." CR>)
                 (T
                  <FSET ,PRSO ,OPENBIT>
                  <TELL "You open the " D ,PRSO "." CR>
                  <COND (<FSET? ,PRSO ,CONTBIT>
                         <V-LOOK-INSIDE>)>)>
           <RTRUE>)
          (T
           <TELL "You can't open that." CR>
           <RTRUE>)>>

<ROUTINE V-CLOSE ()
    <COND (<OR <FSET? ,PRSO ,CONTBIT>
               <FSET? ,PRSO ,DOORBIT>>
           <COND (<FSET? ,PRSO ,OPENBIT>
                  <FCLEAR ,PRSO ,OPENBIT>
                  <TELL "You close the " D ,PRSO "." CR>)
                 (T
                  <TELL "The " D ,PRSO " is already closed." CR>)>
           <RTRUE>)
          (T
           <TELL "You can't close that." CR>
           <RTRUE>)>>

<ROUTINE V-ACCUSE ()
    <COND (<EQUAL? ,PRSO ,DR-MORIARTY>
           <COND (<NOT ,INSPECTOR-PRESENT>
                  <TELL "An accusation with no officer to hear it is only theatre. Finish the interviews and gather a coherent case; Lestrade will come." CR>
                  <RTRUE>)
                 (<NOT <AND ,LETTER-PRESENTED ,POISON-PRESENTED ,MOTIVE-PRESENTED>>
                  <TELL "Lestrade closes his notebook. “You have discoveries, but not yet an argument. Show me the threat, the poison, and the financial motive.”" CR>
                  <RTRUE>)
                 (<NOT ,PRSI>
                  <TELL "Lestrade nods toward your evidence. “Which proof leads the charge? Accuse him with the unsent letter for Ashworth's own voice, or with the poison bottle for the physical case.”" CR>
                  <RTRUE>)
                 (<OR <EQUAL? ,PRSI ,DEAD-LETTER>
                      <EQUAL? ,PRSI ,POISON-BOTTLE>>
                  <COND (<EQUAL? ,PRSI ,DEAD-LETTER>
                         <TELL "You lead with Ashworth's unsent letter. Moriarty calls it a forgery; then Hudson quietly repeats the hour he delivered it and Lady Ashworth supplies the missing first draft." CR>)
                        (T
                         <TELL "You lead with the wolfsbane. Moriarty names its precise concentration before Lestrade has uncorked it. The accidental confession leaves the hall very still." CR>)>
                  <TELL CR "You lay out the sequence: wolfsbane to weaken Ashworth, the narrow blade from behind, then escape by the hidden stair while the hall door remained bolted. The bottle and flowers establish the drug; the ledger and concealed bank statement establish the debt Ashworth threatened to expose.">
                  <COND (,FOOTPRINT-DETAIL-FOUND
                         <TELL " The crescent nick you found under the magnifying glass fits Moriarty's right heel; the surgical knife and his attempt to reach the door complete the route.">)
                        (T
                         <TELL " The size-ten footprint, the surgical knife, and his attempt to reach the door complete the route.">)>
                  <COND (<IN? ,WAX-SEAL ,WINNER>
                         <TELL " The wax seal ties the private delivery to Moriarty's mark.">)>
                  <COND (<IN? ,TRUNK-LETTER ,WINNER>
                         <TELL " The servant's hidden warning shows that the locked-room deception was feared before the murder.">)>
                  <COND (<AND <IN? ,FOXGLOVE ,WINNER> <IN? ,CHARCOAL ,WINNER>>
                         <TELL " Your pantry finds distinguish dangerous medicine from the specific wolfsbane method.">)>
                  <CRLF>
                  <TELL CR "“Dr. Moriarty,” Lestrade says, closing one cuff around the gloved wrist, “you are under arrest for the murder of Lord Ashworth.”" CR>
                  <SETG KILLER-ACCUSED T>
                  <SETG CORRECT-ACCUSATION T>
                  <SETG GAME-WON T>
                  <SETG GAME-ENDED T>
                  <TELL CR "At dawn, the fog lifts enough to show ships moving on the Thames. Hudson brings tea for four without being asked. Lady Ashworth will testify; Lestrade offers you the next impossible file before the carriage has even taken Moriarty away." CR>
                  <TELL CR "THE LIMEHOUSE KILLINGS -- SOLVED" CR>
                  <FINISH>)
                 (T
                  <TELL "That may be evidence, but it does not make the clearest opening proof. Choose the letter or the poison." CR>
                  <RTRUE>)>)
          (<EQUAL? ,PRSO ,LADY-ASHWORTH>
           <TELL "Lady Ashworth has an alibi. The evidence doesn't match." CR>
           <SETG WRONG-ATTEMPTS <+ ,WRONG-ATTEMPTS 1>>
           <RTRUE>)
           (<EQUAL? ,PRSO ,MR-HUDSON>
            <TELL "Mr. Hudson was in the servants' quarters. The knife isn't his." CR>
            <SETG WRONG-ATTEMPTS <+ ,WRONG-ATTEMPTS 1>>
            <RTRUE>)
           (<EQUAL? ,PRSO ,MORIARTY-TOPIC>
            <TELL "Dr. Moriarty is not here." CR>
            <RTRUE>)
           (T
           <TELL "You must name a specific suspect." CR>
           <RTRUE>)>>

<ROUTINE V-INVENTORY ()
    <TELL "You are carrying:" CR>
    <COND (<FIRST? ,WINNER>
           <PRINT-CONTENTS ,WINNER>
           <RTRUE>)
          (T
           <TELL "  nothing." CR>
           <RTRUE>)>>

<ROUTINE V-SCORE ("OPTIONAL" (ASK? T))
    <TELL "Score: " N ,SCORE " of " N ,SCORE-MAX " points, in " N ,MOVES>
    <COND (<1? ,MOVES> <TELL " move.">) (T <TELL " moves.">)>
    <CRLF>
    <TELL "Rank: " <GET ,RANKINGS <+ </ ,SCORE 15> 1>> "." CR>
    <TELL "Evidence: " N ,EVIDENCE-FOUND " of 5. Suspects: " N ,SUSPECTS-INTERVIEWED " of 3." CR>
    ,SCORE>

<ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)
     <COND (<NOT <FSET? .OBJ ,TOUCHBIT>>
           <COND (<G? <SET TEMP <GETP .OBJ ,P?VALUE>> 0>
                 <SCORE-UPD .TEMP>
                 <PUTP .OBJ ,P?VALUE 0>
                 <FSET .OBJ ,TOUCHBIT>)>)>>

<ROUTINE V-HINTS ()
    <COND (<NOT ,STUDY-UNLOCKED>
           <TELL "Hint: Mr. Hudson may know how to open the study." CR>)
          (<NOT ,CIPHER-SOLVED>
           <TELL "Hint: compare the torn page with the colored markers in the library." CR>)
          (<NOT ,POISON-IDENTIFIED>
           <TELL "Hint: compare the poison bottle with the labeled greenhouse plants." CR>)
          (T
           <TELL "Hint: gather the evidence, interview every suspect, and report to Inspector Lestrade." CR>)>
    <RTRUE>>

; === HELPER ROUTINES ===

<ROUTINE PRINT-CONTENTS (OBJ)
    <COND (<FIRST? OBJ>
           <PRINT-ITEMS <FIRST? OBJ>>
           <RTRUE>)
          (T
           <TELL "  nothing." CR>
           <RTRUE>)>>

<ROUTINE PRINT-ITEMS (ITEM)
    <COND (<NOT .ITEM> <RTRUE>)
          (T
           <TELL "  " D .ITEM CR>
           <PRINT-ITEMS <NEXT? .ITEM>>)>>

; === GLOBAL OBJECT ACTIONS ===

<OBJECT INTQUOTE
      (IN GLOBAL-OBJECTS)
      (DESC "quotation")
      (SYNONYM QUOTE QUOTATION)
      (FLAGS ARTICLEBIT)>

<OBJECT QUOTE
      (IN GLOBAL-OBJECTS)
      (DESC "quotation")
      (SYNONYM QUOTATION)
      (FLAGS ARTICLEBIT)>

; === PUZZLE LOGIC ===

<ROUTINE SOLVE-CIPHER ()
    <COND (<AND <IN? ,TORN-PAGE ,WINNER>
                <==? ,HERE ,LIBRARY>>
           <TELL "The blue book settles with a final click. A section of shelving slides aside, opening a stone passage to the [[east]]." CR>
           <SETG CIPHER-SOLVED T>
           <SETG SECRET-PASSAGE-FOUND T>
           <SETG SECRET-PASSAGE-OPEN T>
           <SETG CASE-ACT 2>
           <TELL CR "Somewhere in the manor a bell wire trembles. Behind the books, a draught reaches you from the study. A hidden stair offers another way into the room." CR>
           <RTRUE>)
          (T
           <TELL "You need the torn page and colored markers to solve the cipher." CR>
           <RTRUE>)>>

<ROUTINE IDENTIFY-POISON ()
    <COND (<AND ,POISON-IDENTIFIED
                <IN? ,POISON-BOTTLE ,WINNER>
                <IN? ,PLANTS ,HERE>>
           <TELL "You match the poison bottle label to the wolfsbane once more. The two names still agree, and still say nothing of who administered it." CR>
           <RTRUE>)
          (<AND <IN? ,POISON-BOTTLE ,WINNER>
                <IN? ,PLANTS ,HERE>>
           <TELL "You match the poison bottle label to the wolfsbane plant. The bottle and greenhouse label name the same plant. That identifies the substance; it does not establish who administered it." CR>
           <SETG POISON-IDENTIFIED T>
           <CHECK-CASE-PROGRESS>
           <RTRUE>)
          (T
           <TELL "You need the poison bottle and access to the greenhouse to identify the poison." CR>
           <RTRUE>)>>

<ROUTINE CHECK-CASE-PROGRESS ()
    <COND (<AND <G? ,EVIDENCE-FOUND 2>
                <==? ,SUSPECTS-INTERVIEWED 3>
                <NOT ,INSPECTOR-PRESENT>>
           <SETG CASE-ACT 3>
           <FCLEAR ,HUDSON-BAG ,INVISIBLE>
           <FCLEAR ,MOURNING-RIBBON ,INVISIBLE>
           <SETG INSPECTOR-PRESENT T>
           <MOVE ,INSPECTOR ,ASHWORTH-ENTRANCE-HALL>
           <TELL CR "From the entrance hall comes the slam of the outer door and Lestrade's clipped voice. Scotland Yard has arrived. Around the manor, private masks begin to slip." CR>)>
    <RTRUE>>

; === GAME ENTRY ===

<SYNTAX USE OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-USE>
<SYNTAX USE OBJECT (HELD CARRIED ON-GROUND IN-ROOM) ON OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-USE-ON>
<SYNTAX SHOW OBJECT (HAVE) TO OBJECT (FIND ACTORBIT) (IN-ROOM) = V-SHOW>
<SYNTAX ALIGN OBJECT (FIND TURNBIT) (ON-GROUND IN-ROOM) TO OBJECT = V-ALIGN>
<SYNTAX HINTS = V-HINTS>
<SYNONYM HINTS HINT>
<SYNTAX ACCUSE OBJECT (FIND ACTORBIT) (IN-ROOM) = V-ACCUSE>
<SYNTAX ACCUSE OBJECT (FIND ACTORBIT) (IN-ROOM) WITH OBJECT (HAVE) = V-ACCUSE>
<SYNTAX LOOK AT OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-EXAMINE>
<SYNTAX SEARCH OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-EXAMINE>
<SYNTAX PULL OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-LIMEHOUSE-MOVE>
<SYNTAX LISTEN = V-LISTEN-AROUND>
<SYNTAX HEAR = V-LISTEN-AROUND>
<SYNONYM HEAR LISTEN>
<SYNTAX SMELL = V-SMELL-AROUND>

<ROUTINE PRE-LIMEHOUSE-MOVE ()
    <COND (<OR <EQUAL? ,PRSO ,BELL-WIRE>
               <EQUAL? ,PRSO ,SERVANT-BELL>>
           <RFALSE>)
          (<HELD? ,PRSO>
           <TELL "You aren't an accomplished enough juggler." CR>
           <RTRUE>)
          (T
           <TELL "You can't see any wire here." CR>
           <RTRUE>)>>

<ROUTINE V-LISTEN-AROUND ()
    <COND (<EQUAL? ,HERE ,ASHWORTH-MANOR-GATE>
           <TELL "The Thames sounds close but invisible: water against pilings, a ship's bell, wheels hissing on wet streets." CR>)
          (<EQUAL? ,HERE ,KITCHEN>
           <TELL "The kettle murmurs on the range; above it, the servant bells are still." CR>)
          (<EQUAL? ,HERE ,GARDEN ,GREENHOUSE>
           <TELL "Rain ticks on leaves and greenhouse glass. Somewhere beyond the wall, Limehouse traffic passes." CR>)
          (T
           <TELL "The manor answers with settling timber, distant rain, and the faint scrape of someone trying not to be heard." CR>)>
    <RTRUE>>

<ROUTINE V-SMELL-AROUND ()
    <COND (<EQUAL? ,HERE ,ASHWORTH-MANOR-GATE>
           <TELL "River fog, coal smoke, and wet iron." CR>)
          (<EQUAL? ,HERE ,KITCHEN>
           <TELL "Black tea, cold ash, and copper warmed by the range." CR>)
          (<EQUAL? ,HERE ,GREENHOUSE>
           <TELL "Wet earth, crushed leaves, and the sharp medicinal trace of wolfsbane." CR>)
          (T
           <TELL "Beeswax, old oak, and damp wool: a lived-in house holding its breath." CR>)>
    <RTRUE>>

<ROUTINE GO ()
	<SETG COMPACT-ROOM-LISTS T>
	<SETG HERE ,ASHWORTH-MANOR-GATE>
	<SETG VERBOSE T>
	<SETG LIT T>
	<SETG WINNER ,ADVENTURER>
	<SETG PLAYER ,WINNER>
	<VOC "SET" OBJECT>
	<VOC "CAST" OBJECT>
	<VOC-EXACT "INSPECTOR" "OFFICER">
	<VOC-EXACT "MURDER" "CASE">
	<VOC-EXACT "INVESTIGATION" "CASE">
	<MOVE ,WINNER ,HERE>
	<V-LOOK>
	<MAIN-LOOP>>

<ROUTINE DUST-F ()
	<COND (<OR <VERB? EXAMINE SEARCH>
			<AND <VERB? USE-ON> <EQUAL? ,PRSO ,MAGNIFYING-GLASS>>>
		<COND (<NOT <AND <HELD? ,LANTERN> <FSET? ,LANTERN ,ONBIT>>>
			<TELL "A broad scuff crosses the dust, but the floor is too dim for its direction to show. Bring a lit lantern close to it." CR>)
			(<AND <VERB? USE-ON> <EQUAL? ,PRSO ,MAGNIFYING-GLASS>>
			<TELL "The scuff has no clean heel edge to magnify. The [[footprint cast]] in the garden preserves that sort of detail; this dust records direction alone." CR>)
			(T <TELL "Held low, the lantern shows dust banked against the stair risers: someone hurried toward the study, then brushed back through the same narrow way. Overlapping scuffs conceal the size of the boots." CR>)>
		<RTRUE>)>>

<ROUTINE STONE-WALLS-F ()
	<COND (<VERB? CLIMB-FOO CLIMB-UP> <DO-WALK ,P?UP>)
          (<VERB? EXAMINE>
		<TELL "Water has bleached the mortar in long vertical runs. The stair rises inside the chimney breast; from the library, a person could reach the study without entering the hall." CR>
		<RTRUE>)>>

<ROUTINE COBWEBS-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Webs remain in the high corners. At shoulder height, torn strands cling to the stone on both sides of the passage." CR>
		<RTRUE>)>>

<ROUTINE PLACE-SETTINGS-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Both places have the same heavy, blunt dinner cutlery. None has the fine point or narrow edge of a surgeon's blade. Lady Ashworth has not lifted her spoon; the soup beneath it has filmed over." CR>
		<RTRUE>)
		(<VERB? TAKE>
		<TELL "You leave the place settings as they are. Their blunt edges rule out a table knife; moving them would establish nothing further." CR>
		<RTRUE>)>>

<ROUTINE WHITE-ROSE-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Rain has bent the stem without breaking it. The outer petals are brown at the edges; the tightly folded centre is still white." CR>
		<RTRUE>)
		(<VERB? TAKE>
		<TELL "You leave it on the stem. It has survived enough handling by the weather." CR>
		<RTRUE>)>>

<ROUTINE CONVERSATION-TOPIC-F ("AUX" WHO)
	<COND (<VERB? EXAMINE>
		<COND (<AND <EQUAL? ,HERE ,STUDY>
			    <EQUAL? ,PRSO ,MORIARTY-TOPIC ,HUDSON-NAME ,ASHWORTH-NAME>>
			<COND (<EQUAL? ,PRSO ,MORIARTY-TOPIC> <COND (,DEAD-LETTER-FOUND <TELL "Moriarty is the scientist Ashworth meant to expose. His name is also one of the three on the box dial." CR>)
                                     (T <TELL "Moriarty’s name runs all the way round the curve of the dial. The final Y is squeezed against the stop." CR>)>)
                              (<EQUAL? ,PRSO ,HUDSON-NAME> <TELL "Hudson is the butler. His name takes up the shortest stretch of the dial." CR>)
                              (T <TELL "Lady Ashworth’s name is on the dial in full. The engraver took care to fit her title on the same line." CR>)>)
		      (<SET WHO <WITNESS-HERE>>
			<TELL "That is a question to put to " D .WHO ", not a thing to inspect. The answer may be less straightforward than the question." CR>)
		      (T
			<TELL "That is a question for a witness, not a thing to inspect. Put it to someone who was in the house that night." CR>)>
		<RTRUE>)>>

"The person in this room a question can be put to, if anyone is here."

<ROUTINE WITNESS-HERE ("AUX" O)
	<SET O <FIRST? ,HERE>>
	<REPEAT ()
		<COND (<NOT .O> <RFALSE>)
		      (<AND <FSET? .O ,ACTORBIT> <NOT <EQUAL? .O ,WINNER>>>
		       <RETURN .O>)>
		<SET O <NEXT? .O>>>>

<ROUTINE V-ALIGN ()
	<TELL "There is nothing on the " D ,PRSO " to align." CR>
	<RTRUE>>

<ROUTINE RING-DETAIL ()
    <COND (<VERB? EXAMINE>
           <COND (,LADY-CONFRONTED <TELL "A pale band circles Lady Ashworth’s finger. The ring leaves a little arc in the dust each time she nudges it." CR>)
                 (T <TELL "Her thumb keeps turning the gold band round her finger, even when she folds her hands." CR>)>)>>

<ROUTINE DETAIL-INVENTORY-ENTRY-F ()
    <COND (<VERB? READ> <SETG CABINET-CLUE-SEEN T> <TELL "In pencil beside the missing bottle: ‘tincture, private laboratory.’" CR>)>>

<ROUTINE DETAIL-TEA-CARD-F ()
    <COND (<VERB? READ> <TELL "TEA FIRST. THEORIES AFTER." CR>)>>

<ROUTINE OUTSIDE-WINDOW-F ()
    <COND (<VERB? OPEN>
           <COND (<FSET? ,WINDOW ,OPENBIT> <TELL "The window is already open. You can step over the sill into the study." CR>)
                 (T <TELL "You press the sash. The rusty catch holds it shut on the study side." CR>)>)>>

<ROUTINE KITCHEN-STAIRS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-DOWN> <DO-WALK ,P?DOWN>)>>

<ROUTINE HUDSON-BAG-F ()
    <COND (<VERB? OPEN>
           <COND (<FSET? ,PRSO ,OPENBIT> <TELL "The carpetbag is already open." CR>)
                 (T <FSET ,PRSO ,OPENBIT> <TELL "You undo the fastenings. Hudson has rolled the shirt around a pair of clean socks." CR>)>)
          (<VERB? CLOSE>
           <COND (<FSET? ,PRSO ,OPENBIT> <FCLEAR ,PRSO ,OPENBIT>
                  <TELL "You fold the bag shut. The shirt cuff catches between the fastenings again." CR>)
                 (T <TELL "Both fastenings are already shut." CR>)>)
          (<VERB? EXAMINE>
           <COND (<FSET? ,PRSO ,OPENBIT> <TELL "A clean shirt and rolled socks fill the open bag." CR>)
                 (T <TELL "A clean shirt cuff pokes between the fastenings. Hudson has packed in a hurry." CR>)>)>>
