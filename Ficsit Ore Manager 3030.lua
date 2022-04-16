Build = "BARE-BONES-BUILD     "

-- Status Light #############################
STA = "StatusLight"
PAN = {"192.168.1.122",0,0,1,0,42}
-- ##########################################

FicsItNetworksVer= "0.2.1"
CBeep            = false
EnableStausLight = true -- Uses panel after light pole texture glitch
AlertForAnyPWR   = true -- if this is true then any pwr issues will need change the status light, false it will not trigger onlyin the display you will see issues
EnableScreen     = true
ConPercentages   = false
LiqPercentages   = false
GasPercentages   = false
-- ServerLogger  = false
-- ServerAddress = "" -- Work in progress
-- NetworkCard   = "" -- Work in progress

-- ITEM LIST ############################################################################################
                  ListVer = "4.0.0"
-- Stacks,Display Name, ConErr, LigErr, PwrErr, RadioActive 1Y 0N, System Name 
                      VAL = {100 ,"Default                     ",0,0,0,0,"Default"}
---- Ores ----------------------------------------------------------------------------------------------9
                LimeStone = {100 ,"LimeStone                   ",0,0,0,0,"LimeStone"} 
                  IronOre = {100 ,"Iron Ore                    ",0,0,0,0,"IronOre"}
                CopperOre = {100 ,"Copper Ore                  ",0,0,0,0,"CopperOre"}
              CateriumOre = {100 ,"Caterium Ore                ",0,0,0,0,"CateriumOre"}
                     Coal = {100 ,"Coal                        ",0,0,0,0,"Coal"}
                RawQuartz = {100 ,"Raw Quartz                  ",0,0,0,0,"RawQuartz"}
                   Sulfur = {100 ,"Sulfur                      ",0,0,0,0,"Sulfur"}
                  Bauxite = {100 ,"Bauxite                     ",0,0,0,0,"Bauxite"}
                   SAMOre = {100 ,"SAMOre                      ",0,0,0,0,"SAMOre"}
                  Uranium = {100 ,"Uranium                     ",0,0,0,0,"Uranium"}

-- add below what each container is in the format below:

-- Examples -- ###################################################################
-- Containers   = ConStatus(DisX,DisY,Contents,ConNumber,ConType,ELight,EPower)
-- Tanks Liquid = LiqStatus(DisX,DisY,Contents,TankNumber,ELight,EPower)
-- Tanks Gases  = GasStatus(DisX,DisY,Contents,TankNumber,ELight,EPower)
-- Power        = PWRStatus(DisX,DisY,Power List Name For maonitoring)
-- Backup Power = PWRBackUp(DisX,DisY,Power list name for Backup Power station)
-- Boarders     = DisBoarder(DisX,DisY,LinesToDraw,Title,TitleText)
-- LayoutMode   = LayoutMode(X,Y) -- Helps with the layout process
-- ###############################################################################

-- Example For containers ########################################################
-- Container Name Example : CON B1 LimeStone
-- Power Pole Name Example: PWR B1 LimeStone
-- Light Pole Name Example: LIG B1 LimeStone

-- Example for tanks #############################################################
-- Tank Name Exmple : LIQ B1 Fuel
-- Power Pole Name Example: PWR B1 Fuel
-- Light Pole Name Example: LIG B1 Fuel

-- Example for Power Moniting #############################################################
-- PowerPole name example : MON B1 Building1


function ITEMDISPLAY()
DisBoarder(0,7,9,true,"ORE")
--DisBoarder(0,14,8,true,"TANKS")
--DisBoarder(127,0,25,true,"Materials")
SystemInfo(0,0) -- Default 83,0
--LayoutMode(23,23)
end





function ITEMLIST()
-- Display


-- Storage Items
ConStatus(2,9,LimeStone,1,1,true,true)
ConStatus(2,10,Coal,2,1,true,true)
--ConStatus(2,4,CopperOre,3,0,true,true)
--ConStatus(2,5,CateriumOre,4,0,true,true)
--ConStatus(2,6,IronOre,5,0,true,true)
--ConStatus(2,7,RawQuartz,6,0,true,true)
--ConStatus(2,8,Sulfur,7,0,true,true)
--ConStatus(2,9,Bauxite,8,0,true,true)
--ConStatus(2,10,Uranium,9,0,true,true)
--ConStatus(129,2,NuclearWaste,1,1,true,false)

