local _break, _continue = {}, {};

local _status, _return = pcall(function()
    ------------------------------------
    ---- try begin
    error("test")
    ---- try end
    ------------------------------------
end);

-- No exception
if(_status) then

    ------------------------------------
    ---- finally begin
    print("finally");
    ---- finally end
    ------------------------------------

    -- There was a break reached
    if(_return == _break) then
    --break;

    elseif(_return == _continue) then
    --goto continue
    end

    if(_return ~= nil) then
    -- Simple return reached
    -- return _return
    end

else
    -- Exception thrown in try

    -- Execute catch clause
    local _cstatus, _creturn = pcall(function()
        local e = _return;
        ------------------------------------
        ---- Catch begin
        print("Caught error: " .. e);
        error(e);
    --- Catch end
    ------------------------------------
    end);

    ------------------------------------
    ---- finally begin
    print("finally");
    ---- finally end
    ------------------------------------


    if _cstatus then
        -- There was a break reached
        if(_creturn == _break) then
        --break;

        elseif(_creturn == _continue) then
        --goto continue
        end

        if(_creturn ~= nil) then
        -- Simple return reached
        -- return _creturn
        end
    else
        -- If there was an Exception raised in the catch clause
        -- forward it
        error(_creturn);
    end
end
