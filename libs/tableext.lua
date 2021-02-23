local _C=class()

function table.new()
    return _C.new()
end

function _C:ctor()
    self.__mTb={}
end

function _C:insert(value,pos)
    if not pos then
        table.insert(self.__mTb,value)
    else
        table.insert(self.__mTb,pos,value)
    end
end

function _C:copy()
    return table.copy(self.__mTb)
end

function table.copy(tab)
    local tbs={}
    for _,it in pairs(tab)do
        local tb={}
        for k,v in pairs(it)do
            if type(v) == "table" then
                tb[k]=table.copy(v)
            else
                tb[k]=v
            end
        end
        table.insert(tbs,tb)
    end

    return tbs
end

function _C:toMap()
    self.__mTb=table.tomap(self.__mTb)
end
function table.tomap(ptr,key)
    if not key then
        return nil
    end

    local cpTab=table.copy(ptr)
    local tab={}
    for _,v in pairs(cpTab)do
        local tb=v
        tb.key=nil
        tab[key]=tb
    end

    return tab
end

function _C:toTable()
    return table.totable(self.__mTb)
end
function table.totable(ptr,key)
    if not key then
        return nil
    end

    local cpTab=table.copy(ptr)
    local tab={}
    for k,v in pairs(cpTab)do
        local tb=v
        tb[key]=k
        table.insert(tab,tb)
    end

    return tab
end

function _C:dump()
    table.dump(self.__mTb)
end
function table.dump(tb,index)
    if not index then
        index=0
    end

    if not tb then
        return
    end

    for k,v in pairs(tb)do
        if type(v) ~= "table" then
            print(k.."("..type(k)..")".."="..v.."("..type(v)..")")
        else
            dump(tb,index+1)
        end
    end

    index=index-1
end