/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

mask_index = spr_player02Idle

damageVerify()

STATE()
takeInputs()

if instance_place(x, y, obj_blockTeleport){
    var _block = instance_place(x, y, obj_blockTeleport)
    
    y = _block._yy
    x = _block._xx
}

if instance_place(x, y, obj_finalPortal){
    if !finalPortal{
        global.portalCounter++
        finalPortal = true
    }
}
if global.portalCounter >= 2 && !finalStarted {
    layer_sequence_create("Sequences", 0, 0, sq_finalScene);
    finalStarted = true;
    audio_stop_all()
    audio_play_sound(sn_finalMusic, 1, 1)
}

if finalStarted && keyboard_check_pressed(vk_anykey){
    room_goto(Menu);
    finalPortal = false
    global.portalCounter = 0
    finalStarted = 0
}
