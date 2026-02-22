/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


//Variaveis de velocidade
velh = 0
velv = 0
velvMax = -3.7

vel = 2

//Variaveis de Input
right = noone
left = noone
jump = noone
    

restartInput = noone


//Variaveis da movimentação vertical
grv = .3
jumpVel = 4

//StateMachine
STATE = idleState


//direção
dir = 1

//varivel de colisores
collisions = [
    obj_coll
]

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
    changeSprite(spr_playerIdle)
    
    //zerando a collision mask
    mask_index = spr_playerIdle
    
    //Setando verificações e movimentando
    MoveVerify()
    jumpVerify()
    move()
    
    
    y = round(y)//Arredondando o y
}
function moveState(){
    mask_index = spr_playerIdle
    
     //mudnado sprite
    changeSprite(spr_playerMove)
    
    //Fazendo o dir apontar a direção entre 1, 0 ou -1
    if velh != 0{dir = sign(velh)}else{STATE = idleState}
        
    //Setando verificações e movimentando
    MoveVerify()
    jumpVerify()
    move()
}

//estado de pulo
function jumpState(){

    mask_index = spr_playerIdle

        changeSprite(spr_player01Jump)

    
    //Se está no chao, cmc a verificação de movimentação
    if instance_place(x, y+1, collisions){
        MoveVerify()
    }
    //Movendo
    move()
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

//funções
function takeInputs(){
    right = keyboard_check(ord("D"))
    left = keyboard_check(ord("A"))
    jump = keyboard_check_pressed(vk_space)
    attack = mouse_check_button_pressed(mb_left)
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
        velv += grv
    }
    
    //Movimentação horizontal
        velh = (right - left)*vel  //positivo vai a direita, negativo vai a esquerda
    
    //Colisão
   move_and_collide(velh, 0, collisions, 12) 
   move_and_collide(0, velv, collisions, 12)
    
    if velh != 0{image_xscale = sign(velh)}
    
}
