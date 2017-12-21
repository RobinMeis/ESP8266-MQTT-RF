function switchOnA(house_code, unit_code)
    code = 1

    code_index = 4
    for i=0,4,1 do
        if (not bit.isset(unit_code, i)) then
            code = bit.set(code, code_index)
        end
        code_index = code_index + 2
    end

    for i=0,4,1 do
        if (not bit.isset(house_code, i)) then
            code = bit.set(code, code_index)
        end
        code_index = code_index + 2
    end
    
    rfswitch.send(1, 350, 7, PIN, code, 24)
end

function switchOffA(house_code, unit_code)
    code = 4

    code_index = 4
    for i=0,4,1 do
        if (not bit.isset(unit_code, i)) then
            code = bit.set(code, code_index)
        end
        code_index = code_index + 2
    end

    for i=0,4,1 do
        if (not bit.isset(house_code, i)) then
            code = bit.set(code, code_index)
        end
        code_index = code_index + 2
    end
    
    rfswitch.send(1, 350, 7, PIN, code, 24)
end
