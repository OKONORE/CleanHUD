------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------- Addon by OKONORE (contacts: discord = OKONORE#4423 ; Steam = https://steamcommunity.com/id/okonore/) ----------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------| Config |------------------------------------------------------------------------------------

-- in "disabled_defaults.lua" you need to have "hud" set on true
-- dans "disabled_defaults.lua" vous devez avoir "hud" définit sur vrai

-- If you want to change the money character, change it in "settings.lua" and change it in "GM.Config.currency" = "character"
-- si vous voulez changer le symbole de la monnaie, vous pouvez le changer dans "settings.lua" et le changer dans "GM.Config.currency" = "symbole"

-- If you want to change the currency character position ($15 or 15$) change dans "settings.lua" "GM.Config.currencyLeft = true/false" (true = left / false = right)
-- Si vous voulez changer la position du logo de la monnaie (€10 ou 10€) changez dans "settings.lua" "GM.Config.currencyLeft = true/false" (true = gauche / false = droite)

local armor_bar         = true                        -- true if you want amorbar / true si vous voulez une barre d'armure
local hunger_bar        = true                        -- true if you want hugerbar, !only DarkRP! (hungermod need to be true)  / true si vous voulez une barre de faim !Uniquement DarkRP! (hungermod doit être activé)
local money_text        = true                        -- true if you want money value !only DarkRP! / true si vous voulez la somme d'argent que vous avez !Uniquement DarkRP!
             
local ecart             = 25                          -- distance between each bars (recommanded min. = 20) / Ecartement entre chaques barres (minimum recomandé = 20)
local SEcart            = 90                          -- Distance between the edge of the screen and the HUD / Distance entre le HUD et l'écran
local Side              = false                       -- Side of the HUD (true = Right/false = left) / Emplacement du HUD (true = droite / false = gauche)

local money_font        = "LEMON MILK"                -- Change money font / Changer la police d'écriture de l'argent
local Couleur_Text      = Color(255, 255, 255)      -- Change text color (https://www.w3schools.com/colors/colors_rgb.asp) / Changer la couleur du texte (https://www.w3schools.com/colors/colors_rgb.asp)

local Couleur_Vie       = Color(255, 0, 0)          -- Change health color (https://www.w3schools.com/colors/colors_rgb.asp) / Changer la couleur de la vie (https://www.w3schools.com/colors/colors_rgb.asp)
local Couleur_Faim      = Color(255, 150, 0)        -- Change hunger color (https://www.w3schools.com/colors/colors_rgb.asp) / Changer la couleur de la faim (https://www.w3schools.com/colors/colors_rgb.asp)
local Couleur_Armure    = Color(0, 0, 255)          -- Change armor color (https://www.w3schools.com/colors/colors_rgb.asp) / Changer la couleur de l'armure (https://www.w3schools.com/colors/colors_rgb.asp)

------------------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------| Code |------------------------------------------------------------------------------------

--------------------| Setup |------------------------------

--------> Cacher le HUD de base

local hide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true
}
hook.Add("HUDShouldDraw", "CacherdefaultHUD", function(name)
    if hide[name] then return false end
end)

--------> Ecran Adapatif

local function RespX(x) return x/1920*ScrW() end
local function RespY(y) return y/1080*ScrH() end

--------> Nombre de bars (placement)

local nmb_bar = 0

if armor_bar == true then
    nmb_bar = nmb_bar + 1
end

if hunger_bar == true then
    nmb_bar = nmb_bar + 1
end

--------> Emplacement des barres (droite ou gauche)

if Side == true then

Abscisse = 1498
Abscisse2 = 1500
    
else

Abscisse = 46
Abscisse2 = 48

end

--------> Creation des polices d'écriture

surface.CreateFont( "12558746874468451357897", {
font = money_font,
size = 40,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
additive = false,
outline = true,
} )

--------------------| Principal |------------------------------

hook.Add( "HUDShouldDraw", "modefaim", function( name ) if ( name == "DarkRP_Hungermod" ) then return false end
end )

---------------------> HUD

hook.Add("HUDPaint", "OKONOREHUD", function()

-------------> Definitions des variables de base

    Ecart1 = ecart

--------> Variables de Vie/Armure/Faim/Argent

    local armure = math.Clamp(LocalPlayer():Armor(), 0, 100)
    local vie = math.Clamp(LocalPlayer():Health(), 0, 100)
    
    if engine.ActiveGamemode() == "darkrp" then
        
         faim = math.Clamp(LocalPlayer():getDarkRPVar("Energy") or 0, 0, 100)
         argent = DarkRP.formatMoney(LocalPlayer():getDarkRPVar( "money" ))

    else

        faim = 0
        argent = 0

    end

------------> Hud

    if nmb_bar == 2 then
    
--------> Barre de Faim

    surface.SetDrawColor(0, 0, 0, 180)
    surface.DrawRect(RespX(Abscisse), RespY(800 + Ecart1 + SEcart), 304, 14) 
    surface.SetDrawColor(Couleur_Faim)
    surface.DrawRect(RespX(Abscisse2), RespY(802 + Ecart1 + SEcart), faim*3, 10) 

Ecart1 = Ecart1 + ecart 

--------> Barre d'Armure

    surface.SetDrawColor(0, 0, 0, 180)
    surface.DrawRect(RespX(Abscisse), RespY(800 + Ecart1 + SEcart), 304, 14)
    surface.SetDrawColor(Couleur_Armure)
    surface.DrawRect(RespX(Abscisse2), RespY(802 + Ecart1 + SEcart), armure*3, 10)

    Ecart1 = Ecart1 + ecart

    end

    if nmb_bar == 1 then
       
        if armor_bar == true then
           
            --------> Barre d'Armure

            surface.SetDrawColor(0, 0, 0, 180)
            surface.DrawRect(RespX(Abscisse), RespY(800 + Ecart1 + SEcart), 304, 14) 
            surface.SetDrawColor(Couleur_Armure)
            surface.DrawRect(RespX(Abscisse2), RespY(802 + Ecart1 + SEcart), armure*3, 10)

        else
            
            --------> Barre de Faim

            surface.SetDrawColor(0, 0, 0, 180)
            surface.DrawRect(RespX(Abscisse), RespY(800 + Ecart1 + SEcart), 304, 14)
            surface.SetDrawColor(Couleur_Faim)
            surface.DrawRect(RespX(Abscisse2), RespY(802 + Ecart1 + SEcart), faim*3, 10)

        end


    else
    end

    --------> Barre de Vie

    surface.SetDrawColor(0, 0, 0, 180)
    surface.DrawRect(RespX(Abscisse), RespY(800 + Ecart1 + SEcart), 304, 14)
    surface.SetDrawColor(Couleur_Vie)
    surface.DrawRect(RespX(Abscisse2), RespY(802 + Ecart1 + SEcart), vie*3, 10)

    Ecart1 = Ecart1 + ecart

    --------> Barre d'Argent

    if money_text == true then
    surface.SetDrawColor(0, 0, 0, 180)
    surface.DrawRect(RespX(Abscisse), RespY(800 + Ecart1 + SEcart), 304, 40)
    
    draw.SimpleText(argent, "12558746874468451357897", RespX(Abscisse + 10), RespY(800 + Ecart1 + SEcart), Couleur_Text)
    end

end)

