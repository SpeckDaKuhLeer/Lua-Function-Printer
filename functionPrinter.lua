--[[
--
-- This script is used to test wavefunctions. It will print them into the terminal.
-- Edit the parameters in the beginning of the script to change the visuals.
-- The function waveFunction() will define your ... wavefunction. *amazing*
--
--]]

-- ###### Configuration ######

-- size that will be printed into the terminal (double the size because +x and -x, ...)
local graphSizeX = 80
local graphSizeY = 20

-- defines how many numbers are one char, the higher the number the more needs to calculated
local calculationRatioX = 20
local calculationRatioY = 0.1

function waveFunction(x)
    local y = 0
    
    fadeoutRatio = 10 -- (>0)
    y = math.sin(x * (math.pi * 2) / 360)
    y = y * math.pow(1.01, -x/fadeoutRatio)

    return y
end

-- ###### Execution ######

local output = {}

-- init the table, every field except for the cross in the middle will be printed as $space
for currentRow = -graphSizeX, graphSizeX do
    output[currentRow] = {}

    for currentLine = -graphSizeY, graphSizeY do
        output[currentRow][currentLine] = " "
    end
end

-- generate the waveform
local waveForm = {}
local waveFormLenght = graphSizeX * calculationRatioX

-- calculate the waveform
for currentRow = -waveFormLenght, waveFormLenght do
    waveForm[currentRow] = waveFunction(currentRow)
end

-- output the waveform into the output table
for currentRow = -waveFormLenght, waveFormLenght do
    local row = math.ceil(currentRow / calculationRatioX)
    local yValue = math.ceil(waveForm[currentRow] / calculationRatioY)
    
    if yValue >= -graphSizeX and yValue <= graphSizeX then
        output[row][yValue] = "#"
    end
end

-- print the cross
for currentRow = -graphSizeX, graphSizeX do
    for currentLine = -graphSizeY, graphSizeY do
        if currentRow == 0 and currentLine == 0 then
            output[currentRow][currentLine] = "+"
        elseif currentRow == 0 then
            output[currentRow][currentLine] = "|"
        elseif currentLine == 0 then
            output[currentRow][currentLine] = "-"
        end
    end
end

-- print the table
local outputString = ""

-- convert the table into a string
-- iterate from + to - because otherwise minus would be on top
for currentLine = graphSizeY, -graphSizeY, -1 do
    for currentRow = -graphSizeX, graphSizeX do
        outputString = outputString .. output[currentRow][currentLine]
    end
    outputString = outputString .. "\n"
end

print(outputString)
print("Max X: " .. graphSizeX * calculationRatioX .. " (" .. graphSizeX .. " Chars, 1 Char = " .. calculationRatioX .. " Steps)")
print("Max Y: " .. graphSizeY * calculationRatioY .. " (" .. graphSizeY .. " Chars, 1 Char = " .. calculationRatioY .. " Steps)")
