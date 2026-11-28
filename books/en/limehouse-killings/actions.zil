<SYNTAX TURN OBJECT = V-SPIN>

; === ACTION ROUTINES ===

; --- Evidence Object Actions ---

<ROUTINE TELEGRAM-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "Lady Ashworth's message reads: “Begin with what the locked room could not hide. Ashworth marked every private mechanism with the name of the person it concerned.” Beneath it she has added, “Hudson has put the kettle on; he insists detection is impossible while cold.”" CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Wet paper and, very faintly, violet water. Whoever added the pencilled postscript had scent on her wrist." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The paper has gone soft with damp. Where the stone pressed it, the pencilled postscript has smudged into a grey thumbprint." CR>
           <RTRUE>)
          (<VERB? BURN>
           <TELL "You may need it yet. Lady Ashworth chose those words for you with some care." CR>
           <RTRUE>)>>

<ROUTINE DEAD-LETTER-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "The letter reads: “My dear [[Dr. Moriarty->moriarty]], I know what you did. If you do not confess by Friday, I will expose you to Scotland Yard. - Lord Ashworth”" CR>
           <COND (<NOT ,DEAD-LETTER-FOUND>
                  <SETG DEAD-LETTER-FOUND T>
                  <SETG EVIDENCE-FOUND <+ ,EVIDENCE-FOUND 1>>
                  <SCORE-UPD 10>
                  <CHECK-CASE-PROGRESS>)>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Old paper, sealing wax and pipe smoke: the smell of a man who wrote late at night." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The paper is soft along its folds, as though it was opened and refolded many times before it was put away unsent." CR>
           <RTRUE>)
          (<VERB? OPEN>
           <TELL "The flap was never sealed. Ashworth folded the letter to fit but never sent it." CR>
           <RTRUE>)
          (<VERB? BURN>
           <TELL "Lady Ashworth already burned one draft of this letter. You will not burn the other." CR>
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
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Under the wet leaves, the blade smells of old iron." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "You keep your fingers off the blade and handle it by the very end of the grip. Lestrade will want it as it was found." CR>
           <RTRUE>)>>

<ROUTINE LOCKED-BOX-F ()
    <COND (<VERB? SPIN>
           <COND (,LOCKED-BOX-OPENED <TELL "The dial already rests at MORIARTY. The lid is unlocked." CR>)
                 (T <TELL "The dial clicks from name to name. Which will you turn it to: [[Lady Ashworth->ashworth]], [[Mr. Hudson->hudson]], or [[Dr. Moriarty->moriarty]]?" CR>)>)
          (<VERB? EXAMINE READ>
           <COND (,LOCKED-BOX-OPENED
                  <COND (<FSET? ,LOCKED-BOX ,OPENBIT>
                         <TELL "The box stands open, its dial resting at MORIARTY between the engraved letter, flower, and columns of debt.">
                         <COND (<IN? ,BANK-STATEMENT ,LOCKED-BOX> <TELL " A [[bank statement->statement]] lies inside.">)>)
                        (T
                         <TELL "The lid is shut, but the dial still reads MORIARTY. Nothing is holding it closed.">)>
                  <CRLF>
                  <RTRUE>)>
           <TELL "The box has no keyhole. A lettered name dial is ringed by tiny engravings: a sealed letter, a purple flower, and columns of debt. The dial can be aligned to any of three names: [[Lady Ashworth->ashworth]], [[Mr. Hudson->hudson]], or [[Dr. Moriarty->moriarty]]. Only the name that connects all three engravings will open it." CR>
           <SETG BOX-CLUE-SEEN T>
           <RTRUE>)
          (<VERB? TURN ALIGN>
           <COND (,LOCKED-BOX-OPENED
                  <TELL "The lid is unlocked; the dial has done its work." CR>
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
           <COND (<FSET? ,LOCKED-BOX ,OPENBIT>
                  <TELL "The box is already open." CR>)
                 (<AND ,LOCKED-BOX-OPENED <VERB? OPEN>>
                  <FSET ,LOCKED-BOX ,OPENBIT>
                  <TELL "You lift the lid again. The latch clears without touching the dial.">
                  <COND (<IN? ,BANK-STATEMENT ,LOCKED-BOX>
                         <TELL " The [[bank statement->statement]] is still inside.">)>
                  <CRLF>)
                 (,LOCKED-BOX-OPENED
                  <TELL "The lid is already unlocked; lift it to see inside." CR>)
                 (T
                  <TELL "There is no keyhole to pick. The name dial is the lock: examine the box, then align its dial to one of the names." CR>)>
           <RTRUE>)
          (<VERB? CLOSE>
           <COND (<FSET? ,LOCKED-BOX ,OPENBIT>
                  <FCLEAR ,LOCKED-BOX ,OPENBIT>
                  <TELL "You lower the lid. The dial stays at MORIARTY." CR>)
                 (T <TELL "The lid is already shut." CR>)>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Cold soot from the grate and a little machine oil at the dial." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "You tap the lid and listen. Something papery shifts inside, but nothing rattles." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The box answers with the flat knock of thick brass. Whatever it holds is packed tight." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The engravings are sharp under your fingertip, and the dial is warm where someone has turned it often." CR>
           <RTRUE>)
          (<VERB? ATTACK BREAK KICK>
           <TELL "The box is solid brass and the only lock is its dial. Force would only bring the household running." CR>
           <RTRUE>)>>

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
           (<VERB? TASTE EAT DRINK>
            <TASTE-POISON>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Even through the cork comes a faint, sharp smell, like crushed radish. You hold the bottle away from your face." CR>
           <RTRUE>)
          (<VERB? SHAKE>
           <TELL "A little cloudy liquid slides across the bottom. Most of the bottle has already been used." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The glass is greasy near the neck, where a gloved thumb held it." CR>
           <RTRUE>)>>

<ROUTINE SECRET-LEDGER-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "Ashworth has entered a loan of £500 against [[Dr. Moriarty->moriarty]]'s name. The due date was Friday; beneath it, in a heavier hand, he has written UNPAID." CR>
            <COND (<NOT ,SECRET-LEDGER-FOUND>
                   <SETG SECRET-LEDGER-FOUND T>
                   <SETG EVIDENCE-FOUND <+ ,EVIDENCE-FOUND 1>>
                   <SCORE-UPD 10>
                   <CHECK-CASE-PROGRESS>)>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Leather, ink and the dry smell of a book kept shut in a drawer for years." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The binding is worn pale at one corner, where a thumb has opened it again and again to the same page." CR>
           <RTRUE>)>>

; --- Tool Object Actions ---