-- Power Monitoring
--PWRStatus(83,7,PowerMain)
--BatStatus(83,30,Battery)
--PWRStatus(83,13,StatusWaterPwr)
--PWRBackUp(83,20,BackUp1)

--LiqStatus(2,16,Water,0,true,true)
--GasStatus(2,17,Nitrogen,1,true,true)

end --## ITEM LIST ############################################



--############################################################################
-- Anything after this point you should not have to change.
-- The program will let you know if anything will need updating above.




--############################################################################
--NETWORK
--############################################################################
SRX = "DC73C2544A7BF761FB9BED8C695A5678"
POT = 4
netcard = component.proxy("6E6F9A754109B93BDFF899966A92414F")
netcard:open(POT)
DATASENT = true

function SendToServer(Server, Port, Data, Print)
netcard:send(Server, Port, Data)
if Print == true then print("Data Sent: "..Server.." / "..Port) end
end


--############################################################################
--############################################################################










-- System Screen Sys P1/3 #############################################################################--
if EnableScreen == true then 
SystemScreenSys = {"System Screen Sys Ver: ","1.0.1"}
--gpu = computer.getGPUs()[1]
gpu = computer.getPCIDevices(findClass("GPU_T1_C"))[1]
--local screen = computer.proxy(component.findComponent("Monitor"))[1]
screen = computer.getPCIDevices(findClass("FINComputerScreen"))[1]
gpu:bindScreen(screen)
w,h = gpu:setSize(115,40) --200 , 55
end

function LayoutMode(X,Y)
textCol(1,0,0,1) 
write(X,Y,"#") 
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end


-- System Screen System P1/3 End --

SAT = {true, false}
ERR = {"[System] : Error Detected Starting Self Check ", 
       "[System] : Starting Self Test ", 
       "[ERROR]  : Connection Error For Container: ", 
       "[ERROR]  : Connection Error For Light: ", 
       "[ERROR]  : Connection Error For Power Switch: ",
       "[ERROR]  : Connection Error For Power Monitor: "}

SYS = {"[System] : Light Poles Disabled",
       "[System] : Power Poles Disabled",
       "[System] : Control Panel Lights Disabled", 
       "[System] : Computer Screen Disabled"}
FLAG = 0
TEST = 0
IND = 0
ChkDis = false
progstat = component.proxy(component.findComponent(STA)[1])
StatusPanel = component.proxy(component.findComponent(PAN[1])[1])
ProgramStat = StatusPanel:getModule(PAN[2],PAN[3])
text = StatusPanel:getModule(PAN[4],PAN[5])
text.size = PAN[6]
text.text = "Ore Manager"

dev = 0
local ProgName = ("Ficsit Ore Manager 3030       ")
local By = ("Skymoeba ")
local Ver = ("1.0.26")
local UVer = {"1.0.26","4.0.0","0.2.1"} -- keep this here until you can pull pastes from Git / pastebin
local MVer = ("0.2.1")
local BFlag = 0
Page = 0
fCont = {0,0,0,0,0,0,0,0,0,0,0}
Tick = 0
Loop = 0
Days = 0
Hrs = 0
Mins = 0
Sec = 0
Cat = 0


function ConStatus(DisX,DisY,Contents,ConNumber,ConType,ELight,EPower,Containcount)
if FLAG == 0 then
 if TEST == 1 then
  Contents[3] = 0
 end
end

function ConData()
prefix = {"CON","LIG","PWR"}
local setupcon = {prefixcon= prefix[1], condata=Contents[7]}
local setuppwr = {prefixpwr= prefix[3], pwrdata=Contents[7]}
local setuplig = {prefixlig= prefix[2], ligdata=Contents[7]}

Container = string.gsub("$prefixcon $condata", "%$(%w+)", setupcon)
Light = string.gsub("$prefixlig $ligdata", "%$(%w+)", setuplig)
Power = string.gsub("$prefixpwr $pwrdata", "%$(%w+)", setuppwr)


