return {"codethread/qmk.nvim",
    opts = {
    name = 'LAYOUT_planck_grid', -- identify your layout name
        comment_preview = {
            keymap_overrides = {
                KC_BTN1 = 'R-Clic',
                KC_BTN2 = 'L-Click',
                KC_BTN3 = 'M-Click',
                KC_BTN4 = 'Prev',
                KC_BTN5 = 'Next',
                QK_MOUSE_ACCELERATION_0 = 'Mouse Acc 1',
                QK_MOUSE_ACCELERATION_1 = 'Mouse Acc 2',
                QK_MOUSE_ACCELERATION_2 = 'Mouse Acc 3',
                KC_UP = '^',
                KC_DOWN = 'v',
                KC_LEFT = '<',
                KC_RIGHT = '>',
                E_GRAV = 'è',
                E_ACUT = 'é',
                A_GRAV = 'à',
                CEDILL = 'ç',

            },
        },
        layout = { -- create a visual representation of your final layout
                'x x x x x x x x x x x x',
                'x x x x x x x x x x x x',
                'x x x x x x x x x x x x',
                'x x x x x x x x x x x x',
        },
    }
  }
