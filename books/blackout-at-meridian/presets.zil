;"Save identity, not parser vocabulary or display text. Keep IDs stable if a
  translation changes or the setup view reorders its cards."
<CONSTANT PRESET-BULWARK "bulwark">
<CONSTANT PRESET-ARC "arc">
<CONSTANT PRESET-LENS "lens">

;"The three profiles: starting ranks for Fighting, Agility, Strength,
  Endurance, Reason, Intuition, Psyche and Power."
<GLOBAL BULWARK-RANKS <LTABLE 30 10 40 40 6 10 10 30>>
<GLOBAL ARC-RANKS <LTABLE 20 40 10 20 20 20 10 40>>
<GLOBAL LENS-RANKS <LTABLE 10 20 10 20 40 30 20 30>>

<GLOBAL MERIDIAN-PRESETS <LTABLE <TABLE ,PRESET-BULWARK BULWARK-RANKS>
                         <TABLE ,PRESET-ARC ARC-RANKS>
                         <TABLE ,PRESET-LENS LENS-RANKS>>>

<ROUTINE RPG-PRESET-TITLE (INDEX)
 <COND (<==? .INDEX 1> <MSG-CLASS-BULWARK>)
       (<==? .INDEX 2> <MSG-CLASS-ARC>)
       (T <MSG-CLASS-LENS>)>>

<ROUTINE RPG-PRESET-SUMMARY (INDEX)
 <COND (<==? .INDEX 1> <MSG-PROFILE-VANGUARD>)
       (<==? .INDEX 2> <MSG-PROFILE-ARC>)
       (T <MSG-PROFILE-LENS>)>>