ContStore = component.proxy(component.findComponent(Container)[1])
conInv = ContStore:getInventories()[1]
conSum = conInv.itemCount
itemStack = conInv:getStack(0)
--itemName = itemStack.item.type:getName()
--itemName = itemStack.item.type.name -- M update v0.1.0
end

if Contents[3] == 1 then else
if pcall (ConData) then 

ConData()

if ConType == 0 then -- "Small"
if Contents[1] == 50 then x = 1199 y = 599 z = 200 end
if Contents[1] == 100 then x = 2399 y = 1600 z = 800 end
if Contents[1] == 200 then x = 4799 y = 1600 z = 1000 end
if Contents[1] == 500 then x = 11999 y = 8000 z = 2000 end
end

if ConType == 1 then -- "Large / Train"
if Contents[1] == 50 then x = 2399 y = 1199 z = 200 end
if Contents[1] == 100 then x = 4799 y = 2400 z = 800 end
if Contents[1] == 200 then x = 4799 y = 1600 z = 1000 end
if Contents[1] == 500 then x = 23999 y = 11999 z = 1000 end
end

if ConType == 2 then -- "Hopper"
if Contents[1] == 50 then x = 799 y = 400 z = 100 end
if Contents[1] == 100 then x = 2409 y = 1600 z = 800 end
if Contents[1] == 200 then x = 4799 y = 1600 z = 1000 end
if Contents[1] == 500 then x = 11999 y = 8000 z = 2000 end
end

a = x + 1
rawpercent = conSum / a * 100/1 
percent= round(rawpercent)

-- Screen List Start
if EnableScreen == true then
textCol(1,1,1,1)

write(DisX,DisY, ConNumber)
DisX = DisX + 16
write(DisX,DisY,Contents[2])
DisX = DisX + 32
if ConPercentages == false then
write(DisX,DisY,conSum.."    ")
else
write(DisX,DisY,percent.."%   ")
end
DisX = DisX + 11
--print(itemName)
if conSum > x then  -- Rewrite this bit
 textCol(0,1,0,1) 
  write(DisX,DisY,"Full     ")
elseif
 conSum < z then 
  textCol(1,1,0,1) 
   if EPower == true then
    --if DATASENT == false then SendToServer(SRX,POT,"Refilling : "..Contents[7].." ",false) DATASENT = true end --###################
    write(DisX,DisY,"Refilling")
     else
      if Contents[6] == 0 then
       textCol(1,0,0,1)
        else
         textCol(0,1,0,1)
          end
      write(DisX,DisY,"Low      ")
     end 
  elseif conSum == 0 then
     textCol(1,0,0,1)
        write(DisX,DisY,"Empty    ")
      else 
        textCol(1,1,0,1)
        --write(DisX,DisY,"         ")
        if Contents[6] == 1 then 
        write(DisX,DisY,"Caution  ")
        else
        write(DisX,DisY,"Normal   ")
        end
        textCol(1,1,1,1)
      end
end
--Screen List End

if conSum > x then
  if Contents[6] == 1 then 
     if IND == 1 then 
       LightSPL(Light,10.0, 0.0, 0.0,10.0,Contents)
        IND = 0
         computer.millis(1000)
          else
           LightSPL(Light,10.0, 10.0, 10.0,0,Contents)
            IND = 1
             computer.millis(1000)
              end


if ELight == true then LightSPL(Light,10.0, 0.0, 0.0,10.0,Contents) end
 else
  if ELight == true then LightSPL(Light,0.0,10.0, 0.0,10.0,Contents) end
end
  
  if EPower == true then Connection(Power,false,Contents) end
  
elseif conSum > y then
  
  if ELight == true then LightSPL(Light,10.0,10.0, 0.0,10.0,Contents) end
  
elseif conSum < z then
if Contents[6] == 1 then
  if ELight == true then LightSPL(Light,0.0, 10.0, 0.0,10.0,Contents) end
 else
  if ELight == true then LightSPL(Light,10.0, 0.0, 0.0,10.0,Contents) end
end
  if EPower == true then Connection(Power,true,Contents) end
  end

else 
FLAG = 1 print(ERR[3]..Contents[7]) Contents[3] = 1 
end
end
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end
-- Container Status Main End--
--Liquid Tanks Storage Function ##################################################################
--Gas Tanks Storage Function #####################################################################


