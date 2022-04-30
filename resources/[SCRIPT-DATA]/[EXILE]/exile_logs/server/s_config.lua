--[[
        [tekken#6322]
                              
       \`*-.                 
        )  _`-.                 
       .  : `. .                    exports.exile_logs:discord(source, "ze screenem", "bank_deposit", true)
       : _   '  \                   exports.exile_logs:discord(source, "bez screena", "bank_deposit", false)
       ; *` _.   `*-._              TriggerServerEvent("exile_logs:triggerLog", "ze screenem", "bank_deposit", true)
       `-.-'          `-.           TriggerServerEvent("exile_logs:triggerLog", "bez screena", "bank_deposit", false)
         ;       `       `.     
         :.       .        \    
         . \  .   :   .-'   .   
         '  `+.;  ;  '      :   
         :  '  |    ;       ;-. 
         ; '   : :`-:     _.`* ;
     .*' /  .*' ; .*`- +'  `*' 
      `*-*   `*-*  `*-*'
]]

Settings = {

    username = "IslandRP WL-ON",
    color = "328965",
    icon_url = "https://cdn.discordapp.com/icons/782980098587361280/a_b45bbb1bf08c74e7633d791716666ece.png?size=512",

    webhoks = {

        --lobby
        join = "https://discord.com/api/webhoks/938876977077686322/yHC-SJ8khjkhjkhjUbz5ZExc1PJzmnj6DW_ELBFyjqEyFnD3",
        leave = "https://discord.com/api/webhoks/938877007587070072/qkN8JKu_1WrQmJgfherthfdfdfhA64zIfSSWfucR_fSMnmN",


    },
}