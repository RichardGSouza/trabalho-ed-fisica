# Player 1

`Script/Player_1.gd` - CharacterBody2D

## Habilidade
Pulo duplo (MAXIMO_DE_PULOS = 2)

## Constantes
- SPEED = 250
- GRAVITY = 1000
- JUMP_SPEED = -400
- ESCADA_VELOCIDADE = 150

## Funções
- `resetarProSpawn()` - Volta ao spawn point
- `morrer()` - Reseta os dois jogadores
- `checarColisaoEspinho()` - Verifica colisão com SpikeLayer
- `entrar_na_escada()` - Chamado ao entrar em uma escada (Area2D)
- `sair_da_escada()` - Chamado ao sair de uma escada (Area2D)

## Variáveis
- `forca_corda` - Força aplicada pela corda (controlada pelo script da corda)
- `direcao_olhando` - Direção do último movimento horizontal (usada no flip do sprite)
- `na_escada` - Indica se o jogador está em uma escada (permite subir com pulo)

## Animações
Usa `AnimatedSprite2D` com o recurso `sprites/ademar-rosio/ademar_animations.tres`.

| Animação | Sprite |
|----------|--------|
| `idle` | `ademar-idle.png` |
| `run` | `ademar-run.png` (spritesheet 3 frames, extraída do `ademar-run.gif`) |
| `jump` | `ademar-jump.png` |
| `djump` | `ademar-djump.png` (segundo pulo) |
| `fall` | `ademar-fall.png` |

A seleção é feita em `atualizarAnimacao(direction)`:
- no ar subindo: `jump` ou `djump` (conforme `pulos`)
- no ar caindo: `fall`
- no chão andando: `run`
- parado: `idle`
