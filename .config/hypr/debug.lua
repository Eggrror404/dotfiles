local M = {}

function M.dbg(value, title)
    hl.notification.create {
        text = (title and title .. ": " or "") .. tostring(value),
        duration = 3000,
        icon = "info",
    }
end

function M.inspect_table(tbl)
    local seen = {}

    local function inspect(value, indent)
        indent = indent or 0

        if type(value) ~= "table" then
            if type(value) == "string" then
                return string.format("%q", value)
            end

            return tostring(value)
        end

        if seen[value] then
            return "<cycle>"
        end

        seen[value] = true

        local lines = { "{" }
        local prefix = string.rep("  ", indent + 1)

        for k, v in pairs(value) do
            table.insert(lines, string.format("%s[%s] = %s,", prefix, inspect(k), inspect(v, indent + 1)))
        end

        table.insert(lines, string.rep("  ", indent) .. "}")

        return table.concat(lines, "\n")
    end

    return inspect(tbl)
end

return M
