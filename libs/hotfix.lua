local _M={}

_M.mods = {}

function _M.init()
    --针对skynet热更缓存
    xpcall(function()
        local codecache= require "skynet.codecache"
        codecache.mode('OFF')
    end,function()end)
end

function _M.require(name)
    if _M.mods[name] then
        return _M.mods[name]
    end

    local mod = require(name) -- 不做检测，错误直接报
    _M.mods[name] = mod

    if mod.onLoad then
        mod.onLoad()
    end

    return mod
end

function _M.reload(name)
    if not _M.mods then
        return false
    end

    if not package.loaded[name] then
        return false
    end

    local mod = _M.mods[name]
    if mod.beforeReload then
        mod.beforeReload()
    end

    package.loaded[name] = nil
    local newMod = require(name)
    for it,_ in pairs(mod)do
        mod[it] = nil
    end

    if mod.onReload then
        mod.onReload()
    end

    for k,v in pairs(newMod)do
        mod[k]=v
    end

    return true
end

return _M