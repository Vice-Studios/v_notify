local resourceName = GetCurrentResourceName()
local curVersion = GetResourceMetadata(resourceName, "version", 0)

local githubUser = "Vice-Studios"       -- <-- CHANGE THIS
local githubRepo = "v_notify"                   -- <-- CHANGE THIS

local checkURL = ("https://api.github.com/repos/%s/%s/releases/latest")
    :format(githubUser, githubRepo)


-- Perform periodic version checks
CreateThread(function()
    -- small delay so console prints look clean
    Wait(2500)

    while true do
        PerformHttpRequest(checkURL, function(err, body)
            if err ~= 200 then
                print("^0[^3v_notify^0] ^3Could not check version (GitHub API error).^0")
                return
            end

            local data = json.decode(body)
            local repoVersion = data.tag_name or "unknown"
            local repoURL = data.html_url or ("https://github.com/" .. githubUser .. "/" .. githubRepo)

            if curVersion ~= repoVersion then
                print("")
                print("^0[^3v_notify^0] ^1UPDATE AVAILABLE!^0")
                print("^0[^3v_notify^0] Current version: ^1" .. curVersion .. "^0")
                print("^0[^3v_notify^0] Latest version: ^2" .. repoVersion .. "^0")
                print("^0[^3v_notify^0] Download: ^2" .. repoURL .. "^0")
                print("")
            else
                print("^0[^2v_notify^0] You are running the latest version (^2" .. curVersion .. "^0)")
            end
        end, "GET")

        -- checks every hour
        Wait(3600000)
    end
end)
