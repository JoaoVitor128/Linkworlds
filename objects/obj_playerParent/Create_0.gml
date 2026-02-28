/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

image_xscale = 1
image_yscale = 1


//Variaveis de velocidade
velh = 0
velv = 0
velvMax = 8

vel = 2

//Variaveis de Input
right = noone
left = noone
jump = noone

restartInput = noone

//win
win = 0

//portal
finalPortal = false
finalStarted = false;

//Variaveis da movimentação vertical
grv = .3
jumpVel = 4

//StateMachine
STATE = idleState
idleSpr = spr_playerIdle
jumpSpr = spr_playerJump
moveSpr = spr_playerMove
deadSpr = spr_playerDead
winSpr = spr_playerWin

//direção
dir = 1

//varivel de colisores
collisions = [
obj_coll,
layer_tilemap_get_id("TileCollSide01"),//Pegando minha layer
layer_tilemap_get_id("TileCollSide02"),  
]

damages = [
    obj_spike,
    obj_flySpike
]

//dead
dead = 0
deadFrame = (room_speed / 5) * 8

//função de mudar sprite
function changeSprite(sprite){
    //Caso ele ja não está na sprite, ele muda
    if sprite_index != sprite{image_index = 0}    
   sprite_index = sprite     
}

//estados

//estado parado
function idleState(){
    //mudnado sprite
    changeSprite(idleSpr)
    
    //zerando a collision mask
    mask_index = spr_playerIdle
    
    //Setando verificações e movimentando
    MoveVerify()
    jumpVerify()
    move()
    winVerify()
    
    y = round(y)//Arredondando o y
}
function moveState(){
    mask_index = spr_playerIdle
    
     //mudnado sprite
    changeSprite(moveSpr)
    
    //Fazendo o dir apontar a direção entre 1, 0 ou -1
    if velh != 0{dir = sign(velh)}else{STATE = idleState}
        
    //Setando verificações e movimentando
    MoveVerify()
    jumpVerify()
    move()
    winVerify()
}

//estado de pulo
function jumpState(){

    mask_index = spr_playerIdle

        changeSprite(jumpSpr)

    
    //Se está no chao, cmc a verificação de movimentação
    if instance_place(x, y+1, collisions){
        MoveVerify()
        STATE = idleState
    }
    //Movendo
    move()
    
    winVerify()
 }

function damageState(){
    changeSprite(deadSpr)
    global.fail = true
    
    if dead >= deadFrame{
        instance_destroy()
    }

    dead++
}

function winState(){
    changeSprite(winSpr)
    var _portal = instance_place(x, y, obj_portal)
    
    
    if win = 0{
        win = 1
        global.wins++
    }
}

//Mudando sprite
function spriteConditional(sprite){
    if image_index > image_number{
        sprite_index = sprite
    }
}

function MoveVerify(){
     if velh != 0{
        STATE = moveState
    }    
}

function jumpVerify(){ 
    if !instance_place(x, y+1, collisions){STATE = jumpState}   
}

function damageVerify(){
    if place_meeting(x, y, damages){STATE = damageState}   
}

function winVerify(){
   if instance_place(x, y, obj_portal){
    var _portal = instance_place(x, y, obj_portal)
    
    if _portal.side == side && instance_place(x, y + 1, collisions){STATE = winState}  
    }   
}

//funções
function takeInputs(){
    right = keyboard_check(vk_right)
    left = keyboard_check(vk_left)
    jump = keyboard_check(vk_up)
}

//Função de mover
function move(){
    //obj_powerUp
    //Caso pise no chão, zera a velociade horizontal e arredonda o y
    if instance_place(x, y+1, collisions){
        velv = 0  //zerando a velocidade horizontal
        y = round(y)//Arredondando o y
        
        //Caso pule e a velocidade vertical não está no máximo ele pula
        if jump{
            if velv - jumpVel < velvMax{
                //Pulando
                velv -= jumpVel      
                  
            }
            

            //Muda o estado para o de pulo
            STATE = jumpState
        }
    }else{
        //aplicando a gravidade
        if velv + grv >= velvMax{velv = velvMax}else{velv += grv}
    }
    
    //Movimentação horizontal
        velh = (right - left)*vel  //positivo vai a direita, negativo vai a esquerda
    
    //Colisão
   move_and_collide(velh, 0, collisions, 12) 
   move_and_collide(0, velv, collisions, 12)
    
    if velh != 0{image_xscale = sign(velh) * 1}
    
}
