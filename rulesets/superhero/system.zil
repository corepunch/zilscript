;"The superhero system's numbers: seven rank attributes and power, health
  from the physical ranks, karma from the mental ones, and a percentile rank
  table. No words and no setting; rulesets/superhero/<lang>.zil names them."

<CONSTANT A-FIGHTING 1>
<CONSTANT A-AGILITY 2>
<CONSTANT A-STRENGTH 3>
<CONSTANT A-ENDURANCE 4>
<CONSTANT A-REASON 5>
<CONSTANT A-INTUITION 6>
<CONSTANT A-PSYCHE 7>
<CONSTANT A-POWER 8>
<CONSTANT A-HEALTH 9>
<CONSTANT A-KARMA 10>

<GLOBAL SHEET-LAYOUT <LTABLE A-FIGHTING A-AGILITY A-STRENGTH A-ENDURANCE A-REASON A-INTUITION A-PSYCHE A-POWER A-HEALTH A-KARMA>>
<GLOBAL STATUS-LAYOUT <LTABLE A-HEALTH A-KARMA>>

;"Health is the sum of the physical ranks and starts full; karma is the sum
  of the mental ranks and has no ceiling."
<ROUTINE SYSTEM-DERIVE (TBL)
 <SET-RESOURCE .TBL ,A-HEALTH
  <+ <+ <STAT .TBL ,A-FIGHTING> <STAT .TBL ,A-AGILITY>> <+ <STAT .TBL ,A-STRENGTH> <STAT .TBL ,A-ENDURANCE>>>>
 <SET-RESOURCE .TBL ,A-KARMA ,NO-LIMIT>
 <SET-STAT .TBL ,A-KARMA
  <+ <+ <STAT .TBL ,A-REASON> <STAT .TBL ,A-INTUITION>> <STAT .TBL ,A-PSYCHE>>>>

;"One d100 against the attribute's rank; the difficulty is not used."
<ROUTINE SYSTEM-ROLL (TBL ATTR DIFFICULTY) <ROLL 1 100>>

;"Minimum and nominal rank, then cumulative green, yellow and red
  thresholds. The mortal rank ranges and odds come from the Advanced
  Players' Book; the cosmic entries are explicit, unshiftable bands.
  Rows are ordered from Shift 0 to Beyond. The original chart is not an
  asset of this project."
<CONSTANT FASERIP-ROW-SIZE 5>
<CONSTANT FASERIP-LAST-SHIFTABLE 13>
<CONSTANT FASERIP-LAST-COLUMN 17>
<CONSTANT FASERIP-BEYOND 10000>
<GLOBAL FASERIP-RANKS <TABLE
  0       0     66  95 100
  1       2     61  91 100
  3       4     56  86 100
  5       6     51  81  98
  8      10     46  76  98
  16     20     41  71  95
  26     30     36  66  95
  37     40     31  61  91
  46     50     26  56  91
  63     75     21  51  86
  88    100     16  46  86
  126   150     11  41  81
  176   200      7  41  81
  351   500      4  36  76
  1000 1000      2  36  76
  3000 3000      2  31  71
  5000 5000      2  26  66
  FASERIP-BEYOND FASERIP-BEYOND 2 21 61>>

<ROUTINE FASERIP-RANK-CELL (COLUMN FIELD)
 <GET ,FASERIP-RANKS <+ <* .COLUMN ,FASERIP-ROW-SIZE> .FIELD>>>

<ROUTINE FASERIP-COLUMN (RANK "AUX" (COLUMN ,FASERIP-LAST-COLUMN))
 <REPEAT ()
  <COND (<OR <0? .COLUMN> <NOT <L? .RANK <FASERIP-RANK-CELL .COLUMN 0>>>> <RETURN>)>
  <SET COLUMN <- .COLUMN 1>>>
 .COLUMN>

<ROUTINE FASERIP-SHIFT (COLUMN SHIFT "AUX" NEXT)
 <COND (<G? .COLUMN ,FASERIP-LAST-SHIFTABLE> .COLUMN)
       (T <SET NEXT <+ .COLUMN .SHIFT>>
          <COND (<L? .NEXT 0> 0)
                (<G? .NEXT ,FASERIP-LAST-SHIFTABLE> ,FASERIP-LAST-SHIFTABLE)
                (T .NEXT)>)>>

<ROUTINE FASERIP-CUTOFF (COLUMN TIER)
 <FASERIP-RANK-CELL .COLUMN <+ .TIER 1>>>

<ROUTINE FASERIP-TIER (COLUMN ROLL)
 <COND (<OR <L? .ROLL 1> <G? .ROLL 100>> 0)
       (<NOT <L? .ROLL <FASERIP-CUTOFF .COLUMN 3>>> 3)
       (<NOT <L? .ROLL <FASERIP-CUTOFF .COLUMN 2>>> 2)
       (<NOT <L? .ROLL <FASERIP-CUTOFF .COLUMN 1>>> 1)
       (T 0)>>

<ROUTINE RANK-TIER (RANK ROLL)
 <FASERIP-TIER <FASERIP-COLUMN .RANK> .ROLL>>

<ROUTINE SYSTEM-GRADE (TBL ATTR DIFFICULTY ROLL)
 <RANK-TIER <STAT .TBL .ATTR> .ROLL>>

