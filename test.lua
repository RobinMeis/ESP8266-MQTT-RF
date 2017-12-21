-- House Code 01001 -> F0FF0
-- Code       10000 -> 0FFFF
-- On  F0FF0 0FFFF 0F -> 01 00 01 01 00 00 01 01 01 01 00 01
-- Off F0FF0 0FFFF F0 -> 01 00 01 01 00 00 01 01 01 01 01 00

   --                                   00 01 01 01 01 00 01

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
    
    rfswitch.send(1, 350, 3, 1, code, 24)
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
    
    rfswitch.send(1, 350, 3, 1, code, 24)
end

switchOnA(9, 16)

