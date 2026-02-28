/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if global.fail && !instance_exists(obj_failScreen){
    layer_sequence_create("Sequences", 0, 0, sq_failScreen)
}

if keyboard_check_pressed(ord("R")) && room != Menu{
    room_restart()
    global.fail = false
}

if global.wins >= 2{
    layer_sequence_create("Sequences", 0, 0, sq_back)
    if sequence >= sequenceTime{
        room_goto_next()
        
        sequence = 0
    }
    
    sequence++
}