;"Compare intensity to the effective column: 1/2/3 for green/yellow/red.
  If the scene opts in, a routine check may be automatic (0) or an
  extreme check impossible (4). High-stakes scenes can always roll."
<ROUTINE FASERIP-REQUIRED (COLUMN INTENSITY "OPTIONAL" AUTO? STRICT? "AUX" GAP)
 <SET GAP <- <FASERIP-COLUMN .INTENSITY> .COLUMN>>
 <COND (<AND .AUTO? <L? .GAP -3>> 0)
       (<AND .STRICT? <G? .GAP 1>> 4)
       (<G? .GAP 0> 3)
       (<0? .GAP> 2)
       (T 1)>>

;"The player opted in before rolling. The fixed solo policy spends the least
  possible to reach the target, with a minimum commitment of 10 (or the
  remaining pool). It never spends more than the pool or changes the RNG."
<ROUTINE FASERIP-KARMA-COST (HAVE ROLL CUTOFF "AUX" (COST 10))
 <COND (<L? .HAVE 1> <RETURN 0>)>
 <COND (<G? <- .CUTOFF .ROLL> .COST> <SET COST <- .CUTOFF .ROLL>>)>
 <COND (<G? .COST .HAVE> .HAVE) (T .COST)>>

<GLOBAL LAST-FEAT-RAW 0>
<GLOBAL LAST-FEAT-KARMA 0>
<GLOBAL LAST-FEAT-REQUIRED 0>
<GLOBAL LAST-FEAT-RANK 0>

;"An opposed feat is still one ordinary RPG roll. A book chooses where
  automatic/impossible outcomes and Karma are permitted; combat or other
  explicitly color-gated rolls may continue to use CHECK."
<ROUTINE FASERIP-FEAT (TBL ATTR INTENSITY "OPTIONAL" (SHIFT 0) AUTO? STRICT? KARMA? "AUX" COLUMN REQUIRED RAW SPENT TOTAL)
 <SET COLUMN <FASERIP-SHIFT <FASERIP-COLUMN <STAT .TBL .ATTR>> .SHIFT>>
 <SET REQUIRED <FASERIP-REQUIRED .COLUMN .INTENSITY .AUTO? .STRICT?>>
 <SETG LAST-FEAT-REQUIRED .REQUIRED>
 <SETG LAST-FEAT-RANK <FASERIP-RANK-CELL .COLUMN 1>>
 <SETG LAST-FEAT-RAW 0>
 <SETG LAST-FEAT-KARMA 0>
 <COND (<EQUAL? .REQUIRED 0 4>
        <SETG LAST-ROLL 0>
        <SETG LAST-TIER 0>
        <REPORT-FEAT-GATE .REQUIRED>
        <COND (<0? .REQUIRED> <RTRUE>) (T <RFALSE>)>)>
 <SET RAW <SYSTEM-ROLL .TBL .ATTR .INTENSITY>>
 <SET SPENT 0>
 <COND (.KARMA?
        <SET SPENT <FASERIP-KARMA-COST <STAT .TBL ,A-KARMA> .RAW <FASERIP-CUTOFF .COLUMN .REQUIRED>>>
        <COND (<NOT <0? .SPENT>> <SPEND .TBL ,A-KARMA .SPENT>)>)>
 <SET TOTAL <+ .RAW .SPENT>>
 <COND (<G? .TOTAL 100> <SET TOTAL 100>)>
 <SETG LAST-FEAT-RAW .RAW>
 <SETG LAST-FEAT-KARMA .SPENT>
 <SETG LAST-ROLL .TOTAL>
 <SETG LAST-TIER <FASERIP-TIER .COLUMN .TOTAL>>
 <REPORT-FEAT .TBL .ATTR .INTENSITY .SHIFT .REQUIRED .RAW .SPENT .TOTAL ,LAST-TIER>
 <COND (<L? ,LAST-TIER .REQUIRED> <RFALSE>) (T <RTRUE>)>>

<ROUTINE FASERIP-RANK-NAME (COLUMN)
 <TELL <GET ,FASERIP-RANK-NAMES .COLUMN>>
 <TAKE-OUTPUT>>

;"The generic sheet keeps its existing fields. Extra rows describe the
  actual live data; nothing guesses untracked tabletop values."
<ROUTINE FASERIP-SHEET-ROW (TBL ATTR "AUX" LABEL VALUE)
 <ATTR-NAME .ATTR>
 <SET LABEL <TAKE-OUTPUT>>
 <SET VALUE <STAT .TBL .ATTR>>
 <COND (<L? .ATTR ,A-POWER>
        <SHEET-ROW .LABEL .VALUE 0 "abilities" <FASERIP-RANK-NAME <FASERIP-COLUMN .VALUE>>>)
       (<==? .ATTR ,A-POWER>
        <SHEET-ROW .LABEL .VALUE 0 "powers" <FASERIP-RANK-NAME <FASERIP-COLUMN .VALUE>>>)
       (T <SHEET-ROW .LABEL .VALUE
                  <COND (<CEILING? .TBL .ATTR> <MAX-STAT .TBL .ATTR>) (T 0)>
                  "resources">)>>