<ROUTINE MAGNIFYING-GLASS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A brass magnifying glass with a horn handle. The lens is clear and strong enough to show the grain in a thumbprint." CR>
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
           <COND (<EQUAL? ,PRSI ,SECRET-LEDGER>
                  <TELL "Under the lens, the last word has bitten clear through the paper. Ashworth pressed a good deal harder writing UNPAID than he did recording the loan." CR>)
                 (<EQUAL? ,PRSI ,DEAD-LETTER>
                  <TELL "The ink feathers where the pen paused above the name. Ashworth had to make himself finish writing it." CR>)
                 (<EQUAL? ,PRSI ,POISON-BOTTLE>
                  <TELL "A pale rim has dried on the inside of the neck. Whatever was poured out, there is only a finger's depth left." CR>)
                 (<EQUAL? ,PRSI ,BLOOD-STAINED-KNIFE>
                  <TELL "The little engraved M is smooth and black at the bottom. The knife had an owner long before it found a victim." CR>)
                 (<EQUAL? ,PRSI ,WAX-SEAL>
                  <TELL "The lens picks out a curl of broken thread in the wax. Whoever opened the parcel pulled at the string instead of warming the seal off." CR>)
                 (T <TELL "The lens shows you nothing there that your unaided eye had missed." CR>)>
           <RTRUE>)
          (<VERB? LOOK-INSIDE>
           <TELL "Through the lens your own thumb swells into ridges and whorls. It wants something small and particular to look at." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "You polish the lens on your cuff. The brass handle is warm from your hand and fits it well." CR>
           <RTRUE>)
          (<VERB? SHAKE>
           <TELL "Nothing rattles. The lens is seated firmly in its brass ring." CR>
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
		<RTRUE>)
          (<VERB? RUB>
           <TELL "The steel is cold and oiled. The tips are polished bright from use." CR>
           <RTRUE>)
          (<VERB? SHAKE>
           <TELL "The picks chime softly against one another in their pockets." CR>
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
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Clean lamp oil and hot brass. Someone trimmed this wick today." CR>
           <RTRUE>)
          (<VERB? SHAKE>
           <TELL "Oil sloshes in the full reservoir." CR>
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
           <RTRUE>)
          (<VERB? SHAKE>
           <TELL "The keys jingle. The long study key is heavier than the rest and clacks against them." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The long study key is bright along its wards from years of turning." CR>
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
           <RTRUE>)
          (<VERB? RUB>
           <TELL "One edge is ragged. The page was ripped out of a notebook in a hurry, not cut." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Cheap ink and library dust." CR>
           <RTRUE>)>>

<ROUTINE COLORED-MARKERS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Four ribbons mark books set slightly proud of their neighbors: the [[red book]] on shelf 1, the [[blue book]] on shelf 3, the [[green book]] on shelf 4, and the [[yellow book]] on shelf 2. Each yields a little under your finger." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The ribbons are silk, the kind used to mark a place in a hymn book." CR>
           <RTRUE>)
          (<VERB? MOVE>
           <TELL "Each ribbon is knotted fast around its book. They are meant to stay where they are." CR>
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
           <RTRUE>)
          (<VERB? READ>
           <TELL "You try to open it. The pages are glued into a solid block; this book was never meant to be read." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "The book will not come off the shelf. Something behind it holds it in place." CR>
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
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The plaster is dry and chalky, and the edges of the print are still crisp." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Damp plaster and garden mud." CR>
           <RTRUE>)
          (<VERB? BREAK KICK>
           <TELL "Breaking the cast would be a gift to whoever left the print. You set it down carefully instead." CR>
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
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Sealing wax keeps its scent: a little cinnamon and a little smoke." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The wax is brittle at the edges, where it broke away from the parcel string." CR>
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
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The bank has embossed its stamp into the corner. You can feel the letters with your thumb." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "A faint smell of soot. The clerk's neat figures have outlasted somebody's attempt to hide them." CR>
           <RTRUE>)
          (<VERB? OPEN>
           <TELL "You smooth out the fold. Five hundred pounds is a great deal less imposing in the clerk's tidy figures than it is as a debt." CR>
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
           <RTRUE>)
          (<VERB? OPEN>
           <TELL "You pull the three drawers out one after another. All are empty. Someone has been through them already." CR>
           <RTRUE>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the desk there is only a worn patch of carpet where Lord Ashworth rested his feet." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The mahogany is thick and solid. Nothing is hidden in the panels." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Pipe tobacco, ink and furniture wax." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "You rub the rim of an ink stain. It has soaked into the grain; somebody kept blotting paper here and rarely used it." CR>
           <RTRUE>)>>

<ROUTINE FIREPLACE-F ()
    <COND (<VERB? EXAMINE LOOK-INSIDE SEARCH>
           <COND (<EQUAL? ,HERE ,LIBRARY>
                  <TELL "The library grate is swept and cold; no fire has been laid here tonight." CR>)
                 (T
                  <TELL "A small [[box]] sits in the cold ashes of the study fireplace.">
                  <COND (<AND <IN? ,POISON-BOTTLE ,STUDY> <NOT <FSET? ,POISON-BOTTLE ,TOUCHBIT>>>
                         <TELL " A glass [[bottle]] stands on the mantelpiece, its paper label curling at one corner.">)>
                  <COND (,CIPHER-SOLVED
                         <TELL " A panel in the chimney breast stands open on the hidden stair [[down]].">)>
                  <CRLF>)>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Cold ash and the bitter smell of burnt paper." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The ashes are cold right through. No one has laid a fire here since yesterday." CR>
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
		<RTRUE>)
          (<VERB? RUB>
           <TELL "You clear a patch of the clouded glass with your sleeve. Outside, rain drips from the garden hedges." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Rain taps steadily on the glass." CR>
           <RTRUE>)
          (<VERB? ATTACK BREAK KICK>
           <TELL "Breaking the glass would bring the whole house running and spoil whatever the sill can tell you." CR>
           <RTRUE>)>>

<ROUTINE STUDY-DOOR-F ()
    <COND (<AND <VERB? LOCK> ,STUDY-UNLOCKED>
           <TELL "You leave the study unlocked. The inquiry is not finished with it." CR>
           <RTRUE>)
          (<VERB? EXAMINE>
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
                  <COND (<EQUAL? ,HERE ,STUDY>
                         <TELL "You open the study door. The draught from the hall to the [[south]] lifts the top sheet on the desk." CR>)
                        (T <TELL "You open the study door. The study lies [[north]]." CR>)>)>
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
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "You rap on the oak. The heavy door swallows the sound." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "You put your ear to the oak. On the other side, the house is very quiet." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The brass round the keyhole is scratched, but the scratches are old and dull." CR>
           <RTRUE>)>>

<ROUTINE BOOKSHELF-F ()
    <COND (<VERB? READ>
           <TELL "Gilt titles in Latin and English: botany, anatomy, chemistry, a long run of sermons nobody has opened. Four spines stand a little proud of the rest, each with a coloured ribbon." CR>
           <RTRUE>)
          (<VERB? EXAMINE>
           <TELL "Most books stand flush with the shelves. Four project a little: a [[red book]], a [[blue book]], a [[green book]], and a [[yellow book]], each marked with a ribbon." CR>
           <RTRUE>)
          (<VERB? PUSH>
           <COND (,CIPHER-SOLVED
                  <TELL "The shelves have already swung aside; the passage stands open to the [[east]]." CR>
                  <RTRUE>)
                 (T
                  <TELL "You push a book. Nothing happens. Perhaps there's an order to follow." CR>
                  <RTRUE>)>)
          (<VERB? SMELL>
           <TELL "Old leather, glue and dust." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "Most of the shelving sounds solid. Behind the marked books it rings hollow." CR>
           <RTRUE>)
          (<VERB? LOOK-BEHIND>
           <TELL "The shelves are fixed to the wall. You cannot see behind them without moving something." CR>
           <RTRUE>)>>

<ROUTINE READING-DESK-F ()
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "Loose papers cover the reading desk.">
           <COND (<AND <IN? ,TORN-PAGE ,LIBRARY> <NOT <FSET? ,TORN-PAGE ,TOUCHBIT>>> <TELL " A torn [[page]] is covered in handwritten notes.">)
                 (T <TELL " A clean rectangle shows where a page once lay.">)>
           <COND (<AND <IN? ,SECRET-LEDGER ,LIBRARY> <NOT <FSET? ,SECRET-LEDGER ,TOUCHBIT>>> <TELL " A leather-bound [[ledger]] lies open beside the papers.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the reading desk lie a dropped pen nib and a great deal of dust." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The desk top is sticky with spilled ink near the lamp." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Lamp oil and ink." CR>
           <RTRUE>)>>

