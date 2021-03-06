.include "constants.inc"
.include "header.inc"

.segment "CODE"
.proc irq_handler
    RTI
.endproc

.proc nmi_handler
    LDA #$00
    STA OAMADDR
    LDA #$02
    STA OAMDMA
    RTI
.endproc

.import reset_handler

.export main
.proc main
    ; writing a palette
    LDX PPUSTATUS
    LDX #$3f
    STX PPUADDR
    LDX #$00
    STX PPUADDR
    load_palettes:
        LDA palettes,X
        STA PPUDATA
        INX
        CPX #$04
        BNE load_palettes

    ; writing sprite data
    LDX #$70
    load_sprites:
        LDA sprites,X
        STA $0200,X
        INX
        CPX
        BNE load_sprites

vblankwait:
    BIT PPUSTATUS
    BPL vblankwait

    LDA #%10010000 ; turn on NMI, using sprites in the first pattern table
    STA PPUCTRL
    LDA #%00011110 ; turn on screen
    STA PPUMASK
    forever:
        JMP forever
.endproc

.segment "VECTORS"
.addr nmi_handler, reset_handler, irq_handler

.segment "RODATA"
    palettes:
        .byte $29, $19, $09, $0f
    sprites:
        .byte $70, $05, $00, $80

.segment "CHR"
.incbin "graphics/graphics.chr"