/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if y <= -sprite_height{
    y = room_height + sprite_height
}

if instance_place(x, y, obj_playerParent){
    var _player = instance_place(x, y, obj_playerParent)
    
    _player.STATE = _player.damageState
}