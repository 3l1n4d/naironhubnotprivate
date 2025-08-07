-- ===================================================================
--                       NAIRON SCRIPT
--                 UI Library: Rayfield
--                Blox Fruits Player Info
-- ===================================================================

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Nairon",
    LoadingTitle = "Loading Nairon",
    LoadingSubtitle = "By 3l1n4d",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "NaironConfig"
    },
    Discord = {
        Enabled = true,
        Invite = "6gtCDYcS", -- Only the invite code, not the full link
        RememberJoins = true
    }
})

-- Check if the current game is Blox Fruits (good practice)
if game.PlaceId == 2753915549 then
    local MainFarmTab = Window:CreateTab("Farm", 4483362458)
    
    -- ==== PLAYER INFORMATION SECTION ====
    -- We create a section to keep things organized within the "Farm" tab.
    
    MainFarmTab:CreateSection("Player Information")

    -- Create the UI elements that will display the information.
    -- We store them in variables so we can update them later using the :Set() method.
    local LevelLabel = MainFarmTab:CreateLabel("Level: Loading...")
    local BeliLabel = MainFarmTab:CreateLabel("Beli: Loading...")
    local FragsLabel = MainFarmTab:CreateLabel("Fragments: Loading...")
    local FruitLabel = MainFarmTab:CreateLabel("Equipped Fruit: Loading...")

    -- A Paragraph is perfect for displaying the multi-line stats.
    local StatsParagraph = MainFarmTab:CreateParagraph({
        Title = "Stats", 
        Content = "Loading..."
    })

    -- ==== INFORMATION UPDATE LOGIC ====
    
    -- Get a reference to the LocalPlayer to make the code cleaner.
    local player = game:GetService("Players").LocalPlayer

    -- Use task.spawn() to run this loop in a separate thread.
    -- This prevents the UI or the game from freezing.
    task.spawn(function()
        -- The 'while' loop will run forever, updating the info every second.
        while task.wait(1) do
            
            -- Use a pcall (protected call) to run the code safely.
            -- If an error occurs (e.g., data hasn't loaded yet), the script won't break.
            local success, err = pcall(function()
                
                -- Create shortcuts to the data folders
                local playerData = player.Data
                local playerStats = playerData.Stats

                -- Get the values using the exact paths you provided
                local level = playerData.Level.Value
                local beli = playerData.Beli.Value
                local frags = playerData.Fragments.Value
                local fruitName = playerData.DevilFruit.Value or "None" -- Use "None" if no fruit is equipped

                -- Get the stat values
                local meleeStat = playerStats.Melee.Level.Value
                local defenseStat = playerStats.Defense.Level.Value
                local swordStat = playerStats.Sword.Level.Value
                local gunStat = playerStats.Gun.Level.Value
                -- Use ["Name"] for properties with spaces
                local fruitStat = playerStats["Demon Fruit"].Level.Value 

                -- Format the stats into a clean, multi-line string
                local statsContent = string.format(
                    "Melee: %d\nDefense: %d\nSword: %d\nGun: %d\nDemon Fruit: %d",
                    meleeStat, defenseStat, swordStat, gunStat, fruitStat
                )

                -- Update the text of the Rayfield elements
                LevelLabel:Set("Level: " .. level)
                -- string.format("%.0f", ...) is a clean way to remove decimals from numbers
                BeliLabel:Set("Beli: " .. string.format("%.0f", beli))
                FragsLabel:Set("Fragments: " .. string.format("%.0f", frags))
                FruitLabel:Set("Equipped Fruit: " .. fruitName)
                
                -- Update the paragraph with the new stats content
                StatsParagraph:Set({Title = "Stats", Content = statsContent})
            end)

            -- If the pcall failed, print the error to the developer console (F9) for debugging.
            if not success then
                warn("[Nairon] Error updating player info:", err)
            end
        end
    end)

else
    -- Your notification code for unsupported games
    Rayfield:Notify({
        Title = "Nairon",
        Content = "Game not supported. Supported game: Blox Fruits",
        Duration = 6.5,
        Image = 4483362458,
    })
end