-- Screen System Main P2/3 ############################################################################-- 
--print(SystemScreenSys[1]..SystemScreenSys[2])
function clearScreen() -- Issue #8
  gpu:setForeground(1,1,1,1)
  gpu:setBackground(0,0,0,0)
  --gpu:setBackground(colors[1],colors[2],colors[3],colors[4])
  gpu:fill(0,0,200,55," ")
  --gpu:flush()
  return w,h
end

function textCol(x,y,z,i)
gpu:setBackground(0,0,0,0)
gpu:setForeground(x,y,z,i)
end

function write(x,y,z)
gpu:setText(x,y,z)
end

function clearLoc(x,y,z)
gpu:setBackground(0,0,0,0)
gpu:setForeground(1,1,1,1)  
gpu:setText(x,y,z)
end

function DisBoarder(x,y,Times,Title,TitleText)
textCol(1,1,1,1)
local s = x
local t = y

if Title == false then else
write(s,t,"O---------------------[[  "..TitleText)
s = s + 46
write(s,t,"  ]]---------------------O")
t = t+1
end

s=x
write(s,t,"O-Container----O-Contents-----------------------O-Amount---O-Status----O")
t=t+1
for z=1, (Times) do
write(s,t,"|")
s= s +15
write(s,t,"|")
s= s +33
write(s,t,"|")
s = s + 11
write(s,t,"|")
s = s + 12
write(s,t,"|")
s=x
t=t+1
end
write(s,t,"O--------------O--------------------------------O----------O-----------O")
end

function LayoutMode(X,Y)
textCol(1,0,0,1) 
write(X,Y,"#") 
gpu:setForeground(1,1,1,1)
gpu:setBackground(0,0,0,0)
end
-- Screen System Main  P2/3 End --


--- LightStatus Pole V2 ---
LightSys = {"Light System Ver : ","2.0.1"}
function LightSPL(LightNumber,RED,GREEN,BLUE,INTENSITY,Contents)

if FLAG == 0 then
 if TEST == 1 then
  Contents[4] = 0
 end
end

function LigData() 
ContLight = component.proxy(component.findComponent(LightNumber)[1])
end

if Contents[4] == 1 then else
  if pcall (LigData) then
   LigData()
   ContLight:setColor(RED,GREEN,BLUE,INTENSITY)
  else 
   FLAG = 1 print(ERR[4]..Contents[7]) Contents[4] = 1 end
  end
end

function Blink(r,g,b)
if IND == 1 then 
  progstat:setcolor(1,0,0,5)
  ProgramStat:setColor(10,0,0,10)
  if CBeep == true then computer.beep() end
  IND = 0
  computer.millis(1000)
else
  progstat:setcolor(1,1,1,0)
  ProgramStat:setColor(1,1,1,0)
  IND = 1
  computer.millis(1000)
end
--event.pull(1)
end



--- Power Conections / Monitoring ---
PowerSys = {"Power System Ver : ","4.0.2"}
function Connection(x,y,Contents)
if FLAG == 0 then
 if TEST == 1 then
  Contents[5] = 0
  end
end

function GPwrSwitch()
Comp = component.proxy(component.findComponent(x)[1])
end


if Contents[5] == 1 then else
if pcall (GPwrSwitch) then

GPwrSwitch()

Comp.isSwitchOn = y

else 
 FLAG = 1 print(ERR[5]..Contents[7]) Contents[5] = 1 
end
end
end --Function Connection End
--- Power Connections End ---


-- System print to screen and other
function SystemInfo(DisX,DisY) --83 0
textCol(1,1,1,1)
x = DisX
y = DisY

write(DisX,y,"O================================#")
y = y +1
write(DisX,y,"| "..ProgName)
y = y +1
write(DisX,y,"| By : "..By)
y = y +1
write(DisX,y,"| Prg Ver : "..Ver)
y = y +1
write(DisX,y,"| Mod Ver : "..MVer)
y = y +1
write(DisX,y,"| Run Time: "..Days.." | "..Hrs.." : "..Mins.." : "..Sec)
y = y +1
write(DisX,y,"O--------------------------------O")

