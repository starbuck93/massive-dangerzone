--project: FinalNoNameYet
--Adam Starbuck 2014

local composer = require("composer")
display.setStatusBar( display.HiddenStatusBar )

--splash screen, then menu

local options =
{
    effect = "fade",
    time = 1000,
}

composer.gotoScene("menu", options)

