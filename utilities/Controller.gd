extends Node

# **********************************************************************
#           Controller node
#
#  Handle input.
# **********************************************************************


const INPUT = {
	Released = 0,
	Just_Pressed = 1,
	Pressed = 2,
	Just_Released = 3
}

const KEY_TYPES = {
	Joystick_button = 0,
	Joystick_pad = 1,
	Keyboard = 2
}


# **********************************************************************
#           InpuStates Class
# **********************************************************************

class InputStates:

    var input_name
    var input_type

    var prev_state = false
    var current_state = false
    var input = false

    var output_state


    func _init(input, type):
        self.input_name = input
        self.input_type = type
        
    ### check the input and compare it with previous states
    func check():
        # TODO: Implement Joystick AGAIN!!! :(
        if self.input_type == KEY_TYPES.Keyboard:
            self.input = Input.is_key_pressed(self.input_name)
        self.prev_state = self.current_state
        self.current_state = self.input
        
        

        if not self.prev_state and not self.current_state:
            self.output_state = INPUT.Released

        if not self.prev_state and self.current_state:
            self.output_state = INPUT.Just_Pressed

        if self.prev_state and self.current_state:
            self.output_state = INPUT.Pressed

        if self.prev_state and not self.current_state:
            self.output_state = INPUT.Just_Released
        
        return self.output_state

# **********************************************************************
#           End of InpuStates Class
# **********************************************************************


var merged = {}
var buttons = {}

var keyboard_merge = {}
# End of Controller Config

# Add buttons to the Controller object. They must be a dictionary with the name of
# the buttons as key and the constant as value.
func add_buttons(keyboard):
    for key in keyboard:
        buttons[key] = InputStates.new(keyboard[key], KEY_TYPES.Keyboard)

# If there are combination of buttons, merge too buttons into one.
func merge_buttons(merge_dict):
    keyboard_merge = merge_dict

func merge(output, buttons):
    var key1 = output[buttons[0]]
    var key2 = output[buttons[1]]
    var button = buttons[0] + buttons[1]
    if key1 == key2: 
        if key1 == INPUT.Pressed:
            merged[button] = true
        return key1
    elif key1 == INPUT.Just_Pressed and key2 == INPUT.Pressed:
        return INPUT.Just_Pressed
    elif key1 == INPUT.Pressed and key2 == INPUT.Just_Pressed:
        return INPUT.Just_Pressed
    elif (key1 == INPUT.Just_Released and key2 == INPUT.Pressed) or (key1 == INPUT.Pressed and key2 == INPUT.Just_Released):
        return INPUT.Pressed
    elif not merged.has(button) or not merged[button]:
        return INPUT.Released        
    elif (key1 == INPUT.Pressed and key2 == INPUT.Released) or (key1 == INPUT.Released and key2 == INPUT.Pressed):
        merged[button] = false
        return INPUT.Just_Released
    elif (key1 == INPUT.Just_Released and key2 == INPUT.Released) or (key1 == INPUT.Released and key2 == INPUT.Just_Released):
        merged[button] = false
        return INPUT.Just_Released
    else:
        return INPUT.Released

func check():
    var output = {}
    for key in buttons:
        output[key] = buttons[key].check()

    for key in keyboard_merge:
        output[key] = merge(output, keyboard_merge[key])

    return output

# Pass the check() result, then an array with all the buttons involved in the or
# and then the key value to check true or false. 
func group_or(output, group, value):
    var result = false

    for i in group:
        result = result or output[i] == value
    return result