# ----------------------------------------------------------------
# 島耕作っちに自動で投票しよう！
# ----------------------------------------------------------------

# Entry number
num = 0
end = 0
max = 10000
_fncs = []
home_url = 'http://tamagotch.channel.or.jp/event/event_anniversarycontest/'
f = ->
    return


# Headless
page = require('webpage').create()


# init
page.onInitialized = ->
    page.evaluate ->
        document.addEventListener 'DOMContentLoaded', ->
            window.callPhantom 'DOMContentLoaded'
            return
        , false
        return
    return


# Function Thread
LoginTest = (f) ->
    this.f = f
    this.init()
    return


LoginTest.prototype = {
    # load to next
    init: ->
        self = this
        page.onCallback = (data) ->
            if data == 'DOMContentLoaded'
                self.next()
            return
        return

    # run to function
    next: ->
        this.f()
        return
}


# functions
fncs = [
    (parent) ->
        console.log '--------------- Shimakousaku-chi Entry ' + num + ' ---------------'
        page.open home_url
        return
    ,
    (parent) ->

        ###
        console.log 'open entry'
        fn = 'arr = document.getElementById("form1"); arr.elements["select_ans"].value = "46"; arr.elements["mode"].value = "conf"; arr.elements["contest_id"].value = "1"; arr.submit();'
        page.evaluate new Function(fn)
        return
        ###

        console.log 'entry...'
        # page.render num + '_shima.png'
        fn = 'arr = document.getElementById("form1"); arr.elements["select_ans"].value = "46"; arr.elements["mode"].value = "send"; arr.elements["contest_id"].value = "1"; arr.submit();'
        page.evaluate new Function(fn)
        return
    ,
    (parent) ->
        console.log 'entry complate!'
        # page.render num + '_shima_done.png'
        console.log 'done: (' + (num + 1) + '/' + max + ')'
        page.clearCookies()
        page.open home_url
        return
    ,
    (parent) ->
        console.log 'LAST'
        return
]

recursive = (i) ->
    if i < fncs.length - 1
        page.onLoadFinished = ->
            recursive(i + 1)
            return
        fncs[i]()
    else
        if max <= ++num
            console.log '--------------- END ---------------'
            phantom.exit()
        else
            recursive 0
    return

recursive 0