<ROUTINE TABLE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The dining table is set for two, but only one place was used. A skin has formed on Lady Ashworth's soup. Her untouched [[cutlery]] lies exactly parallel to her plate.">
           <COND (<AND <IN? ,WAX-SEAL ,HERE> <NOT <FSET? ,WAX-SEAL ,TOUCHBIT>>>
                  <TELL " A crimson [[wax seal->seal]] lies near the empty plate.">)>
           <TELL CR>
           <RTRUE>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the table there is only a dropped napkin, folded once, as if someone set it down in a hurry." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "You rap the table. Lady Ashworth flinches at the sound." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The table is polished smooth, but there is a ring where a wine glass stood wet." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Cold soup, candle wax and red wine." CR>
           <RTRUE>)>>

<ROUTINE WINE-CABINET-F ()
    <COND (<VERB? EXAMINE>
           <SETG CABINET-CLUE-SEEN T>
           <TELL "The cabinet is unlatched. Dust outlines a missing squat bottle on the medicinal-wine shelf; beside the gap, a handwritten inventory [[entry]] reads “tincture, private laboratory.” Someone removed the delivery bottle without disturbing the dinner wines." CR>
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
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Port, dust and something sharper, like cough syrup, from the medicinal shelf." CR>
           <RTRUE>)
          (<VERB? LOOK-BEHIND>
           <TELL "The cabinet stands flat against the wall. Only cobwebs live behind it." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The glass rattles in its frame. Lady Ashworth looks up." CR>
           <RTRUE>)>>

<ROUTINE POTS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A dozen copper pots hang from an iron rack, largest to smallest. They are green with tarnish; nobody has cooked a proper dinner in them for weeks." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "You tap a copper pot. It rings softly, and its neighbours hum in answer." CR>
           <RTRUE>)
          (<VERB? MOVE>
           <TELL "The pots swing on their hooks and clank together before they settle." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "Your fingertip comes away green with tarnish." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Copper and old cooking fat." CR>
           <RTRUE>)>>

<ROUTINE HEARTH-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Soot darkens the lintel. Yesterday's ashes have settled into a pale crust." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Cold ash and old soot." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The hearthstone is cold. The warmth in this kitchen all comes from the range." CR>
           <RTRUE>)
          (<VERB? LOOK-INSIDE>
           <TELL "The ashes are a day old. Nothing has been burned here tonight." CR>
           <RTRUE>)>>

<ROUTINE SERVANT-BELL-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A brass bell hangs on a coiled spring above the door, with a pull rope beside it. A wire from the bell runs up through the ceiling to the rooms above." CR>
           <RTRUE>)
          (<VERB? MOVE USE RING>
           <TELL "You pull the bell rope. A distant bell rings upstairs." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "The bell is still now, but its spring gives a tiny tick whenever someone walks across the hall above." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The brass bell is polished; the rope below it is grey where hands have pulled it." CR>
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
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "The kettle murmurs on the range, never quite coming to the boil." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The enamel is hot. You take your hand back quickly." CR>
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
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "You hold your breath. The wire hums very faintly, like a plucked string." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The wire is thin and taut, and cold under your fingers." CR>
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
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Neatsfoot oil and old wood." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The drawer front is worn smooth by years of hands." CR>
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
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The stone rim is wet and furred with moss." CR>
           <RTRUE>)
          (<VERB? DRINK>
           <TELL "The fountain has been dry for years. Only a little rainwater lies in its cracks." CR>
           <RTRUE>)
          (<VERB? LOOK-INSIDE>
           <TELL "Tarnished coins lie in the dry basin, with a few dead leaves and a great deal of grit." CR>
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
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Wet privet and leaf mould." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "Twigs snag your sleeve. The branches are thick and thorny." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Rain patters through the leaves." CR>
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
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You keep your hands off the wolfsbane. Even its sap can numb the skin." CR>
           <RTRUE>)
          (<VERB? EAT>
           <TELL "Wolfsbane? Not unless you mean to join Lord Ashworth." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The leaves are cool and wet. You wipe your fingers afterwards, just in case." CR>
           <RTRUE>)>>

<ROUTINE LABELS-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "The curled labels on the [[purple flowers->flowers]] read “Aconitum - Wolfsbane.” A watering date in Hudson's handwriting is underlined twice." CR>
           ;"Reading the label with the bottle in hand is the comparison."
           <COND (<AND <NOT ,POISON-IDENTIFIED> <IN? ,POISON-BOTTLE ,WINNER>>
                  <IDENTIFY-POISON>)>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You leave the labels with their pots. Lestrade will want to see them where they are." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The paper is damp and soft. The ink has run a little but is still readable." CR>
           <RTRUE>)>>

<ROUTINE BENCH-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Dry rings mark the potting bench where pots stood. Freshly cut purple stems lie in a shallow groove; the cut ends are clean, not torn." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Potting soil and the green smell of cut stems." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "Soil gritty under your fingers, and a clean, dry patch where a knife was laid down." CR>
           <RTRUE>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the bench are stacked clay pots and a rusty trowel." CR>
           <RTRUE>)>>

<ROUTINE BEDS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Clean linen covers each empty bed. The cloth is thin at the folds, but every tear has been mended." CR>
           <RTRUE>)
          (<VERB? LOOK-UNDER>
           <TELL "Under the beds stand pairs of broad, well-blacked work boots, set out neatly for the morning." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The blankets are coarse wool, tucked so tight they hardly give." CR>
           <RTRUE>)
          (<VERB? CLIMB-ON>
           <TELL "These are not your beds, and Hudson is watching." CR>
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
           <RFALSE>)
          (<VERB? SMELL>
           <TELL "Camphor and starched linen." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The trunk gives back a dull, padded knock." CR>
           <RTRUE>)>>

<ROUTINE TRUNK-LETTER-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "The letter is addressed to Mr. Hudson from an unknown sender. It reads:" CR>
           <TELL "The master's experiments have gone too far. If anything happens to me, the evidence is in the study. Burn this after reading." CR>
           <TELL "The signature is illegible." CR>
           <RTRUE>)>>

<ROUTINE UNIFORMS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Black jackets and aprons, pressed and folded, each with a name tape sewn into the collar. The wool is worn shiny at the elbows." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Starch, camphor and boot polish." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The cloth is good wool, worn shiny at the elbows." CR>
           <RTRUE>)>>

<ROUTINE SHELVES-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The shelves hold preserves and spices">
           <COND (<AND <IN? ,FOXGLOVE ,PANTRY> <NOT <FSET? ,FOXGLOVE ,TOUCHBIT>>>
                  <TELL ", dried [[foxglove]] with a poison warning">)>
           <COND (<AND <IN? ,CHARCOAL ,PANTRY> <NOT <FSET? ,CHARCOAL ,TOUCHBIT>>>
                  <TELL ", and powdered [[charcoal]] labeled for swallowed poisons">)>
           <TELL "." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Cloves, pepper, apples and something bitter on the highest shelf." CR>
           <RTRUE>)
          (<VERB? LOOK-BEHIND>
           <TELL "The shelves are fixed to the wall. There is nothing behind them but whitewash." CR>
           <RTRUE>)>>

<ROUTINE FOXGLOVE-F ()
    <COND (<VERB? EXAMINE READ>
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
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Dry hay and something faintly bitter." CR>
           <RTRUE>)>>

<ROUTINE CHARCOAL-F ()
    <COND (<VERB? EXAMINE READ>
           <TELL "The powdered charcoal is labeled for immediate use after swallowed poisons. It can limit harm, not identify a culprit." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You take the charcoal." CR>
           <MOVE ,CHARCOAL ,WINNER>
           <FSET ,CHARCOAL ,TOUCHBIT>
           <FCLEAR ,CHARCOAL ,NDESCBIT>
           <RTRUE>)
          (<VERB? USE EAT DRINK>
           <COND (<==? ,PLAYER-HEALTH 3>
                  <TELL "You have swallowed no poison. Save the charcoal for an actual emergency." CR>)
                 (T
                  <SETG PLAYER-HEALTH <+ ,PLAYER-HEALTH 1>>
                  <TELL "You swallow a measured spoonful with water. It tastes of soot, but the dizziness recedes and your pulse steadies." CR>)>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "The tin smells of nothing at all, which is rather the point of charcoal." CR>
           <RTRUE>)
          (<VERB? SHAKE>
           <TELL "The black powder shifts and puffs from under the lid." CR>
           <RTRUE>)>>

