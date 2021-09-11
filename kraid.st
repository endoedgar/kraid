;---------------------------------------------------------------------------
; Format:
; [Statedef STATENO]
; type = ?      S/C/A/L  stand/crouch/air/liedown
; movetype = ?  I/A/H    idle/attack/gethit
; physics = ?   S/C/A/N  stand/crouch/air/none
; juggle = ?             air juggle points move requires
;
; [State STATENO, ?]     ? - any number you choose
; type = ?
; ...

;---------------------------------------------------------------------------
; Lose by Time Over
; CNS difficulty: basic
[Statedef 170]
type = S
ctrl = 0
anim = 170
velset = 0,0

[State 170, 1]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

;---------------------------------------------------------------------------
; Win state decider
; CNS difficulty: basic
[Statedef 180]
type = S

[State 180, 1]
type = ChangeState
trigger1 = Time = 0
value = 181

;---------------------------------------------------------------------------
; Win pose 1
; CNS difficulty: basic
[Statedef 181]
type = S
ctrl = 0
anim = 180
velset = 0,0

[State 181, 1]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

;---------------------------------------------------------------------------
; Introduction
; CNS difficulty: basic
[Statedef 190]
type = S
ctrl = 0
anim = 190
velset = 0,0

[State 190, 1] ;Freeze animation until PreIntro is over
type = ChangeAnim
trigger1 = RoundState = 0
value = 190

[State 190, 2] ;Assert this until you want "round 1, fight" to begin
type = AssertSpecial
trigger1 = 1
flag = Intro

[State 190, 4] ;Change to stand state
type = ChangeState
trigger1 = AnimTime = 0
value = 0

;---------------------------------------------------------------------------
; Taunt
; CNS difficulty: easy
[Statedef 195]
type = S
ctrl = 0
anim = 195
velset = 0,0
movetype = I
physics = S
sprpriority = 2

[State 195, 2]
type = ChangeState
trigger1 = AnimTime = 0
value = 0
ctrl = 1

[Statedef 200]
type = S
physics = N
movetype = H

[State 200, VarSet]
type = VarSet
trigger1 = GetHitVar(hittime)
v = 10
value = GetHitVar(hittime)
ignorehitpause = 1

[State 200, ChangeState]
type = ChangeState
trigger1 = time
value = 0
ctrl = 1

[Statedef 999]
type = S
physics = N
movetype = I

[State 999, VarSet]
type = VarSet
triggerall = numhelper(1002) && numhelper(1001) && prevstateno != stateno
trigger1 = helper(1002), var(0) > 1 && helper(1001), var(10) = 1
v = 0
value = 1
ignorehitpause = 1

[State 999, ChangeAnim]
type = ChangeAnim
triggerall = numhelper(1002) && time && prevstateno != stateno
triggerall = helper(1002), var(0) = 2 || helper(1002), var(0) = 4
trigger1 = anim = 1
value = 7
ignorehitpause = 1

[State 999, HitOverride]
type = HitOverride
trigger1 = !time
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
stateno = stateno
time = -1

[State 999, ChangeState]
type = ChangeState
triggerall = time > 1 && numhelper(1001)
trigger1 = helper(1001), var(10) != 1
value = 1000

; Cabeça
; var(0)
; 0 - Boca Fechada
; 1 - Boca Aberta
[Statedef 1000]
type = S
physics = N
movetype = I
velset = 0,0

[State 1000, Helper]
type = Helper
trigger1 = !numhelper(1006) && !root, alive
helpertype = normal
name = "Black"
ID = 1006
stateno = 1006
pos = 0,0
postype = left
facing = 1
keyctrl = 0
ownpal = 1
ignorehitpause = 1
size.xscale = 65535
size.yscale = 65535

[State 1000, AssertSpecial]
type = AssertSpecial
trigger1 = pos y > 0
flag = noshadow

[State 1000, Helper]
type = Helper
trigger1 = !numhelper(1001) && root, Alive
helpertype = normal
name = "Olhos"
ID = 1001
stateno = 1001
pos = 0,0
postype = p1
facing = 1
keyctrl = 0
ownpal = 1

