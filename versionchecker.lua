--[[ Version Checker ]]--
local version = "1.0"

AddEventHandler("onResourceStart", function(resource)
    if resource == GetCurrentResourceName() then
        CheckFrameworkVersion()
    end
end)

function CheckFrameworkVersion()
    PerformHttpRequest("https://raw.githubusercontent.com/HazeyDev/scriptname/master/version.txt", function(err, text, headers)
        if string.match(text, version) then
            print(" ")
            print("---------- ***** VERSION ----------")
            print(" Script is up to date and ready to go!")
            print("https://github.com/HazeyDev/VehicleSaver")
            print("--------------------------------")
            print(" ")
        else
            print(" ")
            print("---------- ***** VERSION ----------")
            print("Script is outdated. Update for more features!")
            print("https://github.com/HazeyDev/VehicleSaver")
            print("--------------------------------")
            print(" ")
        end

    end, "GET", "", {})

end