; --- Room Action Routines (Dynamic Descriptions) ---

<ROUTINE GATE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You stand at the open iron [[gates]] of Ashworth Manor. Cold river [[fog]] drifts between the bars. The cab wheels have fallen silent, and somewhere off the riverbank a ship knocks against its mooring. A raked gravel [[path]] leads [[north]] to the dark brick [[house->manor house]]. A single [[lit window]] downstairs looks no bigger than a stamp." CR>)>>

<ROUTINE STUDY-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in Lord Ashworth's study, a small panelled room that smells of cold ash and lamp oil. A chalk [[outline]] on the carpet shows where he fell, face down between the stone [[fireplace]] and a mahogany [[desk]]">
           <COND (<AND <FSET? ,DEAD-LETTER ,INVISIBLE> <IN? ,DEAD-LETTER ,STUDY>>
                  <TELL " heaped with [[papers]].">)
                 (<AND <IN? ,DEAD-LETTER ,STUDY> <FSET? ,DEAD-LETTER ,NDESCBIT>>
                  <TELL ", where a yellowed [[envelope->letter]] lies uncovered among the papers.">)
                 (T <TELL " whose [[papers]] lie scattered.">)>
           <COND (,LOCKED-BOX-OPENED
                  <COND (<FSET? ,LOCKED-BOX ,OPENBIT>
                         <TELL " In the grate, the name-dial [[box]] lies open among the cold [[ashes]]">
                         <COND (<AND <IN? ,BANK-STATEMENT ,LOCKED-BOX> <FSET? ,BANK-STATEMENT ,NDESCBIT>>
                                <TELL " with a [[bank statement->statement]] inside">)>
                         <TELL ".">)
                        (T <TELL " The name-dial [[box]] sits shut in the cold [[ashes]].">)>)>
           <COND (<FSET? ,WINDOW ,OPENBIT>
                  <TELL " A tall [[window]] stands open on the garden to the [[southwest]].">)
                 (T
                  <TELL " A tall [[window]] to the southwest looks out on the garden, its catch rusted shut.">)>
           <COND (,CIPHER-SOLVED
                  <TELL " A panel in the chimney breast stands open, and a hidden stair leads [[down]].">)>
           <COND (<FSET? ,STUDY-DOOR ,OPENBIT>
                  <TELL " The oak [[door]] to the entrance hall stands open to the [[south]].">)
                 (,STUDY-UNLOCKED
                  <TELL " The oak [[door]] to the entrance hall, in the south wall, is closed but unlocked.">)
                 (T
                  <TELL " The oak [[door]] to the entrance hall, in the south wall, is still bolted on this side.">)>
           <CRLF>)>>

<ROUTINE LIBRARY-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in the library, a long room lined from floor to ceiling with [[bookshelves->bookshelf]]. Lamplight catches the gilt [[titles]] on the spines, and small coloured [[ribbons]] hang from a few of the shelves. A [[reading desk]] in the middle of the room is strewn with loose papers.">
           <COND (<IN? ,DR-MORIARTY ,LIBRARY>
                  <TELL " [[Dr. Moriarty->moriarty]] stands by the shelves, tapping one [[spine]] with a fingernail.">)>
           <COND (,CIPHER-SOLVED
                  <TELL " A section of shelving has swung aside, and a dark way leads [[east]] into the wall. The entrance hall is back to the [[west]].">)
                 (T
                  <TELL " The only way out is back to the entrance hall, to the [[west]].">)>
           <CRLF>)>>

<ROUTINE KITCHEN-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "This is the manor kitchen, and the warmth comes as a shock after the hall. The blue enamel [[kettle]] trembles on the range beside the cold [[hearth]]. Under the tarnished copper [[pots]], a draught makes the [[servant bell]] rope sway without ringing. The counter [[drawer]] is">
           <COND (<FSET? ,DRAWER ,OPENBIT> <TELL " pulled open.">)
                 (T <TELL " shut.">)>
           <TELL " Stairs lead [[up]] to the entrance hall, and the garden lies outside to the [[west]]." CR>)>>

<ROUTINE GARDEN-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in the walled garden behind the manor. Rain drips from the overgrown [[hedges]], and a dry stone [[fountain]] stands at the centre with a few [[coins]] in its basin.">
           <COND (<AND <FSET? ,BLOOD-STAINED-KNIFE ,INVISIBLE> <IN? ,BLOOD-STAINED-KNIFE ,GARDEN>>
                  <TELL " Something glints deep in the hedges, low down near the fountain.">)
                 (<AND <IN? ,BLOOD-STAINED-KNIFE ,GARDEN> <FSET? ,BLOOD-STAINED-KNIFE ,NDESCBIT>>
                  <TELL " A [[knife]] hangs where you parted the branches.">)>
           <COND (<FSET? ,WINDOW ,OPENBIT>
                  <TELL " The tall [[study window]] stands open to the [[northeast]], its sill low enough to step over.">)
                 (T
                  <TELL " To the northeast, the tall [[study window]] is shut.">)>
           <TELL " A path leads [[north]] to a glass [[greenhouse]] and another [[south]] to the servants' quarters, and the kitchen is to the [[east]]." CR>)>>

<ROUTINE DINING-ROOM-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in the dining room. A long [[table]] is laid for two, though only one of the places has been used.">
           <COND (<EQUAL? ,CASE-ACT 3>
                  <TELL " Lady [[Ashworth]] sits listening toward the hall, her [[black ribbon]] laid beside her [[plate]].">)
                 (,LADY-CONFRONTED
                  <TELL " Lady [[Ashworth]] sits very straight, her [[wedding ring]] off and lying on the wood beside her [[plate]].">)
                 (T
                  <TELL " Lady [[Ashworth]] sits alone in black before a bowl of untouched soup, turning her [[wedding ring]] on her finger.">)>
           <TELL " A glass-fronted wine [[cabinet]] stands against the wall">
           <COND (,CABINET-CLUE-SEEN <TELL ", one bottle missing from its dusty shelf">)>
           <TELL ". Doors lead [[east]] to the entrance hall and [[north]] to the pantry." CR>)>>

<ROUTINE GREENHOUSE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in a small glass greenhouse at the end of the garden. Rain ticks overhead, and the air is warm and heavy with wet earth. Exotic [[plants]] crowd the wooden staging, among them a clump of tall purple flowers beside a wooden potting [[bench]].">
           <COND (,POISON-IDENTIFIED
                  <TELL " You have already matched the bottle from the study against their curled paper [[labels]].">)
                 (T
                  <TELL " Each pot carries a small curled paper [[label->labels]].">)>
           <TELL " The door back to the garden is to the [[south]]." CR>)>>

<ROUTINE SERVANTS-QUARTERS-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in the servants' quarters, a low whitewashed room at the bottom of the garden. Three narrow [[beds]] stand in a row with their blankets tucked tight, and a heavy wooden [[trunk]] sits at the foot of the last. The room smells of boot blacking and coal smoke.">
           <COND (<==? ,CASE-ACT 3>
                  <TELL " Mr. [[Hudson]], the butler, stands ready to leave, a packed [[carpetbag]] at his feet.">)
                 (,HUDSON-CONFRONTED
                  <TELL " Mr. [[Hudson]], the butler, has stopped polishing at last and sits with his hands on his knees.">)
                 (T
                  <TELL " Mr. [[Hudson]], the butler, sits on the end of a bed polishing the same silver [[spoon]] over and over.">)>
           <TELL " The garden is back to the [[north]]." CR>)>>