x = x + 33
y = DisY + 1
write(x,y,"|")
y = y + 1
write(x,y,"|")
y = y + 1
write(x,y,"|")
y = y + 1
write(x,y,"|")
y = y + 1
write(x,y,"|")-- +33
textCol(1,1,1,1)
end

function ErrorBoxDis(x,y)
write(x,y,"O-[ System ] --------------------O")
y = y + 1
write(x,y,"|                                |")
y = y + 1
write(x,y,"|                                |")
y = y + 1
write(x,y,"|                                |")
y = y + 1
write(x,y,"|                                |")
y = y + 1
write(x,y,"O--------------------------------O")
end

-- Boot Loop -- Add anything thats needs to be loaded before the main loop here
function Boot()


if BFlag == 0 then
clearScreen()
write(0,0,"Ficsit Production Manager 3030")
write(0,1,"Prg Ver : "..Ver)
write(0,2,"Mod Ver : "..MVer)
write(0,3,"Build   : "..Build)
gpu:flush()
print("O--------------------------------O")
print("|",ProgName,"|")
print("| By : "..By,"                |")
print("| Prg Ver : "..Ver,"              |")
print("| Mod Ver : "..MVer,"               |")
print("| Build   : "..Build.."|")
print("O--------------------------------O")

if dev == 1 then
print("Item List Ver    : ".. ListVer[1])
if EnableScreen == false then print(SYS[4]) else print(SystemScreenSys[1]..SystemScreenSys[2]) end
end
BFlag = 1
if EnableStausLight == true then progstat:setColor(10.0, 0.0, 10.0,5.0) ProgramStat:setColor(10,0,10,5.0)end
print("[System] : Checking....")
if Ver == UVer[1] then else print("[System] : New Update On Git") end
if ListVer == UVer[2] then else print("[System] : List is not current version") end
if MVer == UVer[3] then else print("[System] : Program may not be compactable with this mod version") end
sleep(5)
if STA == "" then print("[System] : Program needs setting up") else print("[System] : Boot Ok!") end
 end
end
-- End of Boot Loop --################################################################################

function DisplayAmmounts(Name, RReact, LocX, LocY)
    textCol(1,1,1,1)
    write(LocX,LocY,Name)
end

function round(x)
local f = math.floor(x)
 if (x == f) or (x % 2.0 == 0.5) then 
  return f
 else 
  return math.floor(x + 0.5)
 end
end

function sleep(x)
x = x * 1000
local millis = computer.millis()
    while computer.millis() - millis < x do
        computer.skip()
    end
end

--function sleep(x)
--event.pull(x)
--end



--##########################################################################################################
  function MainLoop() if EnableScreen == true then clearScreen() end 
--##########################################################################################################
ITEMDISPLAY()
ITEMLIST()

if Cat == 0 then
Cat = 1
else
Cat = 0
end

Loop = Loop + 1

if Tick == 255 then
 Sec = Sec + 1
 Tick = 0
end

if Sec == 60 then
 Mins = Mins + 1
Sec = 0
end

if Mins == 60 then
 Hrs = Hrs + 1
 Mins = 0
end

if Hrs == 24 then
 Days = Days + 1
 Hrs = 0
end
  
--##########################################################################################################
end
--##########################################################################################################

function selfTest()
 if EnableStausLight == true then 
  progstat:setColor(10.0, 0.0, 0.0,10.0) 
  ProgramStat:setColor(10,0,0,10) -- Added Panel light to replace progstat
 end
  print(ERR[2])
  FLAG = 0
  TEST = 1
end


while true do
write(0,0,"Booting System Up")
Boot()
--print(FLAG)
MainLoop()

--ErrorBoxDis(0,50)
  if EnableStausLight == true then
   if FLAG == 0 then progstat:setColor(0.0, 10.0, 0.0,10.0) ProgramStat:setColor(0,10,0,10) end
    if FLAG == 1 then Blink() end
  end
    
if FLAG == 1 then if Sec == 30 then selfTest() end else TEST = 0 end
if DATASENT == true then if Sec == 0 then DATASENT = false end end

-- Screen System Main P3/3 ##############################################################################--
if EnableScreen == true then gpu:flush() end
sleep(1)
Sec = Sec + 1
Tick = Tick + 1
-- Screen System Main P3/3 End--
end -- while true loop end