[State 1000, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = numhelper(1001)
text = "var(0) = %d var(1) = %d"
params = var(0), var(1)
ignorehitpause = 1

[State 1000, HitOverride]
type = HitOverride
trigger1 = !time
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
stateno = 999
time = -1

[State 1000, ChangeAnim]
type = ChangeAnim
triggerall = anim != 2 && anim != 3 && anim != 4
trigger1 = var(0) = 1
trigger1 = numhelper(1001)
trigger1 = helper(1001), var(10) = 2
trigger2 = var(0) = 1
trigger2 = var(1) || !root, alive
value = 2
ignorehitpause = 1

[State 1000, PlaySnd]
type = PlaySnd
trigger1 = anim = 2 && animelemtime(1) = 1 && root, alive
value = S0,0
volume = 0
channel = -1
freqmul = 1.0
loop = 0
pan = 0
ignorehitpause = 1

[State 1000, ChangeAnim]
type = ChangeAnim
trigger1 = var(0) = 1 && anim = 2 && animtime = 0
value = 3
ignorehitpause = 1

[State 1000, VarSet]
type = VarSet
trigger1 = anim = 3 && animtime = 0
v = 0
value = 0

[State 1000, ChangeAnim]
type = ChangeAnim
trigger1 = var(0) = 0 && anim != 4 && anim != 1 && root, alive
value = 4
ignorehitpause = 1

[State 1000, ChangeAnim]
type = ChangeAnim
trigger1 = anim = 4 && animtime = 0
value = 1
ignorehitpause = 1

[State 1000, PosSet]
type = BindToParent
trigger1 = !time
pos = 0, 0
time = -1
ignorehitpause = 1

[State 1000, VarSet]
type = VarSet
trigger1 = !var(0) && var(1)
v = 1
value = 0

[State 1000, VarSet]
type = VarSet
triggerall = root, alive && numhelper(1002) && roundstate = 2
trigger1 = root, command = "b" && helper(1002), var(0) = 2 && !var(0)
v = 1
value = 1

[State 1000, VarSet]
type = VarSet
triggerall = !var(0)
trigger1 = root, alive && numhelper(1003) && roundstate = 2
trigger1 = var(1) = 1 && helper(1002), var(0) = 2
trigger2 = !root, alive
v = 0
value = 1

[State 1000, Projectile]
type = Projectile
trigger1 = anim = 3 && var(1) && time % 6 = 0
ProjID = 2001
projanim = 2001 + random % 2
projhitanim = -1
projremanim = -1
projcancelanim = -1
projscale = 1,1
projremove = 1
projremovetime = -1
velocity = ((4000.0+(random%8000))/1000.0)*Const(size.xscale),((-(200+random%500))/100.0)*Const(size.yscale)
remvelocity = 0,0
accel = 0, Const(movement.yaccel)
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 0
projedgebound = 40
projstagebound = 40
projheightbound = -240
offset = 0,floor(-240*Const(size.yscale))
postype = p1
projshadow = -1,-1,-1
; HitDef
attr = S,SP        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MAF        ;HLAFD+-
guardflag = MA         ;HLA
getpower = 5,2
givepower = 15,10
animtype = light          ;light,medium,hard,back,up,diagup
air.animtype = light
priority = 4,Hit   ;Hit,Miss,Dodge
damage = 20,5
pausetime = 10,0
sparkno = 0
guard.sparkno = 0
sparkxy = 0,0
hitsound = 5,4
guardsound = 6,0
ground.type = High      ;Low,Trip,None
ground.slide = 0
ground.hittime = 30
air.hittime = 20
ground.velocity = 0,0
air.velocity = 0,0
sprpriority = 1
p1getp2facing = 0
fall = 0
fall.yvelocity = -4.5
fall.recover = 1
fall.recovertime = 4
fall.damage = 0
down.bounce = 0
kill = 1
guard.kill = 1
fall.kill = 1
numhits = 1

[State 1000, DestroySelf]
type = DestroySelf
trigger1 = !root, alive && !numhelper(1002)
ignorehitpause = 1

; Olhos
; var(0)
; 0 - No Damage
; >0 - Piscar
; var(10)
; 0 - No damaged
; 1 - Damaged
; 2 - Gritando
[Statedef 1001]
type = S
physics = N
movetype = I
velset = 0,0
anim = 998

[State 1001, AssertSpecial]
type = AssertSpecial
trigger1 = pos y > 0
flag = noshadow

[State 1001, PalFX]
type = PalFX
triggerall = root, var(10)
trigger1 = root, var(10) % 2 = 0
time = 1
add = 255,255,255
mul = 256,256,256
invertall = 0
color = 256
ignorehitpause = 1

[State 1001, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "var(10) = %d fvar(0) = %f"
params = var(10), fvar(0)
ignorehitpause = 1

[State 1001, VarSet]
type = VarSet
triggerall = numhelper(1000) && !var(10)
trigger1 = helper(1000), stateno = 999 && helper(1000), anim = 1
v = 10
value = 1
ignorehitpause = 1

[State 1001, VarSet]
type = VarSet
triggerall = numhelper(1000) && numhelper(1002)
trigger1 = helper(1002), var(0) > 1
trigger1 = helper(1000), stateno = 999 && helper(1000), time <= 1 && fvar(0) <= 0 && helper(1000), anim = 1
fv = 0
value = PI
ignorehitpause = 1

[State 1001, VarSet]
type = VarSet
triggerall = numhelper(1000) && var(10) = 1
trigger1 = fvar(0) <= 0 && parent, anim = 7
v = 10
value = 2
ignorehitpause = 1

[State 1001, VarSet]
type = VarSet
triggerall = numhelper(1000) && var(10) = 2
trigger1 = fvar(0) <= 0 && parent, anim = 1
v = 10
value = 0
ignorehitpause = 1

[State 1001, PalFX]
type = PalFX
trigger1 = fvar(0) > 0
time = 1
add = floor(abs(cos(fvar(0)+PI/2))*255),floor(abs(cos(fvar(0)+PI/2))*255),0
mul = 256,256,256
color = 256

[State 1001, VarAdd]
type = VarAdd
trigger1 = fvar(0) > 0
fv = 0
value = -0.05
ignorehitpause = 1

[State 1001, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
stateno = stateno
time = 1

[State 1001, PosSet]
type = BindToParent
trigger1 = !time
pos = 0, 0
time = -1
ignorehitpause = 1

[State 1001, ChangeAnim]
type = ChangeAnim
triggerall = numhelper(1000)
trigger1 = helper(1000), anim = 2
value = 999
elem = helper(1000), animelemno(0)
ignorehitpause = 1

[State 1001, ChangeAnim]
type = ChangeAnim
triggerall = numhelper(1000)
trigger1 = helper(1000), anim = 3
value = 1000
elem = helper(1000), animelemno(0)
ignorehitpause = 1

[State 1001, ChangeAnim]
type = ChangeAnim
triggerall = numhelper(1000)
trigger1 = helper(1000), anim = 4
value = 1001
elem = helper(1000), animelemno(0)
ignorehitpause = 1

[State 1001, ChangeAnim]
type = ChangeAnim
triggerall = numhelper(1000)
trigger1 = helper(1000), anim = 1
value = 998
elem = helper(1000), animelemno(0)
ignorehitpause = 1

[State 1001, ChangeAnim]
type = ChangeAnim
triggerall = numhelper(1000)
trigger1 = helper(1000), anim = 7
value = 1002
elem = helper(1000), animelemno(0)
ignorehitpause = 1

[State 1001, DestroySelf]
type = DestroySelf
trigger1 = !numhelper(1000)
ignorehitpause = 1

; Corpo
; var(0)
; 0 - Oculto
; 1 - Subir para o round
; 2 - Meio Corpo
; 3 - Subir completamente
; 4 - Completamente subido
; fvar(0), fvar(1), var(1)
; tmp
[Statedef 1002]
type = S
physics = N
movetype = I
anim = 15

[State 1002, AssertSpecial]
type = AssertSpecial
trigger1 = pos y > 0
flag = noshadow

[State -2, Helper]
type = Helper
trigger1 = !numhelper(1000) && root, Alive
helpertype = normal
name = "Cabeça"
ID = 1000
stateno = 1000
pos = 0,0
postype = p1
facing = 1
keyctrl = 0
ownpal = 0

[State -2, Helper]
type = Helper
trigger1 = !numhelper(1003) && root, Alive
helpertype = normal
name = "Perna"
ID = 1003
stateno = 1003
pos = 0,0
postype = p1
facing = 1
keyctrl = 0
ownpal = 0

[State -2, Helper]
type = Helper
trigger1 = !numhelper(1004) && root, Alive
helpertype = normal
name = "Mao"
ID = 1004
stateno = 1004
pos = 0,0
postype = p1
facing = 1
keyctrl = 0
ownpal = 0

[State 1002, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = roundstate = 2
text = "var(0) = %d"
params = var(0)
ignorehitpause = 1

[State 1003, AssertSpecial]
type = AssertSpecial
trigger1 = !var(0)
flag = nomusic
ignorehitpause = 1

[State 1003, AssertSpecial]
type = AssertSpecial
trigger1 = var(0) != 2 && var(0) != 4
flag = timerfreeze
ignorehitpause = 1

[State 1002, VarSet]
type = VarSet
trigger1 = !var(0) && roundstate = 2 && time >= 600
v = 0
value = 1
ignorehitpause = 1

[State 1002, PosAdd]
type = VelSet
trigger1 = var(0) = 1 && pos y > 140*Const(size.yscale)
trigger2 = var(0) = 3 && pos y > 0
trigger3 = !root, alive && pos y < 285*Const(size.yscale)
y = ifelse(root, alive, -0.6, 1)*Const(size.yscale)
ignorehitpause = 1

[State 1002, PlaySnd]
type = PlaySnd
trigger1 = time % 10 = 0 && vel y < 0
value = S0,1
channel = -1
ignorehitpause = 1

[State 1002, VarSet]
type = VarSet
trigger1 = var(0) = 1 && pos y <= floor(140*Const(size.yscale))
trigger2 = var(0) = 3 && pos y <= 0
v = 0
value = ifelse(var(0) = 1, 2, 4)
ignorehitpause = 1

[State 1002, VelSet]
type = VelSet
trigger1 = var(0) != 1 && var(0) != 3 && root, alive
trigger2 = !root, alive && pos y >= 285*Const(size.yscale)
y = 0
ignorehitpause = 1

[State 1002, Turn]
type = Turn
trigger1 = facing != parent, facing
ignorehitpause = 1

[State 1002, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
stateno = stateno
time = 1

[State 1002, PosSet]
type = PosSet
trigger1 = !time && !var(0)
y = floor(510*Const(size.yscale))
ignorehitpause = 1

[State 1002, VarSet]
type = VarSet
triggerall = var(0) = 1 || var(0) = 3
trigger1 = numexplod(id+var(1)) <= 0
fv = 0
value = (-Const(size.ground.back) + (random % (Const(size.ground.back)+Const(size.ground.front))))*facing
ignorehitpause = 1

[State 1002, VarSet]
type = VarSet
triggerall = var(0) = 1 || var(0) = 3
trigger1 = numexplod(id+var(1)) <= 0
fv = 1
value = -(random%100)
ignorehitpause = 1

[State 1002, EnvShake]
type = EnvShake
triggerall = time % 10 = 0
trigger1 = var(0) = 1 || var(0) = 3
trigger2 = abs(vel x) >= 0.1*Const(size.xscale)
trigger3 = !root, alive && pos y < 285*Const(size.yscale)
time = 10
freq = 60
ampl = -4
phase = 90
ignorehitpause = 1

[State 1002, Explod]
type = Explod
triggerall = root, alive && var(0) = 1 || var(0) = 3
trigger1 = numexplod(id+var(1)) < 4
anim = 2000
ID = id+var(1)
pos = floor(fvar(0)*Const(size.xscale)),floor(-pos y+(fvar(1)*Const(size.yscale)))
postype = p1
random = 20,20
removetime = -2
scale = 1,1
sprpriority = 5
ontop = 0
shadow = 0,0,0
ownpal = 1
removeongethit = 0
ignorehitpause = 1

[State 1002, Explod]
type = Explod
triggerall = root, alive && var(0) = 1 || var(0) = 3
trigger1 = time % 4 = 0
anim = 2001+random%2
ID = id+8000
pos = 0,floor(-pos y)
postype = p1
vel = ((-2000+(random%4000))/1000)*Const(size.xscale),(-(5+random%3))*Const(size.yscale)
accel = 0, Const(movement.yaccel)
random = 200,20
removetime = 80
scale = 1,1
sprpriority = 5
ontop = 0
shadow = 0,0,0
ownpal = 1
removeongethit = 0
ignorehitpause = 1

[State 1002, VarAdd]
type = VarAdd
trigger1 = numexplod(id+var(1)) >= 4
v = 1
value = 1
ignorehitpause = 1

[State 1002, VarSet]
type = VarSet
trigger1 = var(0) = 2 && roundstate = 2 && root, life <= (root, lifemax*0.7)
v = 0
value = 3
ignorehitpause = 1

[State 1002, VelSet]
type = VelSet
triggerall = numhelper(1003)
trigger1 = helper(1003), anim = 1102 || helper(1003), anim = 1103
x = (1.3*helper(1003), var(0))*Const(size.xscale)
ignorehitpause = 1

[State 1002, VelSet]
type = VelSet
triggerall = numhelper(1003)
trigger1 = helper(1003), anim != 1102 && helper(1003), anim != 1103
x = 0
ignorehitpause = 1

[State 1002, Helper]
type = Helper
triggerall = roundstate = 2 && root, Alive && numhelper(1009) < 3 && var(0) = 4 && gametime % 360 >= 180
trigger1 = numhelper(1009) = 0 && gametime % 180 = 0
trigger2 = numhelper(1009) = 1 && gametime % 180 = 60
trigger3 = numhelper(1009) = 2 && gametime % 180 = 120
helpertype = normal
name = "WTF is this?"
ID = 1009
stateno = 1009
pos = -9999, -9999
postype = left
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)
size.ground.back = 7
size.ground.front = 7
size.air.back = 7
size.air.front = 7
size.height = 10
size.head.pos = 0,0
size.mid.pos = 0,0

[State 1002, DestroySelf]
type = DestroySelf
trigger1 = !root, alive && pos y >= 285*Const(size.yscale)
ignorehitpause = 1


; Perna
; var(0)
; 0 - Parado
; 1 - Andar para frente
; 2 - Andar para trás
[Statedef 1003]
type = S
physics = N
movetype = I
anim = 1100
sprpriority = 1

[State 1003, PlaySnd]
type = PlaySnd
trigger1 = anim = 1101 && animtime = 0
trigger2 = anim = 1103 && animelem = 1
freq = 0.3
value = S0,1
ignorehitpause = 1

[State 1003, AssertSpecial]
type = AssertSpecial
trigger1 = pos y > 0
flag = noshadow

[State 1003, Helper]
type = Helper
trigger1 = !numhelper(1005) && root, Alive
helpertype = normal
name = "AuxiliHelper"
ID = 1005
stateno = 1005
pos = 0,0
postype = p1
facing = 1
keyctrl = 0
ownpal = 0
size.height = 100000
size.ground.back = 50
size.ground.front = 500

[State 1003, BindToParent]
type = BindToParent
trigger1 = 1
time = 1
facing = 1
pos = 0,0
ignorehitpause = 1

[State 1003, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "var(0) = %d FrontEdgeBodyDist = %d && var(11) = %d"
params = var(0), FrontEdgeBodyDist, var(11)
ignorehitpause = 1

[State 1003, VarSet]
type = VarSet
trigger1 = 1
v = 11
value = 0
ignorehitpause = 1

[State 1003, VarSet]
type = VarSet
trigger1 = FrontEdgeBodyDist >= 194
v = 11
value = var(11) | 1
ignorehitpause = 1

[State 1003, VarSet]
type = VarSet
trigger1 = BackEdgeBodyDist >= 30
v = 11
value = var(11) | 2
ignorehitpause = 1

[State 1003, VarSet]
type = VarSet
triggerall = numhelper(1002)
triggerall = var(0) = 0 && roundstate = 2 && root, alive && (helper(1002), var(0) = 2 || helper(1002), var(0) = 4)
trigger1 = root, command = "holdfwd" && var(11) & 1
trigger2 = root, command = "holdback" && var(11) & 2
v = 0
value = ifelse(root, command = "holdfwd", 1, -1)

[State 1003, VarSet]
type = ChangeAnim
triggerall = var(0) != 0
trigger1 = anim = 1100
value = ifelse(var(0) = 1, 1101, 1103)

[State 1003, VarSet]
type = ChangeAnim
triggerall = animtime = 0
trigger1 = var(0) = 1 && anim = 1101
trigger2 = var(0) = -1 && anim = 1103
value = ifelse(var(0) = 1, 1102, 1104)

[State 1003, VarSet]
type = VarSet
triggerall = animtime = 0
trigger1 = var(0) = 1 && anim = 1102
trigger2 = var(0) = -1 && anim = 1104
v = 0
value = 0
ignorehitpause = 1

[State 1003, ChangeAnim]
type = ChangeAnim
trigger1 = !var(0) && anim != 1100
value = 1100
ignorehitpause = 1

[State 1003, DestroySelf]
type = DestroySelf
trigger1 = !root, alive && !numhelper(1001)
ignorehitpause = 1

; Mao
[Statedef 1004]
type = A
physics = N
movetype = I
sprpriority = 1

[State 1004, AssertSpecial]
type = AssertSpecial
trigger1 = pos y > 0
flag = noshadow

[State 1004, ChangeAnim]
type = ChangeAnim
trigger1 = anim != 200
value = 200
ignorehitpause = 1

[State 1004, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
stateno = stateno
time = 1
ignorehitpause = 1

[State 1004, BindToParent]
type = BindToParent
trigger1 = !time
time = -1
facing = 1
pos = 0,0
ignorehitpause = 1

[State 1004, DestroySelf]
type = DestroySelf
trigger1 = !root, alive && !numhelper(1001)
ignorehitpause = 1

; Helper auxiliar
[Statedef 1005]
type = S
physics = N
movetype = I
anim = 1200

[State 1005, VarSet]
type = VarSet
trigger1 = !time
fv = 0
value = 5
ignorehitpause = 1

[State 1005, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow

[State 1005, NotHitBy]
type = NotHitBy
trigger1 = !time
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = -1
ignorehitpause = 1

[State 1005, VarSet]
type = VarAdd
trigger1 = fvar(0) > 0
fv = 0
value = -0.005
ignorehitpause = 1

[State 1005, VarSet]
type = VarSet
trigger1 = 1
v = 10
value = floor(((-500.0*fvar(0))-500)*Const(size.xscale))

ignorehitpause = 1

[State 1005, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "var(10) = %d "
params = var(10)
ignorehitpause = 1

[State 1005, BindToRoot]
type = BindToParent
trigger1 = 1
time = 1
facing = 1
pos = var(10), 0
ignorehitpause = 1

[State 1005, PlayerPush]
type = PlayerPush
trigger1 = 1
value = 1
ignorehitpause = 1

[State 1005, ScreenBound]
type = ScreenBound
trigger1 = 1
value = 0
ignorehitpause = 1

[State 1005, DestroySelf]
type = DestroySelf
trigger1 = roundstate > 2
ignorehitpause = 1

; Black
; var(0)
; 0 - Nada
; 1 - Desaparecer
; fvar(0)
; trans
[Statedef 1006]
type = A
movetype = I
physics = N
anim = 1300
sprpriority = -5

[State 1006, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow

[State 1006, VarSet]
type = VarSet
triggerall = !var(0)
trigger1 = root, alive && numhelper(1002)
trigger1 = helper(1002), var(0) = 4
trigger2 = !root, alive && !numhelper(1000)
v = 0
value = 1
ignorehitpause = 1

[State 1006, VarAdd]
type = VarAdd
trigger1 = var(0)
fv = 0
value = 5
ignorehitpause = 1

[State 1006, Trans]
type = Trans
trigger1 = var(0)
trans = addalpha
alpha = 256, floor(fvar(0))
ignorehitpause = 1

[State 1006, DestroySelf]
type = DestroySelf
trigger1 = fvar(0) > 255
ignorehitpause = 1

; Dedo
[Statedef 1007]
type = A
movetype = A
physics = N
anim = 1400

[State 1007, PosSet]
type = PosSet
trigger1 = !time
x = floor((-random%300)*Const(size.xscale))
y = floor(-(300+(random%200))*Const(size.yscale))
ignorehitpause = 1

[State 1007, VelSet]
type = VelSet
trigger1 = !time
x = -1+ifelse(random%2 = 1, 2, 0)*Const(size.xscale)
y = -1+ifelse(random%2 = 1, 2, 0)*Const(size.yscale)
ignorehitpause = 1

[State 1007, AngleAdd]
type = AngleAdd
trigger1 = 1
value = 10
ignorehitpause = 1

[State 1007, AngleDraw]
type = AngleDraw
trigger1 = 1
ignorehitpause = 1

[State 1007, VelSet]
type = VelSet
triggerall = time < 600
trigger1 = BackEdgeBodyDist <= 0 || FrontEdgeBodyDist <= 0
x = ifelse(BackEdgeBodyDist <= 0, 1, -1)*Const(size.xscale)
ignorehitpause = 1

[State 1007, VelSet]
type = VelSet
triggerall = time < 600
trigger1 = ScreenPos Y <= 0 || Pos Y >= 0
y = ifelse(ScreenPos Y <= 0, 1, -1)*Const(size.yscale)
ignorehitpause = 1

[State 1007, DestroySelf]
type = DestroySelf
trigger1 = time >= 600
trigger1 = BackEdgeBodyDist < -50*Const(size.xscale) || FrontEdgeBodyDist < -50*Const(size.yscale)
trigger2 = movecontact
trigger3 = !root, alive
ignorehitpause = 1

[State 1007, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
stateno = 1008
time = 1
forceair = 0
ignorehitpause = 1

[State 1007, HitDef]
type = HitDef
trigger1 = 1
attr = A,NP
hitflag = MAF-
guardflag = MA
getpower = 5,0
givepower = 15,0
animtype = Medium
air.animtype = Medium
priority = 4,Hit   ;Hit,Miss,Dodge
damage = 20,5
ground.hittime = 30
air.hittime = 15
pausetime = 10,0
sparkno = 0
guard.sparkno = 0
sparkxy = 0,0
hitsound = 5,1
guardsound = 6,0
ground.type = High
ground.slide = 0
ground.hit = 0
air.hittime = 20
ground.velocity = 5,0
air.velocity = 2,-2
fall = 0
fall.yvelocity = -4.5
fall.recover = 1
fall.recovertime = 4
fall.damage = 0
air.fall = 1
down.bounce = 0
kill = 1
guard.kill = 1
fall.kill = 1
numhits = 1

; Damage Helper
[Statedef 1008]
type = A
movetype = H
physics = N

[State 1008, DestroySelf]
type = DestroySelf
trigger1 = IsHelper
ignorehitpause = 1

; Projétil Umbigal
; var(0)
; 0 - Saindo da barriga
; 1 - Piscando na barriga
; 2 - Indo em direção ao player
; 3 - Agarrado na parede
[Statedef 1009]
type = A
movetype = A
physics = N
anim = 1401
sprpriority = -1

[State 1009, ChangeAnim]
type = ChangeAnim
trigger1 = anim != 1403 && var(0) != 2
trigger2 = anim != 1401 && var(0) = 2
value = ifelse(var(0) = 2, 1401, 1403)
ignorehitpause = 1

[State 1009, StateTypeSet]
type = StateTypeSet
trigger1 = var(3) && movetype != I
movetype = I
ignorehitpause = 1

[State 1009, VarSet]
type = VarSet
trigger1 = FrontEdgeBodyDist < -100*Const(size.xscale)
trigger2 = !root, alive
trigger3 = time >= 600 && var(0) != 3
trigger4 = var(0) = 3 && time-var(1) >= 420
v = 42
value = 1
ignorehitpause = 1

[State 1009, Projectile]
type = Projectile
triggerall = !numprojid(10) && enemynear, alive && roundstate = 2
trigger1 = abs(enemynear, pos x - pos x) <= 24 && enemynear, pos y - pos y < 0 && enemynear, pos y - pos y >= -Const(size.height) && enemynear, vel y > 0
ProjID = 10
projanim = 1402
projhitanim = -1
projremanim = -1
projcancelanim = -1
projscale = Const(size.xscale),Const(size.yscale)
projremove = 1
projremovetime = 1
fall.yvelocity = pos y-10
velocity = 0,0
remvelocity = 0,0
accel = 0,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 3
projedgebound = 40
projstagebound = 40
projheightbound = -240
offset = 0,0
postype = p1
projshadow = 0,0,0
supermovetime = 999999
pausemovetime = 999999
attr = A,NA
hitflag = MAFD
getpower = 0,0
givepower = 0,0
animtype = light
priority = 4,Hit
damage = 0,0
sparkno = -1
guard.dist = 0
p2stateno = 2000
id = 2000
chainid = 2000
nochainid = 2000
numhits = 0

[State 1009, Projectile]
type = Projectile
triggerall = !numprojid(10)
trigger1 = abs(enemynear, pos x - pos x) > 24 && enemynear, pos y - pos y <= 0 && enemynear, pos y - pos y >= -Const(size.height) && enemynear, statetype != A
trigger2 = var(42)
ProjID = 10
projanim = 1402
projhitanim = -1
projremanim = -1
projcancelanim = -1
projscale = Const(size.xscale),Const(size.yscale)
projremove = 1
projremovetime = 1
fall.yvelocity = pos y-10
velocity = 0,0
remvelocity = 0,0
accel = 0,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 3
projedgebound = 40
projstagebound = 40
projheightbound = -240
offset = 0,0
postype = p1
projshadow = 0,0,0
supermovetime = 999999
pausemovetime = 999999
attr = A,NA
hitflag = HL
getpower = 0,0
givepower = 0,0
animtype = light
priority = 4,Hit
damage = 0,0
sparkno = -1
guard.dist = 0
id = 2001
chainid = 2001
nochainid = 2001
p2stateno = 2001
numhits = 0

[State 1009, VarSet]
type = VarSet
trigger1 = !time
v = 2
value = numhelper(1009)
ignorehitpause = 1

[State 1009, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
stateno = 1008
time = 1
forceair = 0
ignorehitpause = 1

[State 1009, VarSet]
type = VarAdd
trigger1 = !var(0) && var(1) <= 15
v = 1
value = 1
ignorehitpause = 1

[State 1009, BindToParent]
type = BindToParent
trigger1 = var(2) = 1 && var(0) < 2
time = 1
facing = 1
pos = floor((63+var(1))*Const(size.xscale)), floor(-41*Const(size.yscale))
ignorehitpause = 1

[State 1009, BindToParent]
type = BindToParent
trigger1 = var(2) = 2 && var(0) < 2
time = 1
facing = 1
pos = floor((65+var(1))*Const(size.xscale)), floor(-109*Const(size.yscale))
ignorehitpause = 1

[State 1009, BindToParent]
type = BindToParent
trigger1 = var(2) = 3 && var(0) < 2
time = 1
facing = 1
pos = floor((38+var(1))*Const(size.xscale)), floor(-167*Const(size.yscale))
ignorehitpause = 1

[State 1009, VarAdd]
type = VarAdd
trigger1 = !var(0) && time >= 15
v = 0
value = 1
ignorehitpause = 1

[State 1009, VarAdd]
type = VarAdd
trigger1 = var(0) = 1 && time >= 60
v = 0
value = 1
ignorehitpause = 1

[State 1009, VelSet]
type = VelSet
trigger1 = var(0) = 2
x = 4*Const(size.xscale)
ignorehitpause = 1

[State 1009, PalFX]
type = PalFX
trigger1 = !(root, var(10) % 2 = 0 && root, var(10))
trigger1 = !(time % 2 = 0 && (var(0) = 1 || (var(0) = 3 && time-var(1) > 300)))
time = 1
mul = 256,128+floor(128*((root, life*1.0)/root, lifemax)),floor(256*((root, life*1.0)/root, lifemax))
color = 256
ignorehitpause = 1

[State 1009, PalFX]
type = PalFX
triggerall = time % 2 = 0
trigger1 = var(0) = 1
trigger2 = var(0) = 3 && time-var(1) > 300
time = 2
add = 255,255,255
mul = 256,256,256
invertall = 0
color = 256
ignorehitpause = 1

[State 1009, HitDef]
type = HitDef
trigger1 = var(0) = 2
attr = A,NP
hitflag = MAF-
guardflag = MA
getpower = 5,0
givepower = 15,0
animtype = Hard
priority = 4,Hit
damage = 40,15
pausetime = 0,0
sparkno = 0
guard.sparkno = 0
sparkxy = 0,0
hitsound = 5,3
guardsound = 6,0
ground.type = Low
ground.hit = 0
guard.hittime = 30
ground.hittime = 80
air.hittime = 80
ground.velocity = -vel x,-2
air.velocity = -vel x,-2
p1getp2facing = 0
down.bounce = 0
kill = 1
fall = 1
guard.kill = 1
fall.kill = 1
numhits = 1

[State 1007, VarSet]
type = VarSet
trigger1 = var(0) = 2 && FrontEdgeBodyDist <= 0
v = 0
value = 3
ignorehitpause = 1

[State 1007, VarSet]
type = VarSet
trigger1 = var(0) = 3
v = 1
value = time
ignorehitpause = 1
persistent = 0

[State 1007, VelSet]
type = VelSet
trigger1 = var(0) = 3
x = 0
y = 0
ignorehitpause = 1

[State 1007, PosSet]
type = PosAdd
trigger1 = var(0) = 3
x = FrontEdgeDist
ignorehitpause = 1

[State 1007, PlaySnd]
type = PlaySnd
trigger1 = var(42)
trigger2 = var(0) = 3 && ((var(1) = time) || (time - var(1) >= 400 && time % 10 = 0))
value = S0,1
channel = -1
ignorehitpause = 1

[State 1007, EnvShake]
type = EnvShake
trigger1 = var(1) = time && var(0) = 3
time = 30
freq = 60
ampl = -4
phase = 90
ignorehitpause = 1

[State 1002, Explod]
type = Explod
trigger1 = var(0) = 3 && time - var(1) <= 30 && time % 6 = 0
anim = 2000
ID = 2000
pos = 0,0
postype = p1
facing = 1
random = 0, 30
vel = -(random%200)/100.0, (-100+random%200)/100.0
vfacing = 1
bindtime = 1
removetime = -2
ownpal = 1
ontop = 1
removeongethit = 0
ignorehitpause = 1

[State 1002, Explod]
type = Explod
trigger1 = var(0) = 3 && time - var(1) >= 400 && time % 6 = 0
anim = 2003
ID = 2003
pos = 0,0
postype = p1
facing = 1
random = 30, 30
vfacing = 1
bindtime = 1
removetime = -2
ownpal = 1
ontop = 1
removeongethit = 0
ignorehitpause = 1

[State 1007, DestroySelf]
type = DestroySelf
trigger1 = var(42)
ignorehitpause = 1

[Statedef 2000]
type = S
movetype = H
physics = N

[State 2000, PosSet]
type = PosSet
trigger1 = !time
y = GetHitVar(fall.yvel)

ignorehitpause = 1

[State 2000, SelfState]
type = SelfState
trigger1 = 1
value = 0
ctrl = 1
ignorehitpause = 1

[Statedef 2001]
type = A
movetype = H
physics = N

[State 2001, SelfState]
type = SelfState
trigger1 = 1
value = 50
ctrl = 1
ignorehitpause = 1

;==================================================================================
;======| RELACIONADO À AI - AI RELATED |===========================================
;==================================================================================

; (Credit to ANMC, Bagaliao, and FlowaGirl for the basic helper method concept.)
;
;------------------
; AI Activation Helper State - Primary Version
; (Credit to YongMing for the basic HitPause bugfix concept.)
;
; var(1) - First tick button activation prevention.
; var(2) - Used for pause/superpause and custom state check, basically.
; var(3) - (Super/)Pause & custom state-triggered dir detection disabler.
; var(4) - Persistent direction command detection enabler (due to 2002.04.14).
; var(9) - AutoTurn bug fixer.
; parent's var(57) - Parent's GameTime var, for pause and custom state check.
; parent's var(59) - Parent's primary AI variable.
;
; The code in this state is mostly simply copy/pasteable.
; But if you're using different indices for the parent's variables,
; or if you change your character's basic commands' names, you'll
; of course need to change the code in this state accordingly.

[StateDef 9741]
type = S
movetype = I
physics = N
anim = 9741
ctrl = 0

[State 9741, Safety]; Just in case your opponent is very poorly coded.
type = SelfState
trigger1 = !IsHelper
value = 0

[State 9741, PauseCheck]
type = VarSet
trigger1 = (GameTime>(Parent,var(57)))
trigger2 = !(Parent,Alive)
trigger3 = (RoundState != 2)
trigger4 = Parent,var(59)
trigger5 = (var(3):=0)
var(2) = (var(3):=1)+(var(4):=0)

[State 9741, Facing]
type = Turn
trigger1 = (var(9):=(Facing != Parent,Facing))

[State 9741, DirTurnOnAI]
type = ParentVarSet
triggerall = !var(3)
triggerall = !var(9)
trigger1 = (Parent,command = "holdfwd")
trigger2 = (Parent,command = "holdback")
trigger3 = (Parent,command = "holdup")
trigger4 = (Parent,command = "holddown")
trigger5 = !(var(4):=1)
var(59) = var(4)

[State 9741, DirTurnOffAI]
type = ParentVarSet
triggerall = !var(3)
triggerall = Parent,var(59)
trigger1 = (command = "holdfwd")
trigger1 = (Parent,command = "holdfwd")
trigger2 = (command = "holdback")
trigger2 = (Parent,command = "holdback")
trigger3 = (command = "holdup")
trigger3 = (Parent,command = "holdup")
trigger4 = (command = "holddown")
trigger4 = (Parent,command = "holddown")
var(59) = (var(4):=0)

[State 9741, ButtonTurnOnAI]
type = ParentVarSet
triggerall = var(1)
triggerall = !var(2)
trigger1 = (Parent,command = "a")
trigger2 = (Parent,command = "b")
trigger3 = (Parent,command = "c")
trigger4 = (Parent,command = "x")
trigger5 = (Parent,command = "y")
trigger6 = (Parent,command = "z")
trigger7 = (Parent,command = "start")
var(59) = 1

[State 9741, ButtonTurnOffAI]
type = ParentVarSet
triggerall = !var(2)
trigger1 = (command = "a")
trigger1 = (Parent,command = "a")
trigger2 = (command = "b")
trigger2 = (Parent,command = "b")
trigger3 = (command = "c")
trigger3 = (Parent,command = "c")
trigger4 = (command = "x")
trigger4 = (Parent,command = "x")
trigger5 = (command = "y")
trigger5 = (Parent,command = "y")
trigger6 = (command = "z")
trigger6 = (Parent,command = "z")
trigger7 = (command = "start")
trigger7 = (Parent,command = "start")
var(59) = -1

[State 9741, UnPauseCheck]
type = VarSet
triggerall = var(2)
trigger1 = (Parent,command = "a")
trigger2 = (Parent,command = "b")
trigger3 = (Parent,command = "c")
trigger4 = (Parent,command = "x")
trigger5 = (Parent,command = "y")
trigger6 = (Parent,command = "z")
trigger7 = (Parent,command = "start")
trigger8 = (var(2) = 2)
trigger8 = (var(2):=0)
var(2) = 2

[State 9741, Goodbye]
type = DestroySelf
triggerall = (var(1):=1)
trigger1 = Parent,var(59)
trigger2 = !(Parent,Alive)
trigger3 = (RoundState != 2)


;------------------
; AI Activation Helper State - Compatibly Partnered Version
;
; var(1) - First tick dir activation prevention
; var(2) - Used for pause/superpause and custom state check, basically.
; var(3) - (Super/)Pause & custom state-triggered dir detection disabler.
; var(4) - Hitpause check.
; var(5) - No button on previous tick.
; var(6) - Any dir on this tick.
; var(7) - Any button on this tick.
; var(8) - Matching partner button detected.
; var(9) - AutoTurn bug fixer.
; parent's var(57) - Parent's GameTime var, for pause and custom state check.
; parent's var(59) - Parent's primary AI variable.
;
; The code in this state is mostly simply copy/pasteable.
; But if you're using different indices for the parent's variables,
; or if you change your character's basic commands' names, you'll
; of course need to change the code in this state accordingly.

[StateDef 9742]
type = S
movetype = I
physics = N
anim = 9741
ctrl = 0

[State 9742, Safety]; Just in case your opponent is very poorly coded.
type = SelfState
trigger1 = !IsHelper
value = 0

[State 9742, PauseCheck]
type = VarSet
trigger1 = (GameTime>Parent,var(57))
trigger2 = !(Parent,Alive)
trigger3 = (RoundState != 2)
trigger4 = Parent,var(59)
trigger5 = (var(3):=0)
var(2) = (var(3):=1)

[State 9742, Facing]
type = Turn
trigger1 = (var(9):=(Facing != Parent,Facing))

[State 9742, ParentDirCheck]
type = VarSet
trigger1 = (Parent,command = "holdfwd")
trigger2 = (Parent,command = "holdback")
trigger3 = (Parent,command = "holdup")
trigger4 = (Parent,command = "holddown")
trigger5 = (var(6):=0)
var(6) = 1

[State 9742, ParentButtonCheck]
type = VarSet
trigger1 = (Parent,command = "a")
trigger2 = (Parent,command = "b")
trigger3 = (Parent,command = "c")
trigger4 = (Parent,command = "x")
trigger5 = (Parent,command = "y")
trigger6 = (Parent,command = "z")
trigger7 = (Parent,command = "start")
trigger8 = (var(7):=0)
var(7) = 1

[State 9742, SameButtonCheck]
type = VarSet
triggerall = var(7)
triggerall = !var(2)
triggerall = NumPartner
trigger1 = (Parent,command = "a")
trigger1 = (Partner,command = "a")
trigger2 = (Parent,command = "b")
trigger2 = (Partner,command = "b")
trigger3 = (Parent,command = "c")
trigger3 = (Partner,command = "c")
trigger4 = (Parent,command = "x")
trigger4 = (Partner,command = "x")
trigger5 = (Parent,command = "y")
trigger5 = (Partner,command = "y")
trigger6 = (Parent,command = "z")
trigger6 = (Partner,command = "z")
trigger7 = (Parent,command = "start")
trigger7 = (Partner,command = "start")
trigger8 = (var(8):=0)
var(8) = 1

[State 9742, DirTurnOnAI]
type = ParentVarSet
trigger1 = var(1)
trigger1 = var(6)
trigger1 = !var(3)
trigger1 = !var(4)
trigger1 = !var(9)
var(59) = 1

[State 9742, DirTurnOffAI]
type = ParentVarSet
triggerall = var(6)
triggerall = !var(3)
triggerall = Parent,var(59)
trigger1 = (command = "holdfwd")
trigger1 = (Parent,command = "holdfwd")
trigger2 = (command = "holdback")
trigger2 = (Parent,command = "holdback")
trigger3 = (command = "holdup")
trigger3 = (Parent,command = "holdup")
trigger4 = (command = "holddown")
trigger4 = (Parent,command = "holddown")
var(59) = 0

[State 9742, ButtonTurnOnAI]
type = ParentVarSet
trigger1 = var(5)
trigger1 = var(7)
trigger1 = !var(2)
trigger1 = !var(8)
var(59) = 1

[State 9742, ButtonTurnOffAI]
type = ParentVarSet
triggerall = var(7)
triggerall = !var(2)
triggerall = !var(8)
trigger1 = (command = "a")
trigger1 = (Parent,command = "a")
trigger2 = (command = "b")
trigger2 = (Parent,command = "b")
trigger3 = (command = "c")
trigger3 = (Parent,command = "c")
trigger4 = (command = "x")
trigger4 = (Parent,command = "x")
trigger5 = (command = "y")
trigger5 = (Parent,command = "y")
trigger6 = (command = "z")
trigger6 = (Parent,command = "z")
trigger7 = (command = "start")
trigger7 = (Parent,command = "start")
var(59) = -1

[State 9742, UnPauseCheck]
type = VarSet
triggerall = var(2)
triggerall = !var(4)
trigger1 = var(7)
trigger2 = (var(2) = 2)
trigger2 = (var(2):=0)
var(2) = 2

[State 9742, Goodbye]
type = DestroySelf
trigger1 = Parent,var(59)
trigger2 = !(Parent,Alive)
trigger3 = (RoundState != 2)

[State 9742, HitPauseCheck]
type = VarSet
trigger1 = var(6)
trigger2 = var(7)
trigger3 = !(Parent,HitPauseTime)
var(4) = Parent,HitPauseTime

[State 9742, Delay]
type = VarSet
trigger1 = (var(1):=1)
var(5) = !var(7)


;------------------
; XOR Method's HitPauseTime Helper State

[StateDef 9743]
type = S
movetype = I
physics = N
anim = 9741
ctrl = 0

[State 9743, Safety]; Just in case your opponent is very poorly coded.
type = SelfState
trigger1 = !IsHelper
value = 0

[State 9743, HitPauseTime]
type = VarSet
trigger1 = !(Parent,HitPauseTime)
trigger2 = (GameTime>Parent,var(57))
var(1) = Parent,HitPauseTime

[State 9742, Goodbye]
type = DestroySelf
trigger1 = (Parent,var(59) = 1)
trigger2 = !(Parent,Alive)
trigger3 = (RoundState != 2)

;==================================================================================
;==================================================================================
;==================================================================================

;---------------------------------------------------------------------------
; Override common states (use same number to override) :
;---------------------------------------------------------------------------

;---------------------------------------------------------------------------
; States that are always executed (use statedef -2)
;---------------------------------------------------------------------------
[StateDef -2]

;==================================================================================
;======| RELACIONADO À AI - AI RELATED |===========================================
;==================================================================================

; Within StateDef -2, none of your own AI-related code should be placed
; above these next two controllers.

[State -2, Helper]
type = Helper
trigger1 = numhelper(1007) < 4 && !IsHelper && Alive && gametime % 120 = 0 && numhelper(1002)
trigger1 = helper(1002), var(0) = 4
helpertype = normal
name = "WTF is this?"
ID = 1007
stateno = 1007
pos = -9999, -9999
postype = left
facing = 1
keyctrl = 0
ownpal = 0
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)
size.ground.back = 7
size.ground.front = 7
size.air.back = 7
size.air.front = 7
size.height = 10
size.head.pos = 0,0
size.mid.pos = 0,0

[State -2, Helper]
type = Helper
trigger1 = !numhelper(1006) && !IsHelper && Alive && numhelper(1002)
trigger1 = helper(1002), var(0) < 4
helpertype = normal
name = "Black"
ID = 1006
stateno = 1006
pos = 160,50
postype = left
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = 65535
size.yscale = 65535
ignorehitpause = 1

[State -2, PalFX]
type = PalFX
trigger1 = !(var(10) % 2 = 0 && var(10))
time = 1
mul = 256,128+floor(128*((life*1.0)/lifemax)),floor(256*((life*1.0)/lifemax))
color = 256
ignorehitpause = 1

[State -2, StopAI]
type = VarSet
triggerall = (var(59) > 0)
trigger1 = (RoundState != 2)
trigger2 = !Alive
var(59) = -2
IgnoreHitPause = 1

[State -2, Simplifier]
type = VarSet
trigger1 = (var(59) = 1)
trigger2 = (var(0):=0)
var(0) = 1
IgnoreHitPause = 1

[State -2, AssertSpecial]
type = AssertSpecial
trigger1 = !IsHelper
flag = noautoturn
flag2 = nowalk
flag3 = nostandguard
ignorehitpause = 1

[State -2, AssertSpecial]
type = AssertSpecial
trigger1 = !IsHelper
flag = invisible
flag2 = noairguard
flag3 = nocrouchguard
ignorehitpause = 1

[State -2, Helper]
type = Helper
trigger1 = !numhelper(1002) && !IsHelper && Alive
helpertype = normal
name = "Corpo"
ID = 1002
stateno = 1002
pos = 0,floor(510*Const(size.yscale))
postype = p1
facing = 1
keyctrl = 0
ownpal = 0
size.ground.back = 92
size.ground.front = 92
size.height = 215

[State -2, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 200
time = 1
forceair = 0
ignorehitpause = 1

;---------------------------------------------------------------------------
; States that are executed when in self's state file (use statedef -3)
;---------------------------------------------------------------------------

[Statedef -3]

;[State -3, SelfState]
;type = SelfState
;triggerall = stateno != 180 && stateno != 170
;trigger1 = alive && !isHelper && roundstate > 2
;value = ifelse(win, 180, 170)
;ignorehitpause = 1

[State -3, SelfState]
type = SelfState
trigger1 = !alive && !isHelper && !numhelper(1000)
value = 5150
ignorehitpause = 1

[State -3, ScreenBound]
type = ScreenBound
trigger1 = 1
value = 0
ignorehitpause = 1


;==================================================================================
;======| RELACIONADO À AI - AI RELATED |===========================================
;==================================================================================

[State -3, NotHitBy]
type = NotHitBy
triggerall = !IsHelper && numhelper(1000)
trigger1 = helper(1000), anim != 2 && helper(1000), anim != 3 && helper(1000), anim != 4
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State -3, VarAdd]
type = VarAdd
trigger1 = !IsHelper && var(10)
v = 10
value = -1
ignorehitpause = 1

[State -3, PalFX]
type = PalFX
triggerall = !IsHelper && var(10)
trigger1 = var(10) % 2 = 0
time = 1
add = 255,255,255
mul = 256,256,256
invertall = 0
color = 256
ignorehitpause = 1

[State -3, PosSet]
type = PosSet
triggerall = roundstate = 2
trigger1 = numhelper(1000)
x = floor(helper(1000), pos x-(20*Const(size.xscale))*facing)
y = floor(helper(1000), pos y-(230*Const(size.yscale)))
ignorehitpause = 1

; Kamek and Luchini appear to have been the first ones to use the IsHomeTeam AI activation concept.
; Feel free to move this controller to your character's intro state for slightly better efficiency.
[State -3, SetAI]
type = VarSet
triggerall = !RoundState
triggerall = IsHomeTeam
trigger1 = (TeamSide = 2)
trigger2 = (MatchNo > 1)
var(59) = 1

; Feel free to move this controller to your character's intro state for slightly better efficiency.
; Note that it may give P2 a slight unfair advantage in simul team vs mode, so you
; may want to disable it.  But then, since when has Mugen been about fairness? =P
[State -3, Unfair]; Is this reliable?
type = VarSet
trigger1 = !RoundState
trigger1 = (var(59) != 1)
trigger1 = NumPartner
trigger1 = (ID > Partner,ID)
trigger1 = (TeamSide = 2)
var(59) = 1

[State -3, AI Helper (Compatibly Partnered Version)]
type = Helper
trigger1 = !var(59)
trigger1 = !NumHelper(9742)
trigger1 = (RoundState = 2)
trigger1 = Alive
trigger1 = NumPartner
trigger1 = Partner,SelfAnimExist(9741)
HelperType = normal
name = "AI Helper (Simul Version)"
ID = 9742
pos = 9999999,99999
StateNo = 9742
KeyCtrl = 1
PauseMoveTime = 999999999
SuperMoveTime = 999999999

; If you want to use the Guard mode, Dummy mode, Distance, or Button jam dummy control
; options in Training mode without activating the dummy's AI while working on your
; character, then all you need to do is temporarily disable this controller.
; Or, if you want to permanently disable this controller in Training mode,
; then you could use the Training mode detection code available on my site
; ( http://www.shinmugen.net/winane/ ), and then just add a "(var(59)&63)>30"
; triggerall to this controller.
[State -3, AI Helper]
type = Helper
triggerall = !var(59)
triggerall = !NumHelper(9741)
triggerall = (RoundState = 2)
triggerall = Alive
trigger1 = !NumPartner
trigger2 = !(Partner,SelfAnimExist(9741))
HelperType = normal
name = "AI Helper"
ID = 9741
pos = 9999999,99999
StateNo = 9741
KeyCtrl = 1
PauseMoveTime = 999999999
SuperMoveTime = 999999999

[State -3, TurnBackOnAI]
type = VarSet
trigger1 = (var(59) = -2)
trigger1 = (RoundState = 2)
trigger1 = Alive
var(59) = 1

[State -3, HitPauseTime Helper]
type = Helper
triggerall = var(59)!=1
triggerall = !NumHelper(9743)
triggerall = (RoundState = 2)
triggerall = Alive
trigger1 = (MatchNo = 1)
trigger2 = NumPartner
trigger2 = (ID > Partner,ID)
HelperType = normal
name = "HitPauseTime"
ID = 9743
pos = 9999999,99999
StateNo = 9743
PauseMoveTime = 999999999
SuperMoveTime = 999999999

; According to Roque, this method works in Linux Mugen version 2002.04.14,
; whereas the old humanly-impossible commands method does not.
; It is very important that this controller NOT be moved to State -2.
; Note that this part won't work if AI.Cheat is turned off in mugen.cfg.
[State -3, XOR]
type = VarSet
triggerall = var(59)!=1
triggerall = (var(57) = GameTime-1)
triggerall = NumHelper(9743)
triggerall = !(Helper(9743),var(1))
trigger1 = (command = "a") ^^ (command = "a2")
trigger2 = (command = "b") ^^ (command = "b2")
trigger3 = (command = "c") ^^ (command = "c2")
trigger4 = (command = "x") ^^ (command = "x2")
trigger5 = (command = "y") ^^ (command = "y2")
trigger6 = (command = "z") ^^ (command = "z2")
trigger7 = (command = "start") ^^ (command = "start2")
trigger8 = (command = "holda") ^^ (command = "holda2")
trigger9 = (command = "holdb") ^^ (command = "holdb2")
trigger10 = (command = "holdc") ^^ (command = "holdc2")
trigger11 = (command = "holdx") ^^ (command = "holdx2")
trigger12 = (command = "holdy") ^^ (command = "holdy2")
trigger13 = (command = "holdz") ^^ (command = "holdz2")
trigger14 = (command = "holdstart") ^^ (command = "holdstart2")
trigger15 = (command = "holdfwd") ^^ (command = "holdfwd2")
trigger16 = (command = "holdback") ^^ (command = "holdback2")
trigger17 = (command = "holdup") ^^ (command = "holdup2")
trigger18 = (command = "holddown") ^^ (command = "holddown2")
trigger19 = (command = "recovery") ^^ (command = "recovery2")
;Add more as desired. (See my notes in the CMD.)
var(59) = 1

; It is very important that this controller NOT be moved to State -2, as putting
; it there would defeat the entire purpose of the controller, allowing the
; helper method or the XOR method to erroneously set the AI variable.
; And within State -3, don't put any ChangeState controllers before this
; controller, lest you unnecessarily delay your character's AI activation.
[State -3, GameTimeVar]
type = VarSet
trigger1 = 1
var(57) = GameTime
IgnoreHitPause = 1

; Within StateDef -3, none of your own AI-related code should come after the code
; provided here (and putting it before the code is also generally a bad idea).
; It's better to use State -1 (or, in special circumstances, State -2) instead.

;==================================================================================
;==================================================================================
;==================================================================================

;[State -3, CtrlSet]
;type = CtrlSet
;triggerall = !IsHelper
;trigger1 = roundstate = 2
;value = 0
;ignorehitpause = 1

[State -3, ChangeState]
type = SelfState
trigger1 = stateno != 200 && stateno != 0 && roundstate = 2
value = 0
ignorehitpause = 1

