

local en_ru = {
    look="смотреть",
    take="взять",
    open="открыть",
    close="закрыть",
    go="идти",
    north="север",
    south="юг",
    east="восток",
    west="запад",
    up="вверх",
    down="вниз",
    inventory="инвентарь",

    you="вы",
    the="",
    a=" ",
    an=" ",

    door="дверь",
    mailbox="почтовый ящик",
    house="дом",
    window="окно",
    forest="лес",
    clearing="поляна",
    path="тропа",
    building="здание",
    tree="дерево",
    trees="деревья",
    leaf="лист",
    leaves="листья",
    ground="земля",
    grass="трава",
    stone="камень",
    rock="камень",
    field="поле",
    stream="ручей",

    lamp="лампа",
    lantern="фонарь",
    key="ключ",
    leaflet="листок",
    welcome="добро пожаловать",
    zork="зорк",
    room="комната",
}

local old_write = io.write

local function translate(s)
    return (s:gsub("(%w+)", function(w)
        local key = w:lower()
        local tr = en_ru[key]
        if tr then
            -- preserve capitalization of first letter
            if w:match("^[A-Z]") then
                return tr:gsub("^.%l", string.upper)
            end
            return tr
        end
        return w
    end))
end

io.write = function(...)
    local out = {}
    for i = 1, select("#", ...) do
        local s = tostring(select(i, ...))
        out[#out+1] = translate(s)
    end
    return old_write(table.concat(out))
end