<ROUTINE SECRET-PASSAGE-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in a narrow secret passage behind the library shelves. Damp [[stone walls]] press close on either side, grey [[cobwebs]] hang in the corners, and the air tastes of soot.">
           <COND (<AND <IN? ,LANTERN ,WINNER> <FSET? ,LANTERN ,ONBIT>>
                  <TELL " Your lantern picks out fresh heel marks in the [[dust]] on the floor.">)
                 (T <TELL " A trail of scuffs runs through the [[dust]] on the floor.">)>
           <TELL " The library is back to the [[west]], and steep [[study steps]] climb [[up]] inside the chimney breast." CR>)>>

<ROUTINE PANTRY-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in the narrow pantry. Jars of summer preserves crowd the wooden [[shelves]] between packets of spice. Winter [[apples]] sweeten the air from their bed of straw. A smear of black [[charcoal dust]] is the one thing here no cook would have put away. The dining room is back to the [[south]]." CR>)>>

<ROUTINE ENTRANCE-HALL-FCN (RARG)
    <COND (<EQUAL? .RARG ,M-LOOK>
           <TELL "You are in the entrance hall of Ashworth Manor. A dusty [[chandelier]] hangs over a faded Persian [[rug]], stern family [[portraits]] hang all around, and a polished [[hall table]] stands beneath the light.">
           <COND (<EQUAL? ,CASE-ACT 2>
                  <TELL " Beside the study door, a thin [[bell wire]] is still quivering.">)
                 (T
                  <TELL " A thin [[bell wire]] runs up the wall beside the study door.">)>
           <COND (<FSET? ,STUDY-DOOR ,OPENBIT>
                  <TELL " The oak study [[door]] stands open to the [[north]].">)
                 (,STUDY-UNLOCKED
                  <TELL " The oak study [[door]] to the north is closed but unlocked.">)
                 (T
                  <TELL " The oak study [[door]] to the north is closed and locked.">)>
           <TELL " The library is to the [[east]] and the dining room to the [[west]]; service [[stairs]] go [[down]] to the kitchen, and the way out leads [[south]] to the gate.">
           <COND (<AND ,INSPECTOR-PRESENT <IN? ,INSPECTOR ,ASHWORTH-ENTRANCE-HALL>>
                  <TELL " [[Inspector Lestrade->lestrade]] has arrived from Scotland Yard and waits under the chandelier with his notebook open">
                  <COND (<IN? ,DR-MORIARTY ,ASHWORTH-ENTRANCE-HALL>
                         <TELL ", and [[Dr. Moriarty->moriarty]] stands beside him, hat in hand">)>
                  <TELL ".">)
                 (<IN? ,DR-MORIARTY ,ASHWORTH-ENTRANCE-HALL>
                  <TELL " [[Dr. Moriarty->moriarty]] waits near the way out with his hat in his hand.">)>
           <CRLF>)>>

; --- Global Object Actions ---

<ROUTINE FOG-F ()
    <COND (<VERB? EXAMINE>
           <TELL "You hold a hand in the fog. Tiny drops gather on the hairs of your wrist before you feel them on your skin." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "The fog smells of river mud, coal smoke, and rain on iron." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "The fog muffles everything. Sounds from the river seem to come from all directions at once." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "You pass a hand through it. It closes behind your fingers, cold and wet." CR>
           <RTRUE>)>>

<ROUTINE GATES-F ()
    <COND (<VERB? OPEN RAISE> <TELL "The latch is rusted fast in its raised position. You can walk straight through the gates to the [[north]]." CR>)
          (<VERB? EXAMINE>
           <TELL "The iron gates bear the [[Ashworth crest->Ashworth crest]]. Their [[latch->iron gates]] has rusted in the raised position." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "Rust comes away on your glove in red flakes." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "You rap on the bars. The iron gives back a dull note, and the fog swallows it." CR>
           <RTRUE>)
          (<VERB? MOVE PUSH>
           <TELL "The gate swings a few inches and groans on its hinges. It is open already." CR>
           <RTRUE>)
          (<VERB? CLIMB-ON>
           <TELL "There is no need to climb the gates. They stand open." CR>
           <RTRUE>)>>

<ROUTINE PATH-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The gravel path has been raked into [[fans->rake marks]]. One fan has been kicked flat outside the front door." CR>
           <RTRUE>)
          (<VERB? KICK>
           <TELL "You scuff the gravel. It is loose on top and packed hard underneath." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The gravel is wet, sharp-edged and cold." CR>
           <RTRUE>)>>

<ROUTINE HALL-TABLE-F ()
    <COND (<VERB? EXAMINE SEARCH>
           <TELL "Someone has polished the wood right down to the little key scratches.">
           <COND (<AND <IN? ,MAGNIFYING-GLASS ,ASHWORTH-ENTRANCE-HALL> <NOT <FSET? ,MAGNIFYING-GLASS ,TOUCHBIT>>>
                  <TELL " A brass [[magnifying glass->glass]] lies in a ring of dust at the back.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The polish is so fresh it is almost tacky. Someone has worked hard on this table today." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The table gives a solid, expensive knock." CR>
           <RTRUE>)
          (<VERB? LOOK-UNDER>
           <TELL "Nothing is under the table but clean boards. Whoever polished it swept beneath it too." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Beeswax and turpentine." CR>
           <RTRUE>)>>

<ROUTINE CHANDELIER-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A single [[clean crystal]] throws a fleck of light onto the hall table. The others wear little caps of dust." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "The crystals tick faintly against one another as the draught from the front door moves them." CR>
           <RTRUE>)
          (<VERB? MOVE PUSH RUB>
           <TELL "The chandelier hangs well above your reach." CR>
           <RTRUE>)>>

<ROUTINE PORTRAITS-F ()
    <COND (<VERB? EXAMINE>
           <TELL "Generations of Ashworths look down in heavy gilt frames, every one of them long-nosed and disapproving. The newest, of Lord Ashworth himself, hangs a little crooked." CR>
           <RTRUE>)
          (<VERB? LOOK-BEHIND>
           <TELL "You tilt one frame from the wall. Behind it is only a pale square of unfaded paper and a spider." CR>
           <RTRUE>)
          (<VERB? MOVE>
           <TELL "The frames are heavy and hang straight on their cords. They have not been moved in years." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The varnish is crazed with fine cracks." CR>
           <RTRUE>)>>

<ROUTINE RUG-F ()
    <COND (<VERB? EXAMINE>
           <TELL "A Persian rug in faded reds and blues covers most of the floor. Its pile is worn thin along the path from the front door to the study." CR>
           <RTRUE>)
          (<VERB? LOOK-UNDER>
           <TELL "You turn back a corner of the rug. Only bare boards, and a line of dust where the edge lay." CR>
           <RTRUE>)
          (<VERB? MOVE>
           <TELL "The rug is heavy and lies flat. Nothing beneath it has made a lump." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The pile is worn thin down the middle, where generations have walked." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Damp wool and dust." CR>
           <RTRUE>)>>

