// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

global.cool = [
    obj_coll,
    layer_tilemap_get_id("Tileset"),
    layer_tilemap_get_id("TilesetSide02")
]

global.fail = false
global.wins = 0
global.portalCounter = 0

global.signs = [
    spr_text01,
    spr_text02,
    spr_text03,
    spr_text04,
    spr_text05,
    spr_text06
]

function inicialSequence(){
    sequence = 0
    sequenceTime = room_speed / 2
}

function sequenceFunc(){
    layer_sequence_create("Sequences", 0, 0, sq_back)

    if sequence >= sequenceTime{
        room_goto_next()
        sequence = 0
    }
    
    sequence ++
}