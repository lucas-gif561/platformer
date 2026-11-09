# Platformer

Jogo de plataforma cooperativo para dois jogadores no mesmo teclado, feito em Godot 4.7 para a AC3 de Game Development.

## Controles

| Ação | Jogador 1 | Jogador 2 |
|---|---|---|
| Andar | A / D | Seta esquerda / direita |
| Pular (duas vezes) | W ou Espaço | Seta para cima |

**R** reinicia a fase. **Enter** recomeça o jogo na tela final.

## Regras

- São três fases de dificuldade crescente. Qualquer jogador vivo que alcançar a bandeira conclui a fase.
- Se um jogador morrer, o outro continua. A fase reinicia quando os dois morrem.
- A pontuação passa de uma fase para a outra. Ao reiniciar, volta ao valor que a dupla tinha no início da fase.
- Cair em um buraco mata o jogador.
- A câmera enquadra a dupla e respeita os limites do mapa. Os jogadores não podem se afastar mais do que ela consegue mostrar.

## Publicação web

No Godot, use **Projeto > Exportar > Web** ou rode, na pasta do projeto:

```bash
godot --headless --export-release Web build/web/index.html
```

Compacte o conteúdo de `build/web/` em um `.zip`, com `index.html` na raiz, e envie ao Itch.io como jogo HTML.