<ROUTINE CHALK-OUTLINE-F ()
    <COND (<VERB? EXAMINE>
           <TELL "The chalk follows a body fallen face down. Three blood drops begin behind the shoulders. A chair leg has dragged a short [[furrow]] through the carpet toward the [[fireplace]].">
           <COND (<AND <IN? ,POISON-BOTTLE ,STUDY> <NOT <FSET? ,POISON-BOTTLE ,TOUCHBIT>>>
                  <TELL " Nothing in the outline explains the [[bottle]] on the mantelpiece.">)>
           <CRLF>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The chalk smears under your finger. You stop at once; Lestrade will want it as it is." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Close to the carpet the air smells of chalk and of old iron." CR>
           <RTRUE>)
          (<VERB? KICK>
           <TELL "You keep well clear of the outline." CR>
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
                 (<EQUAL? ,PRSI ,MR-HUDSON ,HUDSON-NAME>
                  <TELL "Yes? What is it?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,LADY-ASHWORTH ,ASHWORTH-NAME>
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
                 (<EQUAL? ,PRSI ,POISON-BOTTLE ,POISON-TOPIC>
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
                  <RTRUE>)>)
          (<VERB? SMELL>
           <TELL "Silver polish and boot blacking." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Hudson breathes through his nose and says nothing until he is spoken to." CR>
           <RTRUE>)
          (<VERB? ATTACK KICK>
           <TELL "Hudson flinches. You are here to find a murderer, not to make another victim." CR>
           <RTRUE>)>>

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
                 (<EQUAL? ,PRSI ,LADY-ASHWORTH ,ASHWORTH-NAME>
                  <TELL "Yes? What is it?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,MASTER-TOPIC>
                  <TELL "“My husband was a hard man to love and an easy one to owe,” Lady Ashworth says. “He kept his accounts closer than his wife.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,WAX-SEAL>
                  <TELL "“Moriarty sealed every private delivery with an M,” she says. “My husband hated the theatricality of it.”" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,DR-MORIARTY ,MORIARTY-TOPIC>
                  <TELL "Dr. Moriarty was a frequent guest. My husband owed him money." CR>
                   <RTRUE>)
                 (<EQUAL? ,PRSI ,MR-HUDSON ,HUDSON-NAME>
                  <TELL "Mr. Hudson? He's been with the household for years. Loyal, but nervous." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,DEAD-LETTER>
                  <TELL "A letter? Where did you get that?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,BLOOD-STAINED-KNIFE>
                  <TELL "A knife? I don't know anything about it." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,POISON-BOTTLE ,POISON-TOPIC>
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
                  <RTRUE>)>)
          (<VERB? SMELL>
           <TELL "Violet water and the smoke of the cold dining-room lamp." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Lady Ashworth breathes very evenly, as if she is counting." CR>
           <RTRUE>)
          (<VERB? ATTACK KICK>
           <TELL "You came to help Lady Ashworth, not to frighten her." CR>
           <RTRUE>)>>

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
                 (<EQUAL? ,PRSI ,DR-MORIARTY ,MORIARTY-TOPIC>
                  <TELL "Yes? What is it?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,LADY-ASHWORTH ,ASHWORTH-NAME>
                  <TELL "Lady Ashworth? She's a fine woman, trapped in a difficult marriage." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,MR-HUDSON ,HUDSON-NAME>
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
                  <RTRUE>)>)
          (<VERB? SMELL>
           <TELL "Carbolic soap and, under it, something green and bitter, like crushed stems." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Moriarty hums under his breath, always the same four beats." CR>
           <RTRUE>)
          (<VERB? ATTACK KICK>
           <TELL "Moriarty steps neatly aside. “Violence, detective? That would make my case for me.”" CR>
           <RTRUE>)>>

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
                 (<EQUAL? ,PRSI ,DR-MORIARTY ,MORIARTY-TOPIC>
                  <TELL "Dr. Moriarty? A respected scientist. You'll need strong evidence." CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,LADY-ASHWORTH ,ASHWORTH-NAME>
                  <TELL "Lady Ashworth? She has an alibi. What evidence do you have?" CR>
                  <RTRUE>)
                 (<EQUAL? ,PRSI ,MR-HUDSON ,HUDSON-NAME>
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
                  <COND (<NOT ,POISON-IDENTIFIED>
                         <TELL "Lestrade reads the label without uncorking the bottle. “A label tells me what someone wrote. Compare it with the greenhouse labels before you ask me to put it in evidence.”" CR>)
                        (,POISON-PRESENTED
                         <TELL "Lestrade taps the entry in his notebook. “Wolfsbane. I have the comparison in your own words.”" CR>)
                        (T
                         <SETG POISON-PRESENTED T>
                         <TELL "The inspector compares the wolfsbane label with your greenhouse notes. “Wolfsbane, which he admits keeping. It could have weakened Ashworth before the blade struck. The second link.”" CR>)>
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
                  <RTRUE>)>)
          (<VERB? SMELL>
           <TELL "Wet wool and pipe tobacco." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Lestrade taps his pencil against the notebook, waiting." CR>
           <RTRUE>)
          (<VERB? ATTACK KICK>
           <TELL "Assaulting an officer of Scotland Yard would end this inquiry, and not in your favour." CR>
           <RTRUE>)>>

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

"Each taste of the wolfsbane costs health; the warnings grow plainer, the
pantry charcoal restores a step, and the third taste ends the story."

<ROUTINE TASTE-POISON ()
    <SETG PLAYER-HEALTH <- ,PLAYER-HEALTH 1>>
    <COND (<==? ,PLAYER-HEALTH 2>
           <TELL "A bitter trace touches your tongue. Your vision swims and your pulse stumbles; perhaps that wasn't wise." CR>)
          (<==? ,PLAYER-HEALTH 1>
           <TELL "Your lips go numb and your heart knocks unevenly against your ribs. One more taste of this would stop it altogether." CR>)
          (T
           <TELL "The numbness spreads from your mouth to your fingers. You sit down hard on the floor, and your heart stumbles, and stumbles again, and stops. Ashworth's murderer will be found by someone else, if he is found at all." CR CR "THE LIMEHOUSE KILLINGS -- UNSOLVED" CR>
           <SETG GAME-LOST T>
           <SETG GAME-ENDED T>
           <FINISH>)>>

<ROUTINE V-USE ()
    <TELL "You can't use that here." CR>
    <RTRUE>>

<ROUTINE V-USE-ON ()
    <TELL "You try it, but nothing useful comes of it." CR>
    <RTRUE>>

<ROUTINE V-EAT ()
    <COND (<EQUAL? ,PRSO ,POISON-BOTTLE>
           <TASTE-POISON>
           <RTRUE>)
          (T
           <TELL "Tasting the " D ,PRSO " would tell you nothing useful." CR>
           <RTRUE>)>>

