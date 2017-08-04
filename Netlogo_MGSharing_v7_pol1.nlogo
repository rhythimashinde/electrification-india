globals [consumer-microgrid replacement-cost-microgrid counter microgrid-profit profit-consumer-high profit-consumer-low ratio low-ratio mid-ratio per-shops per-bf per-sf profit-battery investment-month maximum-batteries-sold producers non-producers consumers non-consumers]

breed [households a-household]
breed [manufacturer a-manufacturer]
breed [government a-government]
breed [village-committee a-village-committee]
breed [energy-provider a-energy-provider]

households-own [demand-rise-house caste children? employement agentset-connected income-first profitable-producer energy role agentset-consumer profit my-producer]
energy-provider-own [profit-microgrid energy  agentset-consumer]

to setup
  clear-all
  setup-houses
  reset-ticks
end

to go
  appoint-producer
  sell-energy
  tick-advance 1
end

to setup-houses
  ; create 3 types of households based on the castes
  set low-ratio 0.3 set mid-ratio 0.4
  create-households population
  ask n-of (population * low-ratio) households [
    set caste "low"
    ask other households [
      if caste = 0 [
        ask n-of (population * mid-ratio) households [
          set caste "mid"
          ask other households [
            if caste = 0 [
              set caste "high"]]]]]]

  ; set the view, locations and employement parameters of different castes in the model
  ask households[
    if caste = "low" [
      set per-shops 0.03
      set per-bf 0.02 set per-sf 0.85
      set ratio low-ratio
      set color 88
      set shape "house"
      setxy (random-float (world-height / 2)) (random-float (world-height / 2))]
    if caste = "mid" [
      set per-shops 0.03 set per-bf 0.22 set per-sf (1 - per-shops - per-bf)
      set ratio mid-ratio
      set color 96
      set shape "house"
      setxy (- random-float (world-height / 2)) (random-float (world-height / 2))]
    if caste = "high" [
      set per-shops 0.03
      set per-bf 0.90 set per-sf (1 - per-shops - per-bf)
      set ratio (1 - low-ratio - mid-ratio)
      set color 103 set shape "house"
      setxy random-xcor ( - random-float (world-height / 2))]]

  ; set other properties of the households
  ask n-of (0.7 * population * ratio) households [
    set children? "y"]

  ; setup employement of the households
  ask n-of (round (per-sf * ratio * population)) households [
    set employement "Farmer-Daily-wage"
    ask other households [
      if employement = 0 [
      ask n-of (round (per-bf * ratio * population)) households [
        set employement "Big-farmer"
        ask other households [
          if employement = 0 [
            ask n-of (round (per-shops * ratio * population)) households [
              set employement "Shopkeeper"
              ask other households [
                if employement = 0 [
                  ask n-of (round (population * ratio * (1 - per-shops - per-bf - per-sf))) households [
                    set employement "Forestry"]]]]]]]]]]

  ask households [
    ; setup connections of the households
    ifelse employement = "Shopkeeper" [
      set agentset-connected (other households in-radius 10)] [
      set agentset-connected (other households in-radius 5)]

    ; setup income of the households
    ifelse employement = "Shopkeeper" OR employement = "Big-farmer" [
      set income-first "y"][
      set income-first "n"]

    ; setup expected profitability of the households (expected that a consumer remains a consumer for 15 days in a month)
    set profit-battery 1.5
    set investment-month 1600
    ifelse count agentset-connected * profit-battery * 15 >= investment-month [
      set profitable-producer "y" ][
      set profitable-producer "n"]]

  create-energy-provider energy-providing-companies
  ask energy-provider [
    set shape "box"
    set energy 20
    set color (39 - energy)
    set agentset-consumer (n-of 2 households in-radius 10 with [children? = "y"])]
end

to appoint-producer
  set maximum-batteries-sold 7

  ;subsidy-effect
  if subsidy-rooftop [
    ask households [
      set income-first "y"]]

  ask households [
    set producers households with [income-first = "y" AND profitable-producer = "y"]
    ask producers [
      set energy random maximum-batteries-sold
      set role "producer"
      set color (39 - energy)
      set pcolor (white)
      set size 1
      set agentset-consumer (agentset-connected with [children? = "y" AND role != "producer"])]

    set non-producers (households with [income-first = "n" OR profitable-producer = "n"])
    ask non-producers [
      set pcolor black
      set color blue]]
end

