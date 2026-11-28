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

;"Percentile cutoffs derived from documented cumulative outcome probabilities
  for the historical standard ranks. No original chart or prose reproduced.
  Nonstandard ranks are rounded down to the nearest supported standard rank.
  Tier 0 failure, 1 success, 2 strong success, 3 exceptional success."
<ROUTINE RANK-TIER (RANK ROLL "AUX" GREEN YELLOW RED)
 <COND (<NOT <L? .RANK 1000>> <SET GREEN 6> <SET YELLOW 36> <SET RED 76>)
       (<NOT <L? .RANK 150>> <SET GREEN 11> <SET YELLOW 41> <SET RED 81>)
       (<NOT <L? .RANK 100>> <SET GREEN 16> <SET YELLOW 46> <SET RED 86>)
       (<NOT <L? .RANK 75>> <SET GREEN 21> <SET YELLOW 51> <SET RED 86>)
       (<NOT <L? .RANK 50>> <SET GREEN 26> <SET YELLOW 56> <SET RED 91>)
       (<NOT <L? .RANK 40>> <SET GREEN 31> <SET YELLOW 61> <SET RED 91>)
       (<NOT <L? .RANK 30>> <SET GREEN 36> <SET YELLOW 66> <SET RED 95>)
       (<NOT <L? .RANK 20>> <SET GREEN 41> <SET YELLOW 71> <SET RED 95>)
       (<NOT <L? .RANK 10>> <SET GREEN 46> <SET YELLOW 76> <SET RED 98>)
       (<NOT <L? .RANK 6>> <SET GREEN 51> <SET YELLOW 81> <SET RED 98>)
       (<NOT <L? .RANK 4>> <SET GREEN 56> <SET YELLOW 86> <SET RED 100>)
       (<NOT <L? .RANK 2>> <SET GREEN 61> <SET YELLOW 91> <SET RED 100>)
       (T <SET GREEN 66> <SET YELLOW 96> <SET RED 100>)>
 <COND (<NOT <L? .ROLL .RED>> 3)
       (<NOT <L? .ROLL .YELLOW>> 2)
       (<NOT <L? .ROLL .GREEN>> 1)
       (T 0)>>

<ROUTINE SYSTEM-GRADE (TBL ATTR DIFFICULTY ROLL)
 <RANK-TIER <STAT .TBL .ATTR> .ROLL>>