<ROUTINE V-SHOW ()
    <COND (<FSET? ,PRSI ,ACTORBIT>
           <TELL D ,PRSI " glances at it and says nothing." CR>)
          (T
           <TELL "You can only show things to people." CR>)>
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
                  <TELL CR "You lay out the sequence: wolfsbane to weaken Ashworth, then the narrow blade from behind. The bottle and flowers establish the drug; the ledger and concealed bank statement establish the debt Ashworth threatened to expose.">
                  <COND (,CIPHER-SOLVED <TELL " The stair you opened explains the escape from a room bolted from within.">)
                        (T <TELL " The door was found bolted from within. Lestrade keeps the manner of escape separate from what you can prove.">)>
                  <COND (,FOOTPRINT-DETAIL-FOUND
                         <TELL " The crescent nick you found under the magnifying glass fits Moriarty's right heel; it places his boot in the garden, not merely a man who wears size ten.">)>
                  <COND
                        (,KNIFE-FOUND
                         <TELL " The surgeon's knife supports the nature of the wound; the monogram alone would not identify the hand.">)>
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
           (<EQUAL? ,PRSO ,MORIARTY-TOPIC ,HUDSON-NAME ,ASHWORTH-NAME>
            <PERSON-OF ,PRSO> <TELL " is not here." CR>
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

"Hints follow the case in order and name the next step, never the whole
solution at once."

<ROUTINE V-HINTS ()
    <COND (<AND <NOT ,CIPHER-SOLVED> <NOT ,STUDY-UNLOCKED>>
           <TELL "Hint: the study is locked from the hall. Mr. Hudson keeps the household keys, and the library may hide another way in: compare the torn page with the ribbons on the marked books." CR>)
          (<NOT ,DEAD-LETTER-FOUND>
           <TELL "Hint: go through the papers on the study desk. Lord Ashworth wrote something he never sent." CR>)
          (<NOT ,POISON-IDENTIFIED>
           <TELL "Hint: compare the poison bottle with the labeled greenhouse plants." CR>)
          (<NOT ,MORIARTY-INTERVIEWED>
           <TELL "Hint: interview every suspect. Dr. Moriarty will talk about his experiments, but ask him about poison." CR>)
          (<NOT ,LADY-INTERVIEWED>
           <TELL "Hint: interview every suspect. Ask Lady Ashworth where she was: her alibi." CR>)
          (<NOT ,HUDSON-INTERVIEWED>
           <TELL "Hint: interview every suspect. Ask Mr. Hudson in the servants' quarters for his alibi." CR>)
          (<NOT ,INSPECTOR-PRESENT>
           <TELL "Hint: Lestrade comes once every suspect has been interviewed and you hold at least three pieces of evidence. The garden hedges and the library desk both hide some." CR>)
          (<NOT ,BANK-STATEMENT-FOUND>
           <TELL "Hint: the box in the study fireplace opens to the one name that connects a letter, a purple flower and a debt." CR>)
          (<NOT <AND ,LETTER-PRESENTED ,POISON-PRESENTED ,MOTIVE-PRESENTED>>
           <TELL "Hint: Lestrade wants a chain: show him the threat, the method and the motive, the unsent letter, the poison bottle and the bank statement." CR>)
          (T
           <TELL "Hint: accuse Dr. Moriarty before Lestrade, and lead with the unsent letter or the poison bottle." CR>)>
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

"The right order opens the shelf whether or not the reader still carries the
torn page; it used to refuse with a line about the page, after all four books
had been pressed correctly."

<ROUTINE SOLVE-CIPHER ()
    <TELL "The blue book settles with a final click. A section of shelving slides aside, opening a stone passage to the [[east]]." CR>
    <SETG CIPHER-SOLVED T>
    <SETG SECRET-PASSAGE-FOUND T>
    <SETG SECRET-PASSAGE-OPEN T>
    <COND (<L? ,CASE-ACT 2> <SETG CASE-ACT 2>)>
    <TELL CR "Somewhere in the manor a bell wire trembles. Behind the books, a draught reaches you from the study. A hidden stair offers another way into the room." CR>
    <RTRUE>>

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
<SYNONYM HINTS HINT HELP>
; The classic rules know ATTACK only WITH a weapon, so a bare "attack hudson"
; used to ask for one; each witness has its own reply.
<SYNTAX ATTACK OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ATTACK>
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

<ROUTINE V-VERSION ()
	<TELL "The Limehouse Killings|Studio Null, 2024|Release " N ,RELEASEID CR>>

<ROUTINE GO ()
	<V-VERSION> <CRLF>
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
	<TELL "London, November 1888. Lord Ashworth was found dead in his study tonight, stabbed in the back, and the study door was still bolted on the inside. You are a private detective, and Lady Ashworth has sent for you to find out how anyone got in or out before Inspector Lestrade of Scotland Yard arrives. The cab has left you at the manor gates, and the fog off the river is thickening." CR CR>
	<TELL D ,HERE CR>
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
		<RTRUE>)
          (<VERB? RUB>
           <TELL "The dust is soft as flour and coats your fingertip grey." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Soot and old mortar." CR>
           <RTRUE>)>>

<ROUTINE STONE-WALLS-F ()
	<COND (<VERB? CLIMB-FOO CLIMB-UP> <DO-WALK ,P?UP>)
          (<VERB? EXAMINE>
		<TELL "Water has bleached the mortar in long vertical runs. The stair rises inside the chimney breast; from the library, a person could reach the study without entering the hall." CR>
		<RTRUE>)
          (<VERB? RUB>
           <TELL "The stone is cold and slick with water." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "You rap on the wall. On the study side it sounds of brick and chimney." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "Somewhere above, water drips steadily inside the chimney." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Wet stone and soot." CR>
           <RTRUE>)>>

<ROUTINE COBWEBS-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Webs remain in the high corners. At shoulder height, torn strands cling to the stone on both sides of the passage." CR>
		<RTRUE>)
          (<VERB? RUB MOVE>
           <TELL "The strands cling to your sleeve. Someone pushed through here at shoulder height before you." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "The cobwebs come apart in your fingers." CR>
           <RTRUE>)>>

<ROUTINE PLACE-SETTINGS-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Both places have the same heavy, blunt dinner cutlery. None has the fine point or narrow edge of a surgeon's blade. Lady Ashworth has not lifted her spoon; the soup beneath it has filmed over." CR>
		<RTRUE>)
		(<VERB? TAKE>
		<TELL "You leave the place settings as they are. Their blunt edges rule out a table knife; moving them would establish nothing further." CR>
		<RTRUE>)
          (<VERB? SMELL>
           <TELL "Cold soup: leek and potato." CR>
           <RTRUE>)
          (<VERB? EAT>
           <TELL "Lady Ashworth's soup? Not while she is sitting in front of it." CR>
           <RTRUE>)>>

<ROUTINE WHITE-ROSE-F ()
	<COND (<VERB? EXAMINE>
		<TELL "Rain has bent the stem without breaking it. The outer petals are brown at the edges; the tightly folded centre is still white." CR>
		<RTRUE>)
		(<VERB? TAKE>
		<TELL "You leave it on the stem. It has survived enough handling by the weather." CR>
		<RTRUE>)
          (<VERB? SMELL>
           <TELL "A faint, rain-washed sweetness." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The petals are cold and wet as wax." CR>
           <RTRUE>)>>

<ROUTINE CONVERSATION-TOPIC-F ("AUX" WHO)
	<COND (<AND <VERB? TELL ACCUSE> <EQUAL? ,PRSO ,MORIARTY-TOPIC ,HUDSON-NAME ,ASHWORTH-NAME>>
		<PERSON-OF ,PRSO> <TELL " is not here. You will have to find "> <PRONOUN-OF ,PRSO> <TELL " to put a question." CR>
		<RTRUE>)
	      (<AND <VERB? SHOW GIVE> <EQUAL? ,PRSI ,MORIARTY-TOPIC ,HUDSON-NAME ,ASHWORTH-NAME>>
		<PERSON-OF ,PRSI> <TELL " is not here to see it." CR>
		<RTRUE>)
	      (<VERB? EXAMINE>
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

"The name a topic stands for, and the pronoun for that person, when a
witness is asked about, shown or accused while they are in another room."

<ROUTINE PERSON-OF (TOPIC)
	<COND (<EQUAL? .TOPIC ,MORIARTY-TOPIC> <TELL "Dr. Moriarty">)
	      (<EQUAL? .TOPIC ,HUDSON-NAME> <TELL "Mr. Hudson">)
	      (T <TELL "Lady Ashworth">)>>

<ROUTINE PRONOUN-OF (TOPIC)
	<COND (<EQUAL? .TOPIC ,ASHWORTH-NAME> <TELL "her">)
	      (T <TELL "him">)>>

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
                 (T <TELL "Her thumb keeps turning the gold band round her finger, even when she folds her hands." CR>)>)
          (<VERB? TAKE>
           <TELL "It is Lady Ashworth's ring, and none of your business until she makes it so." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "You do not touch a widow's ring." CR>
           <RTRUE>)>>