to sell-energy
  set consumers 0
  ask producers with [agentset-consumer = 0][
      ask agentset-connected [
        let close-neighbors other min-n-of 5 households [distance myself]
        set agentset-consumer close-neighbors with [energy >= 1]]]
  ask producers with [agentset-consumer != 0][
      ask agentset-connected with [agentset-consumer != 0] [
        let close-neighbors other min-n-of 5 households [distance myself]
        set agentset-consumer (turtle-set agentset-consumer close-neighbors with [energy >= 1])]]

      ; decresing energy of the producer and making profit
  ask producers[
      ifelse (energy - (count agentset-consumer * demand-rise)) <= 0 [
        set energy (energy - (count agentset-consumer * demand-rise))] [
        set energy 0]
      set color (39 - energy)
      set pcolor white
      set size 1
      set profit (profit-battery * count agentset-consumer)
      let producer-who self

      ;increasing energy of the consumer and show it on the interface
      ask agentset-consumer [
        set role "consumer"
        set pcolor black
        set color green
        set energy (energy + (1 * demand-rise))
        ifelse energy < 3 [
          set size (energy + 1)][
          set size 3]
        set my-producer producer-who ]

      ; give and take batteries back
      if ticks mod 12 = 0 [
        if agentset-consumer != 0 [
          ask min-n-of (0.5 * count agentset-consumer) agentset-consumer [who] [
            set energy (energy - (1 * demand-rise))
            ask my-producer [set energy (energy + (1 * demand-rise))]]]]

      set consumers (count agentset-consumer + consumers)

    create-links-with agentset-consumer]

  ask non-producers with [role = 0] [
    set color pink
    let me self
    ask other min-n-of 5 households [distance myself] [
      if role = "producer" [
        set agentset-consumer (turtle-set agentset-consumer me) ]]]

  set non-consumers (non-producers with [role = 0])
  if ticks > 50 [
    ask n-of (0.5 * count non-consumers) non-consumers [
      let me self
      ask energy-provider [
        set agentset-consumer (turtle-set agentset-consumer me)]]]

  ask energy-provider [
    if agentset-consumer != NOBODY [
      set consumer-microgrid count agentset-consumer]]

    ;upgrade the connectivity and the income based on the appointment and selling process
    upgrade-connectivity
    upgrade-income
    check-margin
    replace-components
end

to upgrade-connectivity
  ask households with [role = 0] [
    if (one-of agentset-connected with [role = "consumer"]) != NOBODY [
      let me self
      ask a-household my-producer [
        if agentset-consumer != 0 [
          set agentset-consumer (turtle-set agentset-consumer me)]]]]
end

to upgrade-income
  ask households with [role = "consumer"][
    if energy > 25 * maximum-batteries-sold [
      set profitable-producer "y"
      set income-first "y"]
    set demand-rise-house (demand-rise-house + demand-rise)
    if demand-rise-house > 20 [
      let me self
      ask my-producer [
        set agentset-consumer agentset-consumer with [self != myself]]
       ask energy-provider [
        set agentset-consumer (turtle-set agentset-consumer me)
        create-links-with agentset-consumer
        set profit-microgrid (profit-consumer-high * (count agentset-consumer - counter))
        set microgrid-profit profit-microgrid
        set replacement-cost-microgrid 1000
        set consumer-microgrid count agentset-consumer]]]

  if microgrid-profit > 1000 [
    if non-consumers != 0 [
      ask n-of (0.4 * count non-consumers) non-consumers [
        let me-new self
        ask energy-provider [
          let counter-old count agentset-consumer
          set agentset-consumer (turtle-set agentset-consumer me-new)
          let counter-new count agentset-consumer
          set counter (counter-new - counter-old)
          set profit-microgrid (profit-consumer-low * counter)
          set microgrid-profit profit-microgrid
          set replacement-cost-microgrid 1500
          set consumer-microgrid count agentset-consumer]]]]
end

to check-margin
  if count non-producers != 0 [
    if (count producers / count non-producers) < 1 [
      ask n-of (0.2 * count non-producers) non-producers [
        set income-first "y" set profitable-producer "y"]]]
end

to replace-components
  ifelse count producers = 0 [][
  ask one-of producers [
    let replacement-cost random 100
    set profit (profit - replacement-cost)
    if profit < 0 [
      set income-first "n"
          set profitable-producer "n"]]]
end
@#$#@#$#@
GRAPHICS-WINDOW
432
10
973
552
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-20
20
-20
20
1
1
1
ticks
30.0

BUTTON
6
10
69
43
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
80
11
260
44
Population
Population
1
1000
395.0
1
1
NIL
HORIZONTAL

BUTTON
6
55
70
88
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
268
12
411
45
subsidy-rooftop
subsidy-rooftop
1
1
-1000

SLIDER
81
55
259
88
manufacturing-companies
manufacturing-companies
0
4
1.0
1
1
NIL
HORIZONTAL

SLIDER
82
107
258
140
energy-providing-companies
energy-providing-companies
0
4
1.0
1
1
NIL
HORIZONTAL

MONITOR
2
153
70
198
Producers
count producers
17
1
11

BUTTON
4
107
69
140
go once
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
82
153
256
198
Transactions
consumers
17
1
11

SLIDER
267
55
406
88
demand-rise
demand-rise
0
10
1.0
1
1
NIL
HORIZONTAL

MONITOR
84
203
258
248
Consumers of microgrid
consumer-microgrid
17
1
11

@#$#@#$#@
## WHAT IS IT?

This model is trying to study that how energy sharing is happening in rural India in case of sharing of the batteries by the people. 

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="experiment" repetitions="5" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="300"/>
    <metric>count producers</metric>
    <metric>consumers</metric>
    <metric>consumer-microgrid</metric>
    <enumeratedValueSet variable="manufacturing-companies">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="subsidy-rooftop">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Population">
      <value value="395"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="demand-rise">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="energy-providing-companies">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="experiment" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>consumers</metric>
    <metric>count producers</metric>
    <metric>consumer-microgrid</metric>
    <metric>microgrid-profit</metric>
    <enumeratedValueSet variable="manufacturing-companies">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="subsidy-rooftop">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Population">
      <value value="395"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="demand-rise">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="energy-providing-companies">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