<ROUTINE DETAIL-INVENTORY-ENTRY-F ()
    <COND (<VERB? READ> <SETG CABINET-CLUE-SEEN T> <TELL "In pencil beside the missing bottle: ‘tincture, private laboratory.’" CR>)
          (<VERB? RUB>
           <TELL "The pencil is soft and smudges easily. It was written quickly." CR>
           <RTRUE>)>>

<ROUTINE DETAIL-TEA-CARD-F ()
    <COND (<VERB? READ> <TELL "TEA FIRST. THEORIES AFTER." CR>)
          (<VERB? RUB>
           <TELL "The card is damp from the steam and limp in your fingers." CR>
           <RTRUE>)>>

<ROUTINE OUTSIDE-WINDOW-F ()
    <COND (<VERB? OPEN>
           <COND (<FSET? ,WINDOW ,OPENBIT> <TELL "The window is already open. You can step over the sill into the study." CR>)
                 (T <TELL "You press the sash. The rusty catch holds it shut on the study side." CR>)>)
          (<VERB? KNOCK>
           <TELL "You tap on the glass. No one is in the study to answer." CR>
           <RTRUE>)
          (<VERB? LOOK-INSIDE>
           <TELL "Through the clouded glass you can make out the dark shape of a desk and a pale line of chalk on the carpet." CR>
           <RTRUE>)>>

<ROUTINE KITCHEN-STAIRS-F ()
    <COND (<VERB? CLIMB-FOO CLIMB-DOWN> <DO-WALK ,P?DOWN>)
          (<VERB? LISTEN>
           <TELL "From below come the murmur of the kettle and the tick of the range." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The handrail is polished smooth by years of hands." CR>
           <RTRUE>)>>

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
                 (T <TELL "A clean shirt cuff pokes between the fastenings. Hudson has packed in a hurry." CR>)>)
          (<VERB? SMELL>
           <TELL "Clean linen and boot polish." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "The bag is Hudson's, and he is watching you." CR>
           <RTRUE>)>>

<ROUTINE TELEGRAM-STONE-F ()
    <COND
          (<VERB? LOOK-UNDER MOVE>
           <TELL "Only a pale, dry patch of gravel where the telegram lay." CR>
           <RTRUE>)
          (<VERB? KICK>
           <TELL "The stone skitters across the wet gravel and stops against the gatepost." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "It is smooth and cold, worn flat by the river before anyone brought it here." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You leave the stone by the gate. It has done its work." CR>
           <RTRUE>)>>

<ROUTINE HUDSON-SPOON-F ()
    <COND
          (<VERB? TAKE>
           <TELL "Hudson closes his hand around the spoon. “It is the household's, sir, not mine to give.”" CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "You do not have to. Hudson is rubbing it quite enough for both of you." CR>
           <RTRUE>)>>

<ROUTINE PANTRY-APPLES-F ()
    <COND
          (<VERB? SMELL>
           <TELL "Sweet and a little winey, the smell of apples kept too long." CR>
           <RTRUE>)
          (<VERB? EAT>
           <TELL "You resist. They belong to the household, and you have a murderer to find." CR>
           <RTRUE>)
          (<VERB? TAKE>
           <TELL "You leave the apples on their straw." CR>
           <RTRUE>)>>

<ROUTINE PANTRY-DUST-F ()
    <COND
          (<VERB? RUB>
           <TELL "The dust blackens your fingertip. It is very fine, like soot." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Charcoal has almost no smell, only a dry dustiness." CR>
           <RTRUE>)>>

<ROUTINE MOURNING-RIBBON-F ()
    <COND
          (<VERB? TAKE>
           <TELL "It is Lady Ashworth's mourning ribbon. You leave it where she laid it." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The silk is warm. She has been holding it." CR>
           <RTRUE>)>>

<ROUTINE MANOR-FACADE-F ()
    <COND
          (<VERB? LISTEN>
           <TELL "From the gate, the house is silent. No dog barks, and no one comes to the door." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Coal smoke drifts down from the chimneys and mixes with the fog." CR>
           <RTRUE>)>>

<ROUTINE DETAIL-ASHWORTH-CREST-F ()
    <COND
          (<VERB? RUB>
           <TELL "The iron hounds are cold and wet, their muzzles worn smooth by passing hands." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The crest rings dully under your knuckles." CR>
           <RTRUE>)>>

<ROUTINE DETAIL-LIT-WINDOW-F ()
    <COND
          (<VERB? LISTEN>
           <TELL "The window is too far away to hear anything through it." CR>
           <RTRUE>)
          (<VERB? KNOCK>
           <TELL "The window is at the end of the path, well out of reach from the gate." CR>
           <RTRUE>)>>

<ROUTINE DETAIL-CLEAN-CRYSTAL-F ()
    <COND
          (<VERB? RUB>
           <TELL "It hangs too high to reach without a chair." CR>
           <RTRUE>)
          (<VERB? LISTEN>
           <TELL "It ticks against its neighbour when the draught moves it." CR>
           <RTRUE>)>>

<ROUTINE STUDY-CHAIR-F ()
    <COND (<VERB? TAKE MOVE PUSH PULL>
           <TELL "You leave the chair where it was found. Lestrade will want to see how far it travelled." CR>
           <RTRUE>)
          (<VERB? CLIMB-ON CLIMB-FOO BOARD>
           <TELL "Sitting in a dead man's chair at the scene of his murder would tell you nothing and annoy Lestrade a great deal." CR>
           <RTRUE>)
          (<VERB? LOOK-UNDER>
           <TELL "Only the ridge of carpet the leg pushed up when it stopped at the hearth." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The leather is cold and creased where a heavy man sat for years." CR>
           <RTRUE>)>>

<ROUTINE DETAIL-FURROW-F ()
    <COND
          (<VERB? RUB>
           <TELL "The carpet pile is crushed flat along the furrow and stands up on either side." CR>
           <RTRUE>)>>

<ROUTINE DETAIL-COINS-F ()
    <COND
          (<VERB? TAKE>
           <TELL "They are somebody's wishes. You leave them where they fell." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The coins are cold and slimy with old rainwater." CR>
           <RTRUE>)>>

<ROUTINE RAKE-MARKS-F ()
    <COND
          (<VERB? RUB>
           <TELL "The kicked fan is loose under your hand. The others are rolled firm." CR>
           <RTRUE>)
          (<VERB? KICK>
           <TELL "You leave the marks as they are. Someone has already kicked one." CR>
           <RTRUE>)>>

<ROUTINE LEATHER-ROLL-F ()
    <COND
          (<VERB? SMELL>
           <TELL "Neatsfoot oil and steel." CR>
           <RTRUE>)
          (<VERB? RUB>
           <TELL "The leather is supple and well oiled, and soft at the folds." CR>
           <RTRUE>)>>

<ROUTINE KITCHEN-RANGE-F ()
    <COND (<VERB? RUB>
           <TELL "You hold a palm near the iron and take it back quickly. The range is hot." CR>
           <RTRUE>)
          (<VERB? SMELL>
           <TELL "Hot iron, coal and the black tea in the kettle." CR>
           <RTRUE>)
          (<VERB? OPEN>
           <TELL "The firebox is full of glowing coal. Hudson has banked it to last the night." CR>
           <RTRUE>)>>

<ROUTINE GARDEN-GREENHOUSE-F ()
    <COND (<VERB? ENTER> <DO-WALK ,P?NORTH>)
          (<VERB? KNOCK>
           <TELL "You tap a pane. Water runs down the glass and nobody answers." CR>
           <RTRUE>)
          (<VERB? LOOK-INSIDE>
           <TELL "Through the misted glass you can make out green leaves and a splash of purple." CR>
           <RTRUE>)>>
